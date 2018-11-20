function zoom = tranzoom2dfit(im, bg, boxcarAv, rows, cols, camera, filename, fudge)
%tranzoom2dfit.m
%
% zoom = tranzoom2dfit(im, bg, boxcarAv, rows, cols, camera, filename, fudge)
%
% Fits 2D Gaussian surface to region of image <im> specified by <rows>, <cols> around peak
% Subtracts background image <bg> (supply any scalar value, eg 0, for no b/g subtraction)
% Vertical (1x2) boxcar averaging applied if <boxcarAv>=1
% Plots zoomed image for data, fit & residuals; and transects through peak
% Returns zoomed image
% If <filename> is specified then results are appended to file <filename>
% MM 6/00. Modified DML 28/7/00.
% 13/9/00 Added peak intensity estimate by summation of 'volume' under profile (as beamint.m)

global FitData

if (size(bg) ~= [1 1])
   disp('Subtracting background image');
   im = im - bg;
end

if (boxcarAv == 1)
   disp('Applying vertical boxcar average');
   boxcar = ones(1,2)/2;
   im = conv2(im,boxcar,'same');
end

if (exist('camera')~=1)
	hcal = 8.34; % um/pixel
	vcal = 8.22; % um/pixel
	disp(['Using pulnix calibration']);
else
	if strcmp(camera, 'pulnix')
		hcal = 8.34;
		vcal = 8.22;
		disp(['Using pulnix calibration']);
	elseif strcmp(camera, 'hitachi')
		hcal = 11.34;
		vcal = 27.05;
		disp(['Using hitachi calibration']);
	elseif strcmp(camera, 'eev')
		hcal = 15.5;
		vcal = 15.3;
		disp(['Using eev calibration: undersampled']);
   elseif strcmp(camera, 'eev8x')
      % DML calibration of EEV & imaging system together, using ions 26.7.00
		hcal = 1.44;
		vcal = 1.97;
		disp(['Using (EEV/8X imaging system/pixel clock sampling) calibration 26.7.00']);
	elseif strcmp(camera, 'maplin') % approx (& prob wrong) calibration DML 20.7.99
		hcal = 4.95;
		vcal = 4.86;
		disp(['Using Maplin calibration: APPROX ONLY!']);
    elseif strcmp(camera, 'andor') 
      % approx calibration for Andor (13um pixels) in 8x imaging system
        hcal = 1.6;
		vcal = 1.6;
		disp(['Using Andor DV437-BU2 in 8x imaging system nominal calibration']);
   elseif strcmp(camera, 'test')
		hcal = 1;
		vcal = 1;
		disp(['Test setting.  1:1 scale']);   
	else
		error(['Unrecognised camera : ',camera]);
	end
end
disp(['   calibration: (H,V) = (',num2str(hcal),',',num2str(vcal),') um/pixel']);

% Make sure data window exists
[a, I] = max(im);
[b, J] = max(a);
impeakX = I(J);
impeakY = J;
[maxX,maxY] = size(im);
zoomminX = round(impeakX-rows/2); if (zoomminX < 1),    zoomminX = 1;    end
zoommaxX = round(impeakX+rows/2); if (zoommaxX > maxX), zoommaxX = maxX; end
zoomminY = round(impeakY-cols/2); if (zoomminY < 1),    zoomminY = 1;    end
zoommaxY = round(impeakY+cols/2); if (zoommaxY > maxY), zoommaxY = maxY; end
disp(['max at (',num2str(impeakX),',',num2str(impeakY),') pixels; '...
      'fitting window = (',num2str(zoomminX),':',num2str(zoommaxX),',',...
      num2str(zoomminY),':',num2str(zoommaxY),')']);

% Guess starting parameters for 2D fit
disp(['Fitting 2D profile about maximum']);   
FitData 	= im(zoomminX:zoommaxX,zoomminY:zoommaxY);
% Fudged
if exist('fudge')
   FitData 	= im(zoomminX:zoommaxX,zoomminY:impeakY+10);
end
[dataSizeX dataSizeY] = size(FitData);
zoompeakX = impeakX - zoomminX + 1;
zoompeakY = impeakY - zoomminY + 1;
peakval 	 = FitData(zoompeakX,zoompeakY);
base 		 = FitData(1,1);
pars 		 = [base, peakval-base, zoompeakX, (zoommaxX-zoomminX)/4, zoompeakY, (zoommaxY-zoomminY)/4];
% Better guess for FWHM
% x FWHM
i = 1;
while (FitData(i,zoompeakY) < (peakval+base)/2) & (i<zoompeakX), i = i+1; end;
j = dataSizeX;
while (FitData(j,zoompeakY) < (peakval+base)/2) & (j>zoompeakX), j = j-1; end;
if (i<zoompeakX) & (j>zoompeakX) 
   hfwhmguess = (j - i);
   pars(4) = (hfwhmguess/2)^2 / log(2);
   hfwhmguess = hcal * hfwhmguess;
else
   hfwhmguess = 0;
end;
disp(['H info: ',num2str([i j zoompeakX peakval (peakval+base)/2])]);
% y FWHM
i = 1;
while (FitData(zoompeakX,i) < (peakval+base)/2) & (i<zoompeakY), i = i+1; end;
j = dataSizeY;
while (FitData(zoompeakX,j) < (peakval+base)/2) & (j>zoompeakY), j = j-1; end;
if (i<zoompeakY) & (j>zoompeakY) 
   vfwhmguess = (j - i);
   pars(6) = (vfwhmguess/2)^2 / log(2);
   vfwhmguess = vcal * vfwhmguess;
else
   vfwhmguess = 0;
end;
disp(['V info: ',num2str([i j zoompeakY peakval (peakval+base)/2])]);

pars(7) = pars(2);
pars(9) = 5;
pars(11) = 5;
pars(4) = 5;
pars(6) = 5;
pars(8) = pars(3)+7;
pars(10) = pars(5);

pars2 = pars;
% Call minimization routine
pars = fminsearch(@gaussfun2d2,pars)
pars = fminsearch(@gaussfun2d2,pars)
% Calculate fitted surface and residuals surface
% pars = pars2;
gexp = pars(1) + pars(2) * exp(-([1:dataSizeX] - pars(3)).^2/pars(4))' ...
   							 * exp(-([1:dataSizeY] - pars(5)).^2/pars(6)) + ...
                             pars(7) * exp(-([1:dataSizeX] - pars(8)).^2/pars(9))' ...
   							 * exp(-([1:dataSizeY] - pars(10)).^2/pars(11));
resids = FitData-gexp;

disp(['Cenres: ( ' num2str(pars(3)) ',' num2str(pars(5)) ') |  ( ' num2str(pars(8)) ',' num2str(pars(10)) ')']);


% Plotting: open figure
h = figure;
set(h, 'Position', [10 50 1000 750]);
% Set up +ve/-ve colourmap
cscale = 2*[1:127]' / 256;
aquared = [ 1-cscale 0*cscale 0*cscale ;
            0        0        0        ;
            0*cscale   cscale   cscale ;
            0        1        1         ]; % last line will not be used anyway
colormap(aquared); 
% Display a colour bar
subplot('position',[0.025 0.12 0.025 0.8]);
image([255:-1:0]');
axis off;
text(-0.2,-5,'+128');
text(-0.2,127.5,'0');
text(-0.2,263,'-128');

% Plot fit, residuals & data as surface plots
%subplot(2,3,5);
%mesh(FitData'); 
%axis([1 dataSizeX 1 dataSizeY min(min(FitData)) max(max(FitData))]);
%subplot(2,3,1);
%mesh(gexp'); 
%axis([1 dataSizeX 1 dataSizeY min(min(gexp)) max(max(gexp))]);
%subplot(2,3,4);
%mesh(resids');
%axis([1 dataSizeX 1 dataSizeY min(min(resids)) max(max(resids))]);

% Plot data, residuals & fit as image plots (scaled for +ve/-ve colourmap)
subplot(2,3,5);
implot = 128 + 127 * FitData / max(max(FitData));
image(implot');
title(['Image data (pk=',num2str(max(max(FitData)),4),')']);
subplot(2,3,1);
implot = 128 + 127 * gexp / max(max(gexp));
image(implot');
title(['Fitted surface (pk=',num2str(max(max(gexp)),4),')']);
subplot(2,3,4);
implot = 128 + 127 * resids / max(max(abs(resids)));
image(implot');
title(['Residuals surface (|pk|=',num2str(max(max(abs(resids))),4),')']);

% Plot data & (high-res) fit transects through nearest channel to FITTED peak 
% Note we account for any departure from true fitted peak in making theoretical profiles
nearfitposX = round(pars(3));
nearfitposY = round(pars(5));
dataX = FitData(:,nearfitposY);
x = [1:0.1:dataSizeX]; % i.e. 10x pixel resolution
fitX = pars(1) + pars(2) * exp(-(x - pars(3)).^2/pars(4))' ...
   							 * exp(-(nearfitposY - pars(5))^2/pars(6));
fitX = pars(1) + pars(2) * exp(-(x - pars(3)).^2/pars(4)) ...
   							 * exp(-(nearfitposY - pars(5)).^2/pars(6))'...
                  + pars(7) * exp(-(x - pars(8)).^2/pars(9)) ...
   							 * exp(-(nearfitposY - pars(10)).^2/pars(11))';
subplot(2,3,2);
plot(dataX,'b.'); hold on;
axis([1 dataSizeX min(dataX) max(dataX)]);
plot(x,fitX,'r-');
title('HORIZ transect');
dataY = FitData(nearfitposX,:);
y = [1:0.1:dataSizeY]; % i.e. 10x pixel resolution
fitY = pars(1) + pars(2) * exp(-(nearfitposX - pars(3))^2/pars(4)) ...
   							 * exp(-(y - pars(5)).^2/pars(6))'...
                  + pars(7) * exp(-(nearfitposX - pars(8))^2/pars(9)) ...
   							 * exp(-(y - pars(10)).^2/pars(11))';
subplot(2,3,6);
plot(dataY,'b.'); hold on;
axis([1 dataSizeY min(dataY) max(dataY)]);
plot(y,fitY,'r-');
view(90,90);
title('VERT transect');

% Calculate fitted FWHM's etc
hfwhm 	= hcal * 2 * sqrt(log(2) * pars(4));
vfwhm 	= vcal * 2 * sqrt(log(2) * pars(6));
hwspot 	= hfwhm/sqrt(2*log(2));
vwspot 	= vfwhm/sqrt(2*log(2));
base 		= pars(1);
amp 		= pars(2);
hpos 		= zoomminX + pars(3) - 1;
vpos 		= zoomminY + pars(5) - 1;  
rmsresid = sqrt(sum(sum(resids.^2))/(dataSizeX*dataSizeY));
pkresid  = max(max(abs(resids)));
pkintens = 2/(pi*hwspot*vwspot*1e-6); % intensity at peak calculated from fitted widths

% Estimate intensity at peak by summation of 'volume' under profile (like beamint.m)
% Average a 4-pixel wide strip around edges to get background, and subtract it from the image
strip = [ FitData(:,1:4)'            FitData(:,dataSizeY-3:dataSizeY)' ...
          FitData(1:4,5:dataSizeY-4) FitData(dataSizeX-3:dataSizeX,5:dataSizeY-4) ];
bg    = mean(mean(strip));
subData     = FitData - bg;					% subtract off fitted baseline
power       = sum(sum(subData));				% sum 'volume' under profile above baseline
centrepower = max(max(subData)) / power;	% fraction of power in pixel with max value
% Calculate intensity at that point, based on the pixel size
% NB: This step seems to neglect the possibility of dead space around the pixel,
% but it's not an error since any dead space appears in the same proportion
% over the whole profile: it just goes into the (unknown) overall constant of proportionality
% between the pixel value and the light power falling on that pixel.
centreintens = centrepower / ((hcal/1000)*(vcal/1000));

% Put text into final box of plot
subplot(2,3,3);
cla;
axis('off');
if (im(impeakX,impeakY)) > 200
   text(0.4,1.18,'*** IMAGE SATURATED! ***');
end;
if strcmp(camera, 'maplin')
   text(0.4,1.18,'*** CALIBRATION APPROX! ***');
end;
text(0,1.1,['RESULTS FOR <',inputname(1),'>:']);
text(0.4,1.0,'HORIZ');			text(0.8,1.0,'VERT');
text(0,0.9,'fwhm/um');			text(0.4,0.9,num2str(hfwhm,4));	text(0.8,0.9,num2str(vfwhm,4));
text(0,0.8,'w/um');				text(0.4,0.8,num2str(hwspot,4));	text(0.8,0.8,num2str(vwspot,4));
text(0,0.7,'pos/pixels');		text(0.4,0.7,num2str(hpos,4));	text(0.8,0.7,num2str(vpos,4));
text(0,0.6,'amplitude');		text(0.6,0.6,num2str(amp,4));
text(0,0.5,'baseline');			text(0.6,0.5,num2str(base,4));
text(0,0.4,'resids');			text(0.4,0.4,[num2str(rmsresid,3),'rms']);
										text(0.8,0.4,[num2str(pkresid,3), 'pk']);
text(0,0.3,'ellipticity');		text(0.6,0.3,num2str(hfwhm/vfwhm,4));
text(0,0.2,'peak int.(fit)');	text(0.6,0.2,[num2str(pkintens,4),' (mW/mm^2)/mW']);
text(0,0.1,'peak int.(sum)'); text(0.6,0.1,[num2str(centreintens,4),' (mW/mm^2)/mW']);

figure(h);
% Flush drawing events now
drawnow;

if (exist('filename')==1)
   dataResults = [hfwhm,vfwhm,hwspot,vwspot,hpos,vpos,amp,base,(hfwhm/vfwhm), ...
                  pkintens,centreintens];
   disp(['Saving to file "',filename,'"...']);
   outfile = [filename];
   [outpnt, msg]=fopen(outfile,'a+t');
   if (outpnt == -1) 
     disp(msg);
   end
   fprintf(outpnt,'%10s ',inputname(1));
   fprintf(outpnt,'%10.2f ',dataResults);
   fprintf(outpnt,'\n');
   fclose(outpnt);
end

% Return zoomed image data
zoom = FitData;

return;

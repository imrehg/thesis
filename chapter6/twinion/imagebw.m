function blue = imagebw(img)
%imageblu.m	Contrast-stretches an image
%
%	blue = imageblu(img)
%
%		stretches img over range 0-255
%     NB: now displays same orientation as camera (DML 24.3.99)

minimg	= min(min(img));
maximg	= max(max(img));
blue	= (img - minimg) * 255 / (maximg - minimg);
disp(['<blue> = (<img> - ',num2str(minimg),') * 255 / ',num2str(maximg - minimg)]);

% Set up useful colourmap
% bluescale	= [0:255]';
% bluescale	= [0*bluescale bluescale bluescale]/255;
bluescale	= [255:-1:0]';
bluescale	= [bluescale bluescale bluescale]/255;


% Display image
image(blue'); 
colormap(bluescale);

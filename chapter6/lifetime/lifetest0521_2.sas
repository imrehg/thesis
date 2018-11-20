data ions;
/*  infile 'c:\temp\lifeanalysis2\lifes.txt'; */
  infile 'c:/greg/lifes.txt';
  input life oven file rerun;
  if oven = 1 then do
    oven1 = 0;
	oven2 = 0;
   end;
   else if oven = 2 then do
    oven1 = 1;
	oven2 = 0;
   end;
   else if oven = 3 then do
    oven1 = 1;
	oven2 = 1;
   end;
  
run;

proc print data=ions;
run;


title 'Survival functions';
proc lifetest data=ions plots=(s);
  time life;
  strata oven;
/*  where tdep = 0; */
run;

title 'Lifereg';
proc lifereg data=ions;
	model life = oven1 oven2;
run;

title 'Proportional hazards';
proc phreg data=ions;
	model life = oven1 oven2/ rl;
run;

quit;

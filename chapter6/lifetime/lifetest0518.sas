data ions;
  Z='09'x;
/*  infile 'c:\temp\lifeanalysis\life0518.txt' DLM=Z;*/
  infile 'c:\greg\life0518.txt' DLM=Z;
  input life ovenoff num ;
  tr = 18;
   if num < tr then tdep=0;
   else tdep=1;
run;


title 'Survival functions';
proc lifetest data=ions plots=(s);
  time life;
  strata ovenoff tdep;
/*  where tdep = 0; */
run;

title 'Lifereg';
proc lifereg data=ions;
	model life = ovenoff tdep;
run;

title 'Proportional hazards';
proc phreg data=ions;
	model life = ovenoff tdep/ rl;
run;

quit;

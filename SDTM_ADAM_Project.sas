proc import datafile="/home/u64396252/CDISC/CRF_DM.xlsx"
dbms=xlsx
out=crf_dm
replace;
getnames=yes;
run;

ods pdf file="/home/u64396252/CDISC/Clinical_output.pdf";
/*Creating SDTM data*/
data sdtm;
set crf_dm;
DOMAIN="DM";
USUBJID=catx("-",STUDYID,SUBJID);
BRTHDTC=put(DOB,yymmdd10.);
RFICDTC=put(ICF_DATE,yymmdd10.);
    keep STUDYID DOMAIN USUBJID SITEID BRTHDTC RFICDTC SEX RACE ETHNIC COUNTRY;
run;

proc contents data=sdtm;
run;

proc print data=sdtm;
run;

/*Converting to XPT form*/
libname xpout xport "/home/u64396252/CDISC/dm.xpt";

data xpout.dm;
    set sdtm;
run;

/*Create ADaM ADSL*/
data adsl;
    set sdtm;

    AGE = intck('year', input(BRTHDTC,yymmdd10.), '01JAN2024'd);
    AGEU = "YEARS";
    ADSLFL = "Y";

    keep STUDYID USUBJID SEX AGE AGEU ADSLFL;
run;

/*Subject count*/
proc sql;
select count(distinct USUBJID) as Total_Subjects
from adsl;
quit;

/*Gender-wise count*/
proc freq data=adsl;
tables sex;
run;

/*age summary*/
proc means data=adsl mean min max;
    var AGE;
run;

data xpout.dm2;
set adsl;
run;

ods pdf close;





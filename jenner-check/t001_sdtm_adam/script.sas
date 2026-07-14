/* CRF_DM demographics — the six rows from CRF_DM.xlsx as an inline DATA step   */
/* so this bundle runs standalone (the original PROC IMPORT reads the workbook  */
/* from the SAS OnDemand home directory).  Downstream logic is unchanged.       */
data crf_dm;
    length STUDYID $8 SITEID 8 SUBJID $8 SEX $1 RACE $12 ETHNIC $24 COUNTRY $10;
    format DOB ICF_DATE yymmdd10.;
    input STUDYID $ SITEID SUBJID $ DOB :yymmdd10. SEX $ RACE $ ETHNIC $ COUNTRY $ ICF_DATE :yymmdd10.;
    datalines;
ABC101 1 001-001 1998-06-15 F ASIAN NOT_HISPANIC_OR_LATINO INDIA 2024-01-10
ABC101 1 001-002 1995-09-22 M ASIAN NOT_HISPANIC_OR_LATINO INDIA 2024-01-12
ABC101 2 002-001 1992-03-05 F ASIAN NOT_HISPANIC_OR_LATINO INDIA 2024-01-14
ABC101 2 002-002 1990-11-18 M ASIAN NOT_HISPANIC_OR_LATINO INDIA 2024-01-15
ABC101 3 003-001 1988-01-27 F ASIAN NOT_HISPANIC_OR_LATINO INDIA 2024-01-16
;
run;

ods pdf file="Clinical_output.pdf";
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
libname xpout xport "dm.xpt";

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

proc import out=aaa datafile="X:\xxx\xxx.xlsx"
            dbms=xlsx replace;
  sheet="xxx (sheet name)";
  getnames = YES;
run;

%let xxxlist= ;
data _null_;
  set aaa (where=(variable='abc' AND ICD9 ^= ''));
  call symput('xxxlist', trim(resolve('&xxxlist'))||' "'||trim(icd9)||'"');
run;
data _null_;
  set aaa (where=(variable='abc' AND ICD10 ^= ''));
  call symput('xxxlist', trim(resolve('&xxxlist'))||' "'||trim(icd10)||'"');
run;
%put &xxxlist;

proc sql noprint;
  select ICD9, ICD10
    into :xxxlist_icd9 separated by ' ',
          xxxlist_icd10 separated by ' '
    from aaa
    where variable = 'abc';
quit;
%put &xxxlist_icd9;
%put &xxxlist_icd10;

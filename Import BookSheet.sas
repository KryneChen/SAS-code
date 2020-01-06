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

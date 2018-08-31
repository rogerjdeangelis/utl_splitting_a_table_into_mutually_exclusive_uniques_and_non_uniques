Splitting a table into uniques and non-uniques

    Two solutions

        1. proc sort
        2. Table If first.name and last.name

SAs Forum
https://tinyurl.com/y7vrw5od
https://communities.sas.com/t5/SAS-Programming/How-to-remove-IDs-with-deuplicates-entirely-without-keeping-any/m-p/491307


Novinosrin profile
https://communities.sas.com/t5/user/viewprofilepage/user-id/138205


INPUT
=====

 WORK.HAVE total obs=9

   NAME       SEX    AGE    HEIGHT    WEIGHT

   Alfred      M      14     69.0      112.5
   Alice       F      13     56.5       84.0

   Barbara     F      13     65.3       98.0  Duplicate group
   Barbara     F      13     65.3       98.0

   Carol       F      14     62.8      102.5
   Henry       M      14     63.5      102.5

   James       M      12     57.3       83.0  Duplicate group
   James       M      12     57.3       83.0

   Jane        F      12     59.8       84.5


 EXAMPLE OUTPUT
 --------------

  WORK.UNIQUEKEY total obs=5

    NAME     SEX    AGE    HEIGHT    WEIGHT

   Alfred     M      14     69.0      112.5
   Alice      F      13     56.5       84.0
   Carol      F      14     62.8      102.5
   Henry      M      14     63.5      102.5
   Jane       F      12     59.8       84.5

  WORK.NOUNIQUEKEY total obs=4

    NAME      SEX    AGE    HEIGHT    WEIGHT

   Barbara     F      13     65.3       98
   Barbara     F      13     65.3       98

   James       M      12     57.3       83
   James       M      12     57.3       83


PROCESS
=======

 1. proc sort

     proc sort data = have
               out  = nonuniquekey
               uniqueout = uniquekey nouniquekey ;
     by name ;
     run;quit;

 2. Table If first.name and last.name

    proc sort data=have;
    by name;
    run;quit;

    data uniquekey nouniquekey;
     set have;
     by name;
    if first.name and last.name then output uniquekey;
    else output nouniquekey;
    run;quit;
*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data have;
  set sashelp.class(obs=7);
  if mod(_n_,3)=0 then output;
  output;
run;quit;



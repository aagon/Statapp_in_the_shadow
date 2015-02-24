/*Constitution des bibliothèques nécessaires à l'importation, à la concaténation, et au traitement des données*/

%macro preparation;
  
%do j=1 %to 24;
  libname per&j. "D:\Data\SAS\Donnees_modifiees\Periode&j.";
  libname samper&j. "D:\Data\SAS\Donnees_modifiees\SamPeriode&j.";
%end;

libname allper "D:\Data\SAS\Donnees_modifiees\Allperiods";
libname annexe "D:\Data\SAS\Donnees_modifiees\annexe";
libname samall "D:\Data\SAS\Donnees_modifiees\Samallperiods";

%mend preparation;

%preparation

/*Selection des banques à garder, selon le critère retenu*/

PROC IMPORT OUT=work.etalon DATAFILE="C:\Users\Rico\Desktop\Donnees_brutes\1\File8.txt" DBMS=TAB REPLACE;
	GETNAMES=YES;
	DATAROW=3;
RUN;

DATA work.etalon;
	SET work.etalon;
	KEEP idrssd rcon2170;
RUN;

PROC UNIVARIATE DATA=work.etalon;
	VAR rcon2170;
RUN;
/*Le total de la variable rcon2170 est donné par 7949523445*/
/*On calcule donc la fréquence, puis la fréquence cumulée*/

PROC SORT DATA=work.etalon;
	BY DESCENDING rcon2170;
RUN;

DATA work.etalon;
	SET work.etalon;
	rcon2170freq=rcon2170*100/7949523445;
RUN;

DATA work.etalon;
	RETAIN rcon2170cumfreq 0;
	SET work.etalon;
	rcon2170cumfreq=rcon2170cumfreq+rcon2170freq;
RUN;

/*Le critère est de retenir les 300 plus grosses banques, qui totalisent 82% des actifs*/

DATA work.etalon;
	SET work.etalon;
	IF rcon2170cumfreq <= 83 THEN b2o = 1;
	ELSE b2o=0;
RUN;

PROC SORT DATA=work.etalon;
	BY idrssd;
RUN;

%macro importation;

/*importation des tables entières dans les bibliothèques per et des échantillons dans les bibliothèques samper*/

%do j=1 %to 24;
	%do i=1 %to 40;
		PROC IMPORT OUT=Per&j..Datapart&i DATAFILE="C:\Users\Rico\Desktop\Donnees_brutes\&j.\File&i..txt"
			DBMS=TAB REPLACE;
			GETNAMES=YES;
			DATAROW=3;
		RUN;
		
		DATA Per&j..Datapart&i;
			SET Per&j..Datapart&i;
			WHERE idrssd ^=.;
		RUN;
		
		DATA SamPer&j..Datapart&i;
			MERGE Per&j..Datapart&i work.etalon;
			BY idrssd;
		RUN;
		
		DATA SamPer&j..Datapart&i;
			SET SamPer&j..Datapart&i;
			WHERE b2o=1;
		RUN;
	%end;
%end;

%mend importation;
%importation

%macro concatenation;

%do j=1 %to 24;
	%do i=1 %to 40;
		Proc sort data=Per&j..datapart&i;
			by idrssd;
		Run;
	%end;
%end;

%do j=1 %to 6;
	Data Per&j..Datatot;
		merge Per&j..datapart1-Per&j..datapart35;
		by idrssd;
	run;
%end;

Data Per8.datatot;
	merge Per8.datapart1-Per8.datapart35;
	by idrssd;
run;

data Per7.datatot;
	merge Per7.datapart1-Per7.datapart36;
	by idrssd;
run;

%do j= 9 %to 17;
	Data Per&j..Datatot;
		merge Per&j..datapart1-Per&j..datapart36;
		by idrssd;
	run;
%end;

%do j=18 %to 19;
	Data Per&j..Datatot;
		merge Per&j..datapart1-Per&j..datapart39;
		by idrssd;
	run;
%end;

%do j=20 %to 24;
	Data Per&j..Datatot;
		merge Per&j..datapart1-Per&j..datapart40;
		by idrssd;
	run;
%end;

%mend concatenation;

%concatenation;


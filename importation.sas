%macro importation;
%do j=1 %to 24;
	libname per&j. "D:\Data\SAS\Donnees_modifiees\Periode&j.";
%end;

%do j=1 %to 24;
	%do i=1 %to 40;
		PROC IMPORT
		OUT=Per&j..Datapart&i
		DATAFILE="C:\Users\Rico\Desktop\Donnees_brutes\&j.\File&i..txt"
		DBMS=TAB REPLACE;
		GETNAMES=YES;
		DATAROW=2;
		RUN;
	%end;
%end;

%mend importation;
%importation

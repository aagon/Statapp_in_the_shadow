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

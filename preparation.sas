/*Constitution des bibliothèques nécessaires à l'importation, à la concaténation, et au traitement des données*/

%macro preparation;
  
%do j=1 %to 24;
  libname per&j. "D:\Data\SAS\Donnees_modifiees\Periode&j.";
%end;

libname allper "D:\Data\SAS\Donnees_modifiees\Allperiods";
libname annexe "D:\Data\SAS\Donnees_modifiees\annexe";

%mend preparation;

%preparation

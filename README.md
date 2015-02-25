# Statapp_in_the_shadow
Data analysis of the FFIEC database

These bits of code are to be compiled in either SAS or STATA (it will be specified. Do files are for stata, sas files for sas).

Prerequisits : the txt data downloaded from FFIEC should be of the following form :
One folder for each period, named 1, 2, ... , 24
Each txt file inside every each folder must be called File1, File2, etc...
Remove readme file from each folder.
A few utilities could help you doing that effortlessly : antrenamer, or even a batch command file

Afterwards, just compile the three macros inside the sas file from the master branch.
Make sure the libnames refer to an existing folder. If not create them.
24 folders, one for each period, plus 24 others for the retained sample of each period, plus one for all periods, plus one for all periods, only for the sample, plus one called "annexe".

The sas file in the master branch should give you : every txt file converted into sas database, both in its entire and sample form, plus a concatenated version, with all variables (relatively to the period) in it. You should then have 24 datasets with all the information in it, and the subset version.

It is for the time being impossible to put these 24 databases together, as the amount and type of variables change significantly over the period.

Concatenation is only possible on a subset of variables that are present and nonidentical to 0 in all periods. I have not been able to determine the biggest subset that respects that condition. So the concatenation will only be possible once one valid subset has been determined.

Vol=input('vol water used to dissolve acid & base components \n');
Base=input('mol amount of Na2HPO4 base compontet \n');
Acid=input('mol amount of NaH2PO4 acid compontet \n');
MolarAcid=Acid/Vol;     MolarBase=Base/Vol;
IS=(MolarAcid*0.5*(3*1+1*9))+(MolarBase*0.5*(3*1+1*9));
% 3*1= Na + H + H (1+)
% 3*1= Na + Na + H (1+)
% 1*9=PO4(3-)
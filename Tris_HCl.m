%calculate Volume of HCl and Tris to be added to form final volume of 20ml
FinalVol=20;
VolHCl=input('HCl Volume to be added to Tris \n');
PercentHCL=VolHCl/(VolHCl+50); 
PercentTris=50/(VolHCl+50);
VfHCl=PercentHCL*FinalVol;
VfTris=PercentTris*FinalVol;
fprintf('add %6.4f Tris with %6.4f HCl \n',VfTris,VfHCl)
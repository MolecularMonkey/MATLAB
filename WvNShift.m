function [Wavenumber,ShiftedWavenumber,Shift,NatureOfShift] = WvNShift(Wavelength,ShiftedWavelength)
%WvNShift gets the wavelength (nm) of a peak and its shifted value and calculates thier corresponding Wavenumber in 1/cm 
%   Input Unit:  nanometer (nm)/ / / Output Unit: 1/Cm
lamb1=Wavelength;
lamb2=ShiftedWavelength;
Lamb1Cm=lamb1*1e-7;
Lamb2Cm=lamb2*1e-7;
OpticFreq1=1/Lamb1Cm;   Wavenumber=OpticFreq1;
OpticFreq2=1/Lamb2Cm;   ShiftedWavenumber=OpticFreq2;
Shift=OpticFreq2-OpticFreq1;
diff=lamb2-lamb1;
if diff>0
    NatureOfShift='Red Shift';   
elseif diff<0
    NatureOfShift='Blue Shift';   
elseif diff==0
    NatureOfShift='No Shift';
else
    error('End of the World');    
end
%outputArg1 = Wavelength;
%outputArg2 = inputArg2;
end


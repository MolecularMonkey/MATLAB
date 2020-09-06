
function [Wavenumber] = wvl2wvn(Wavelength)
%WVL2WVN input: Wavelength(nm) | Output: Optical Frequency or Wavenumber(1/cm)
Lamb1Cm=Wavelength.*1e-7;
Wavenumber=1./Lamb1Cm;
end


function [WavenumberSpectrum] = wvlspec2wvn(WaveLengthSpectrum)
%WVLSPEC2WVN Summary of this function goes here
Wavelength=WaveLengthSpectrum(1,:);
Lamb1Cm=Wavelength.*1e-7;
Wavenumber=fliplr(1./Lamb1Cm);
WavenumberSpectrum(1,:)=Wavenumber;
WavenumberSpectrum(2,:)=fliplr(WaveLengthSpectrum(2,:));
end


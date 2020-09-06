function [WavenumberSpectrum] = wvlspec2wvn_f(WaveLengthSpectrum)
%WVLSPEC2WVN Summary of this function goes here

%first figure
figure(107);
plot(WaveLengthSpectrum(1,:),WaveLengthSpectrum(2,:));
title('Spectra in wavelength')
ylabel('Intensity (a.u.)')
xlabel('Wavelength (nm)')

Wavelength=WaveLengthSpectrum(1,:);
Lamb1Cm=Wavelength.*1e-7;
Wavenumber=fliplr(1./Lamb1Cm);
WavenumberSpectrum(1,:)=Wavenumber;
WavenumberSpectrum(2,:)=fliplr(WaveLengthSpectrum(2,:));
%second Figure
figure(108);
plot(WavenumberSpectrum(1,:),WavenumberSpectrum(2,:));
title('Spectra in wavenumber')
ylabel('Intensity (a.u.)')
xlabel('Optical Frequency (1/cm)')
end


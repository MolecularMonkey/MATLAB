function [coeff,SubstractedSpectraWvnm,SubstractedSpectraWvlg,Exc1,Exc2]=SSaS(RRRefBU,ExcitationWaveLength1,ExcitationWaveLength2,coeff,figurehandle1,figurehandle2)
%ExcitationWaveLength1=input('Enter the Excitation Wavelength (nm) of your MAIN species');
%ExcitationWaveLength2=input('Enter the Excitation Wavelength (nm) of the INTERFERENCE');
% Spectrum Substraction and Save
% Initialguess(optional): initial default value for Coefficient
% MultipleTime:(optional) value other than 0 if you want to be able to give other than one guess 0 if only one guess 
% figurehandle 1&2 optional
if ~exist('figurehandle1','var')
    figurehandle1=1009;
else
    figurehandle1=ceil(abs(figurehandle1));
end
if ~exist('figurehandle2','var')
    figurehandle2=1010;
else
    figurehandle2=ceil(abs(figurehandle2));
end
if  figurehandle2==figurehandle1
    disp('two same figure handle so changed one of them by adding +one')
    figurehandle2=figurehandle1+1;
end
    if coeff>1 || coeff<0
    error('I think coefficient Value should be positive less than one!')
    else
%% This m-file Substract the spectra of one Excitation from that of another excitation multiplied by a ratio and saved the data  
[WaveLengthSpectrum1,WavenumberSpectrum1,Exc1] = slicing2Dexc(RRRefBU,ExcitationWaveLength1);
[WaveLengthSpectrum2,WavenumberSpectrum2,Exc2] = slicing2Dexc(RRRefBU,ExcitationWaveLength2);
figure(figurehandle1)
% Wavenumber 
subplot(3,1,1)
plot(WavenumberSpectrum1(1,:),WavenumberSpectrum1(2,:))
 title({'Treated';['Spectra 1, Exc: ',num2str(Exc1)]})
 xlim([wvl2wvn(1440) wvl2wvn(840)])
subplot(3,1,2)
plot(WavenumberSpectrum2(1,:),WavenumberSpectrum2(2,:))
title(['Spectra 2, Exc: ',num2str(Exc2)])
ylabel('Intensity')
xlim([wvl2wvn(1440) wvl2wvn(840)]);
% Wavelength 
figure(figurehandle2)
subplot(3,1,1)
plot(WaveLengthSpectrum1(1,:),WaveLengthSpectrum1(2,:))
 title({'Treated';['Spectra 1, Exc: ',num2str(Exc1)]})
  xlim([840 1440]);
 subplot(3,1,2)
plot(WaveLengthSpectrum2(1,:),WaveLengthSpectrum2(2,:))
title(['Spectra 2, Exc: ',num2str(Exc2)])
ylabel('Intensity')
 xlim([840 1440]);
    % Wavelength
    figure(figurehandle2)
    SubstractedSpectraWvlg(1,:)=WaveLengthSpectrum1(1,:);
    SubstractedSpectraWvlg(2,:)=WaveLengthSpectrum1(2,:)-WaveLengthSpectrum2(2,:).*coeff;
    subplot(3,1,3); xlabel('Wavelength (nm)')
     xlim([840 1440]);
    plot(SubstractedSpectraWvlg(1,:),SubstractedSpectraWvlg(2,:));title('Spectra 1 after Substraction')
    xlabel('Wavelength (nm)')
    %Wavenumber
    SubstractedSpectraWvnm(1,:)=WavenumberSpectrum1(1,:);
    SubstractedSpectraWvnm(2,:)=WavenumberSpectrum1(2,:)-WavenumberSpectrum2(2,:).*coeff;
    figure(figurehandle1);subplot(3,1,3); xlabel('Wavelength (nm)')
    plot(SubstractedSpectraWvnm(1,:),SubstractedSpectraWvnm(2,:));title('Spectra 1 after Substraction');
    xlabel('Wavenumber (1/cm)')
    xlim([wvl2wvn(1440) wvl2wvn(840)])
    end  
end



function [coeff1,coeff2,SubstractedSpectraWvnm,SubstractedSpectraWvlg,Exc1,Exc2,Exc3]=SSbSm(RRRefBU,ExcitationWaveLength1,ExcitationWaveLength2,ExcitationWaveLength3,Initialguess,Initialguess1,figurehandle1,figurehandle2,MultipleTime)
% Spectrum Substraction and Save
% Initialguess(optional): initial default value for Coefficient
% MultipleTime:(optional) value other than 0 means that you want to be able to make multiple guesses 
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
%% This m-file Substract the spectra of one Excitation from that of another excitation multiplied by a ratio and saved the data  
[WaveLengthSpectrum1,WavenumberSpectrum1,Exc1] = slicing2Dexc(RRRefBU,ExcitationWaveLength1);
[WaveLengthSpectrum2,WavenumberSpectrum2,Exc2] = slicing2Dexc(RRRefBU,ExcitationWaveLength2);
[WaveLengthSpectrum3,WavenumberSpectrum3,Exc3] = slicing2Dexc(RRRefBU,ExcitationWaveLength3);
figure(figurehandle1)
% Wavenumber 
subplot(3,2,1);
plot(WavenumberSpectrum1(1,:),WavenumberSpectrum1(2,:))
title(['Spectra 1, Exc: ',num2str(Exc1)])
xlim([wvl2wvn(1440) wvl2wvn(840)]);
subplot(3,2,3);
plot(WavenumberSpectrum2(1,:),WavenumberSpectrum2(2,:))
title(['Spectra 2, Exc: ',num2str(Exc2)])
ylabel('Intensity')
xlim([wvl2wvn(1440) wvl2wvn(840)]);
subplot(3,2,5);
plot(WavenumberSpectrum3(1,:),WavenumberSpectrum3(2,:))
title(['Spectra 3, Exc: ',num2str(Exc3)])
xlabel('Wavenumber (1/cm)')
xlim([wvl2wvn(1440) wvl2wvn(840)]);
subplot(2,2,2)
plot(WavenumberSpectrum1(1,:),WavenumberSpectrum1(2,:))
title({'Pristine';['Spectra 1, Exc: ',num2str(Exc1)]})
xlim([wvl2wvn(1440) wvl2wvn(840)]);
% Wavelength 
figure(figurehandle2)
subplot(3,2,1);
plot(WaveLengthSpectrum1(1,:),WaveLengthSpectrum1(2,:))
title(['Spectra 1, Exc: ',num2str(Exc1)]);
xlim([840 1440]);
subplot(3,2,3);
plot(WaveLengthSpectrum2(1,:),WaveLengthSpectrum2(2,:))
ylabel('Intensity')
title(['Spectra 2, Exc: ',num2str(Exc2)])
xlim([840 1440]);
subplot(3,2,5);
plot(WaveLengthSpectrum3(1,:),WaveLengthSpectrum3(2,:))
title(['Spectra 3, Exc: ',num2str(Exc3)])
xlabel('Wavelength (nm)')
xlim([840 1440]);
subplot(2,2,2)
plot(WaveLengthSpectrum1(1,:),WaveLengthSpectrum1(2,:))
title({'Pristine';['Spectra 1, Exc: ',num2str(Exc1)]});
xlim([840 1440]);
prompt = {'<FinalSpectra= Spectra1 - Coeff1 x Spectra2 -  Coeff2 x Spectra3>   Coefficient 1?','Coefficient 2?','Enter 0 to stop repeating this code'};
dlgtitle = '<FinalSpec = Spec1 - C1.Spec2 - C2.Spec3>';
dims = [1 75];
if  ~exist('MultipleTime','var') 
    definput{1,3} = num2str(1);
else
    definput{1,3} = num2str(MultipleTime);
end

if ~exist('Initialguess','var') && ~exist('Initialguess1','var') 
definput{1,1}=num2str(0.1);
definput{1,2}=num2str(0.1);
elseif exist('Initialguess','var') && exist('Initialguess1','var') 
definput{1,1}=num2str(Initialguess);
definput{1,2}=num2str(Initialguess1);
elseif ~exist('Initialguess','var') && exist('Initialguess1','var')
    definput{1,1}=num2str(0.1);
    definput{1,2}=num2str(Initialguess1);
elseif exist('Initialguess','var') && ~exist('Initialguess1','var')
    definput{1,1}=num2str(Initialguess);
    definput{1,2}=num2str(0.1);
end

countt=1;exitflag=0;
while ~exitflag
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    coeff1=str2double(answer{1,1});
    coeff2=str2double(answer{2,1});
    if coeff1>1 || coeff1<0 || coeff2>1 || coeff2<0
    disp('I think coefficient Value should be positive less than one!')
    else
    % Wavelength
    figure(figurehandle2)
    SubstractedSpectraWvlg(1,:)=WaveLengthSpectrum1(1,:);
    SubstractedSpectraWvlg(2,:)=WaveLengthSpectrum1(2,:)-WaveLengthSpectrum2(2,:).*coeff1-WaveLengthSpectrum3(2,:).*coeff2;
    subplot(2,2,4)
    plot(SubstractedSpectraWvlg(1,:),SubstractedSpectraWvlg(2,:));title('Spectra 1 after Substraction')
    xlabel('Wavelength (nm)')
    xlim([840 1440]);
    %Wavenumber
    SubstractedSpectraWvnm(1,:)=WavenumberSpectrum1(1,:);
    SubstractedSpectraWvnm(2,:)=WavenumberSpectrum1(2,:)-WavenumberSpectrum2(2,:).*coeff1-WavenumberSpectrum3(2,:).*coeff2;
    figure(figurehandle1);subplot(2,2,4); 
    plot(SubstractedSpectraWvnm(1,:),SubstractedSpectraWvnm(2,:));title('Spectra 1 after Substraction')
    xlabel('Wavenumber (1/cm)')
    xlim([wvl2wvn(1440) wvl2wvn(840)]);
    if ~str2double(answer{3,1})    
            disp(['Accepted Value of Coefficient1 is ',answer{1,1},'And Coefficient 2 is',answer{2,1}])
            disp(['Round #',num2str(countt)])
            exitflag=1;
    end
        definput{1,1}=answer{1,1};
        definput{1,2}=answer{2,1};
        countt=countt+1;
    end
end

%function
end



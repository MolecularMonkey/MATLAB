function [coeff,SubstractedSpectraWvnm,SubstractedSpectraWvlg,Exc1,Exc2]=SSaSm(RRRefBU,ExcitationWaveLength1,ExcitationWaveLength2,Initialguess,figurehandle1,figurehandle2,MultipleTime)
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
figure(figurehandle1)
% Wavenumber 
subplot(3,1,1)
plot(WavenumberSpectrum1(1,:),WavenumberSpectrum1(2,:))
title({'Pristine';['Spectra 1, Exc: ',num2str(Exc1)]})
xlim([wvl2wvn(1440) wvl2wvn(840)]);
subplot(3,1,2)
plot(WavenumberSpectrum2(1,:),WavenumberSpectrum2(2,:))
title(['Spectra 2, Exc: ',num2str(Exc2)])
ylabel('Intensity')
xlim([wvl2wvn(1440) wvl2wvn(840)]);
% Wavelength 
figure(figurehandle2)
subplot(3,1,1)
plot(WaveLengthSpectrum1(1,:),WaveLengthSpectrum1(2,:))
title({'Pristine';['Spectra 1, Exc: ',num2str(Exc1)]});
xlim([840 1440]);
subplot(3,1,2);
plot(WaveLengthSpectrum2(1,:),WaveLengthSpectrum2(2,:))
ylabel('Intensity')
xlim([840 1440]);
% ----
title(['Spectra 2, Exc: ',num2str(Exc2)])
prompt = {'<SubstractedSpectra = Spectra1 - Coeff x Spectra2 >   Coefficient?','Enter 0 to stop the code'};
dlgtitle = 'Coefficient?';
dims = [1 60];
if ~exist('Initialguess','var') && ~exist('MultipleTime','var')
definput = {'0.09','1'};
elseif exist('Initialguess','var') && exist('MultipleTime','var')
definput{1,1}=num2str(Initialguess);
definput{1,2} = num2str(MultipleTime);
elseif exist('Initialguess','var') && ~exist('MultipleTime','var')
    definput{1,1}=num2str(Initialguess);
    definput{1,2} = '1';
else
    definput{1,1}='0.1';
    definput{1,2} = num2str(MultipleTime);
end
countt=1;exitflag=0;
while ~exitflag
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    coeff=str2double(answer{1,1});
    if coeff>1 || coeff<0
    disp('I think coefficient Value should be positive less than one!')
    else
    % Wavelength
    figure(figurehandle2)
    SubstractedSpectraWvlg(1,:)=WaveLengthSpectrum1(1,:);
    SubstractedSpectraWvlg(2,:)=WaveLengthSpectrum1(2,:)-WaveLengthSpectrum2(2,:).*coeff;
    subplot(3,1,3); 
    plot(SubstractedSpectraWvlg(1,:),SubstractedSpectraWvlg(2,:));title('Spectra 1 after Substraction')
    xlabel('Wavelength (nm)')
    xlim([840 1440]);
    %Wavenumber
    SubstractedSpectraWvnm(1,:)=WavenumberSpectrum1(1,:);
    SubstractedSpectraWvnm(2,:)=WavenumberSpectrum1(2,:)-WavenumberSpectrum2(2,:).*coeff;
    figure(figurehandle1);subplot(3,1,3); 
    plot(SubstractedSpectraWvnm(1,:),SubstractedSpectraWvnm(2,:));title('Spectra 1 after Substraction')
    xlabel('Wavenumber (1/cm)')
    xlim([wvl2wvn(1440) wvl2wvn(840)])
    if ~str2double(answer{2,1})
      %SSSSatisfied=questdlg('Are you satisfied w/ the result?',[answer{1,1},' for Coefficient?'],'Yes?','No?','No?');
      %switch SSSSatisfied
       % case 'Yes?'
       %    disp(['Accepted Value of Coefficient is ',answer{1,1}])
       %     disp(['Round #',num2str(countt)])
       %     exitflag=1;
       %  case 'No?'
      %end        
            disp(['Accepted Value of Coefficient is ',answer{1,1}])
            disp(['Round #',num2str(countt)])
            exitflag=1;
    end
        definput{1,1}=answer{1,1};
        countt=countt+1;
    end
end

%function
end
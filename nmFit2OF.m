[fitfile,fitpath] = uigetfile('*.xls');
[num,txt,~] =xlsread([fitpath,fitfile]);
[~,b]=size(txt);
FittedSpectra{2,b}=0;
figure(254)
subplot(2,1,1)
p=plot(num(:,1),num(:,2),num(:,3),num(:,4),'.');
p(1).LineWidth = 3;
xlabel('Wavelength (nm)')
ylabel('Intensity (a.u.)')
title('Observed(---) vs. Generated(. . .)')
        % saving this part of spectra (observed and generated)
        % observed
WaveLengthSpectrum_obs(1,:)=num(:,1);
WaveLengthSpectrum_obs(2,:)=num(:,2);
FittedSpectra{1,1}{1,2}='Observed Spectra';
FittedSpectra{1,1}{1,3}='Wavelength nm';
FittedSpectra{1,1}{1,1}=WaveLengthSpectrum_obs;
WaveNumberSpec_obs=wvlspec2wvn(WaveLengthSpectrum_obs);
FittedSpectra{2,1}{1,2}='Observed Spectra';
FittedSpectra{2,1}{1,3}='Wavenumber (1/cm)';
FittedSpectra{2,1}{1,1}=WaveNumberSpec_obs;
        % generated
WaveLengthSpectrum_gen(1,:)=num(:,3);
WaveLengthSpectrum_gen(2,:)=num(:,4);
FittedSpectra{1,2}{1,2}='Generated Spectra';
FittedSpectra{1,2}{1,3}='Wavelength nm';
FittedSpectra{1,2}{1,1}=WaveLengthSpectrum_gen;
WaveNumberSpec_gen=wvlspec2wvn(WaveLengthSpectrum_gen);
FittedSpectra{2,2}{1,2}='Observed Spectra';
FittedSpectra{2,2}{1,3}='Wavenumber (1/cm)';
FittedSpectra{2,2}{1,1}=WaveNumberSpec_gen;
    %rest of plotting
subplot(2,1,2)
p_2=plot(num(:,3),num(:,4));
xlabel('Wavelength (nm)')
ylabel('Intensity (a.u.)')
title('fitted peaks')
hold on
FittedSpectra{1,b}='Wavelength nm';
FittedSpectra{2,b}='Wavenumber (1/cm)';
for ii=5:b
    %ploting part
    strring=['p_',num2str(ii),'=plot(num(:,3),num(:,',num2str(ii),'));'];
    eval(strring);
    sstring=['WaveLengthSpectrum_',num2str(ii-4),'(1,:)=num(:,3);'];
    ssstrng=['WaveLengthSpectrum_',num2str(ii-4),'(2,:)=num(:,',num2str(ii),');'];
    eval(ssstrng); eval(sstring);
    %saving part
    FittedSpectra{1,ii-2}{1,2}=['Spectra of species No.',num2str(ii-4)];
    FittedSpectra{1,ii-2}{1,3}='Wavelength nm';
    eval(['FittedSpectra{1,ii-2}{1,1}=WaveLengthSpectrum_',num2str(ii-4),';']);
    %Converting to Wavenumber and saving those as well
    eval(['WaveNumberSpec_',num2str(ii-4),'=wvlspec2wvn(WaveLengthSpectrum_',num2str(ii-4),');']);
    FittedSpectra{2,ii-2}{1,2}=['Spectra of species No.',num2str(ii-4)];
    FittedSpectra{2,ii-2}{1,3}='Wavenumber (1/cm)';
    eval(['FittedSpectra{2,ii-2}{1,1}=WaveNumberSpec_',num2str(ii-4),';']);
end
hold off
% Ploting part the optical frequency part
figure(253)
subplot(2,1,1)
OP=plot(WaveNumberSpec_obs(1,:),WaveNumberSpec_obs(2,:),WaveNumberSpec_gen(1,:),WaveNumberSpec_gen(2,:),'.');
OP(1).LineWidth = 3;
xlabel('Optical Frequency (1/cm)')
ylabel('Intensity (a.u.)')
title('Observed(---) vs. Generated(. . .)')
subplot(2,1,2)
OP1=plot(WaveNumberSpec_gen(1,:),WaveNumberSpec_gen(2,:));
title('fitted peaks')
xlabel('Optical Frequency (1/cm)')
ylabel('Intensity (a.u.)')
hold on
for ii=5:b
       strring=['op_',num2str(ii),'=plot(WaveNumberSpec_',num2str(ii-4),'(1,:),WaveNumberSpec_',num2str(ii-4),'(2,:));'];
       eval(strring)  
end
hold off


for ii=5:b
    %FWHM for wavenumber spectrum
    stttr=['x=WaveNumberSpec_',num2str(ii-4),'(1,:);y=WaveNumberSpec_',num2str(ii-4),'(2,:);'];
    eval(stttr)
    OF_width=fwhm(x,y);
    [~,maxInd]=max(y);
    PeakWN=x(maxInd);
    % saving part
    FittedSpectra{2,ii-2}{1,4}='Peak Wave number (1/cm)';
    FittedSpectra{2,ii-2}{2,4}=PeakWN;
    FittedSpectra{2,ii-2}{1,5}='FWHM (1/cm)';
    FittedSpectra{2,ii-2}{2,5}=OF_width;
    
    % saving in the corresponding portion
    FittedSpectra{1,ii-2}{3,4}='Peak Wave number (1/cm)';
    FittedSpectra{1,ii-2}{4,4}=PeakWN;
    FittedSpectra{1,ii-2}{3,5}='FWHM (1/cm)';
    FittedSpectra{1,ii-2}{4,5}=OF_width;
end

for ii=5:b
    %FWHM for wavelength spectrum
    stttr=['x=WaveLengthSpectrum_',num2str(ii-4),'(1,:);y=WaveLengthSpectrum_',num2str(ii-4),'(2,:);'];
    eval(stttr)
    WL_width=fwhm(x,y);
    [~,maxInd]=max(y);
    PeakWL=x(maxInd);
    % saving part
    FittedSpectra{1,ii-2}{1,4}='Peak Wavelenght (nm)';
    FittedSpectra{1,ii-2}{2,4}=PeakWL;
    FittedSpectra{1,ii-2}{1,5}='FWHM (nm)';
    FittedSpectra{1,ii-2}{2,5}=WL_width;
    
    % saving in the corresponding portion
    FittedSpectra{2,ii-2}{3,4}='Peak Wavelenght (nm)';
    FittedSpectra{2,ii-2}{4,4}=PeakWL;
    FittedSpectra{2,ii-2}{3,5}='FWHM (nm)';
    FittedSpectra{2,ii-2}{4,5}=WL_width;
end
% creating a table
txt{3,4}='PeakWavelength (nm)';txt{4,4}='FWHM (nm)';
txt{5,4}='PeakWaveNumber (1/cm)';txt{6,4}='FWHM (1/cm)';
for ii=5:b
    txt{3,ii}=FittedSpectra{1,ii-2}{2,4}; %peak wavelength (nm)
    txt{4,ii}=FittedSpectra{1,ii-2}{2,5}; %FWHM nm (nm)
    txt{5,ii}=FittedSpectra{1,ii-2}{4,4}; %PeakWaveNumber (1/cm)
    txt{6,ii}=FittedSpectra{1,ii-2}{4,5}; %FWHM (1/cm)
end
% Also save them in the same folder as the input file
str11=[fitpath,fitfile,date,'.mat'];
save(str11,'FittedSpectra','txt')
%Writing it in a text file
fid=fopen([fitpath,fitfile,date,'.txt'],'wt');
fprintf(fid,' %s  \n  \n                          ',txt{1,1});
for ii=5:b
fprintf(fid,' %s  ',txt{2,ii});
end
fprintf(fid,' \n     PeakWavelength (nm)  ');
for ii=5:b
    if ii<14 
     fprintf(fid,' %06.1f             ',txt{3,ii});  
    else
     fprintf(fid,' %06.1f              ',txt{3,ii});   
    end
end
fprintf(fid,' \n               FWHM (nm)  ');
for ii=5:b
    if ii<14 
     fprintf(fid,' %5.1f              ',txt{4,ii});  
    else
     fprintf(fid,' %5.1f               ',txt{4,ii});   
    end
end
fprintf(fid,' \n   PeakWaveNumber (1/cm)  ');
for ii=5:b
    if ii<14 
     fprintf(fid,' %07.1f            ',txt{5,ii});  
    else
     fprintf(fid,' %07.1f             ',txt{5,ii});   
    end 
end
fprintf(fid,' \n             FWHM (1/cm)   ');
for ii=5:b
    if ii<14 
     fprintf(fid,'%6.1f              ',txt{6,ii});  
    else
     fprintf(fid,'%6.1f               ',txt{6,ii});   
    end 
end
fprintf(fid,'\n  ---- ---- ---- \n');
fclose(fid);
%clear part
clear y x WL_width WaveNumberSpec_obs WaveNumberSpec_gen p WaveLengthSpectrum_obs OP1
clear  strring sstring ssstrng raw PeakWN PeakWL p_2 WaveLengthSpectrum_gen OP
for ii=1:b-4
    str11=['WaveNumberSpec_',num2str(ii)];
    clear(str11)
    str11=['WaveLengthSpectrum_',num2str(ii)];
    clear(str11)
    str11=['p_',num2str(ii+4)];
    clear(str11)
    str11=['op_',num2str(ii+4)];
    clear(str11)
end
clear b stttr fitfile fitpath ii maxInd num OF_width str11 fid

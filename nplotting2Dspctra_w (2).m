%% firstOpen your Spectra and refrence
                %Ref part
                %Do we need a Refrence?
answer2=questdlg('Do we need a  new "Ref"?', ...
	'Do we need a new refrence?', ...
	'Yes','No, I will use the exisiting Ref','No, I will use the exisiting Ref');
if strcmp(answer2,'Yes')
    [reffile,refpath] = uigetfile('*.txt');
    fid=fopen([refpath,reffile],'rt');
    for ii=1:3000
      newline=fgets(fid);
      if ~ischar(newline)
         rLastLine=ii;
         disp(['cannot read after line number',num2str(ii)])
         break
      end
     [a,b]=size(newline);
     if b>200
            rFirstDataLine=ii;
            break
     elseif b<200
            continue
     end
    end
    fclose(fid);
    Ref=dlmread([refpath,reffile],'',[rFirstDataLine-1 0 rFirstDataLine+138 512]);
elseif strcmp(answer2,'No, I will use the exisiting Ref')
    % You are good just do nothing :D
else
    error('unusual answer to the question!')
end
                            % Data file
                            
questdlg('Please Load data file now','Load NanoTube Spectra?','Ok');
[sfile,spath] = uigetfile('*.txt');
fid=fopen([spath,sfile],'rt');
for ii=1:3000
    newline=fgets(fid);
    if ~ischar(newline)
        LastLine=ii;
        disp(['cannot read after line number',num2str(ii)])
        break
    end
    [a,b]=size(newline);
    if b>200
        FirstDataLine=ii;
        break
    elseif b<200
        continue
    end
end
fclose(fid);
S=dlmread([spath,sfile],'',[FirstDataLine-1 0 FirstDataLine+138 512]);
%% Perform Analysis
        [szeExcitation,szeEmission]=size(S);
        [RefszeExcitation,RefszeEmission]=size(Ref);
        switch szeExcitation==RefszeExcitation && szeEmission==RefszeEmission
            case false
                error('Error. Refrence and Spectra matrix size should match');
            case true
        Emission=S(1,2:szeEmission);
        Excitation=S(2:szeExcitation,1)';
        %Excitation is on Y and Emission is on X axis
        [X,Y] = meshgrid(Emission,Excitation);
        Spectra=S(2:szeExcitation,2:szeEmission);
        Refrence=Ref(2:szeExcitation,2:szeEmission);
        FinalSpectra=Spectra-Refrence;
        sampleID = input('Enter the name of your Sample ID: \n  ', 's'); 
        str1=[sampleID,'.mat'];
        figure(1)
        contourf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        figure(2)
        mesh(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        figure(3)
        surf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        Refbu=Ref; %Refrence Backup
        save(str1,'Excitation','Emission','sampleID','Spectra','FinalSpectra','Refrence')
        end
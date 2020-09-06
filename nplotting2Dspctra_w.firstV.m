%% firstOpen your Spectra and refrence
                %Ref part
                %Do we need a Refrence?
fprintf('>> >> >> \n')
disp('--------********-------++++++++--------^^^^^^^-------')
answer2=questdlg('Do we need a  new "Ref"?', ...
	'Do we need a new refrence?', ...
	'Yes','No, I will use the exisiting RRRef or Ref','No, I will use the exisiting RRRef or Ref');
if strcmp(answer2,'Yes')
    [reffile,refpath] = uigetfile('*.txt');
    disp('')
    fid=fopen([refpath,reffile],'rt');
    if fid>=0
     disp('New refrence file was loaded'); 
     disp(['Refernce file:  "',reffile,'" ']);
     disp(['Refrence Folder: ',refpath])
    else
        clear answer2
        error('error loading refrence file')
    end
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
elseif strcmp(answer2,'No, I will use the exisiting RRRef or Ref')
    exsst=exist('Ref','var');
    exst=exist('RRRef','var');
    if exst==1
        Ref=RRRef{1};
        refpath=RRRef{2};
        reffile=RRRef{3};
            disp('  \O/');disp('   | ');disp('  / \');
            disp('Definitly Know what The refrence in use is:')
            disp(['file name:   ',reffile])
            disp(['from folder: ',refpath])
         clear exsst exst
    elseif exsst==1 && ~exst==1
       exsst1=exist('reffile','var');
       exsst2=exist('refpath','var');
       if exsst1 && exsst2
            disp('The refrence in use seems to be:')
            disp(['file name:',reffile])
            disp(['from folder:',refpath])
       else
           disp('Refrence filename and\or filepath are missing')
           disp('But I will use existing Ref file anyway ... ')
       end
       clear exsst exsst1 exsst2
    else
        clear exsst answer2
        error('There is no Ref or RRRef saved in your workspace')
    end
else
    error('unusual answer to the question!')
end
                            % Data file
questdlg('Please Load data file now','Ready 2 Load NanoTube Spectra?','Lets GO','Lets GO');
[sfile,spath] = uigetfile('*.txt');
fid=fopen([spath,sfile],'rt');
    if fid>=0
     disp('============            ============')
     disp('Nano Tube Spectrum file was loaded') 
     disp(['Spectrum file:  "',sfile,'"  '])
     disp(['loaded from:     ',spath])
     disp('------------            ------------')
    else
        error('error loading refrence file')
    end
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
SpectrumID=[spath,sfile];
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
%% Name of the sample
        %sampleID = input('Enter the name of your Sample ID: \n  ', 's'); 
        LengthEstr=strlength(spath);
        if LengthEstr>=35
            sstrng=strrep(strrep(spath,':','_'),' ','_');
            indxofSlash=strfind(sstrng,'\');
            untilll=indxofSlash(length(indxofSlash))-35;
            strng=eraseBetween(sstrng,1,untilll);
            sampleID=[strrep(strng,'\','_'),eraseBetween(sfile,16,length(sfile))];
            clear untilll strng sstrng indxofSlash LengthEstr
        else
            sstrng=strrep(spath,'\','_');
            strng=strrep(sstrng,':','_');
            sampleID=[strrep(strng,' ','_'),eraseBetween(sfile,16,length(sfile))];
            clear sstrng strng LengthEstr
        end
        % check to see if sampleId exists before 
        loopCounter=1;
        while exist([sampleID,'.mat'],'file')==2
            if loopCounter>=10
                disp('too many files with the same name')
                error('Error in saving file name')
            end
            if loopCounter==1
                sampleID=[sampleID,num2str(round(loopCounter))];
            else
                sampleID=eraseBetween(sampleID,length(sampleID),length(sampleID));
                sampleID=[sampleID,num2str(round(loopCounter))];

            end
            loopCounter=loopCounter+1;
        end
        clear loopCounter
        disp('       \/\/\/\/\/\/\/\/\/\/\/\/\/\/')
        disp(['your sampleID is: ',sampleID])
        str1=[sampleID,'.mat'];
        %% Plotting the figures
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
        RRRef={Ref,refpath,reffile};
        RRRefBU=RRRef;
        save(str1,'SpectrumID','Excitation','Emission','sampleID','Spectra','FinalSpectra','Refrence','RRRefBU')
        clear a ans answer2 b fid FirstDataLine ii newline RefszeEmission RefszeExcitation rFirstDataLine 
        clear str1 szeEmission szeExcitation sfile spath SpectrumID
        disp(' ------------- Good Luck! ------------')
        end
        
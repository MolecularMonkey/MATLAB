%% first Open your refrence (if needed) and Spectra and plots data and save Spectra- REfvalues
% save xlsx csv file in the same folder as the spectra folder
% Before running this m-file need to export all the OriginProjects.opj into
% .csv files and Check 1- export with full preciscion 
%              unCheck 2- export missing values as --
%                Check 3- export XY coordinates
%% Ref part
                %Do we need a Refrence?
fprintf('>> >> >> \n')
disp('--------********-------++++++++--------^^^^^^^-------')
answer2=questdlg('Do we need a  new "Ref"?', ...
	'Do we need a new refrence?', ...
	'Yes','No, I will use the exisiting RRRef or Ref','No, I will use the exisiting RRRef or Ref');
if strcmp(answer2,'Yes')
    [reffile,refpath] = uigetfile({'*.csv';'*.txt'},'Load Refrence');
    disp('')
    Ref=csvread([refpath,reffile]);
disp('New refrence file was loaded'); 
disp('  \O/   [0]');disp('   |     Y ');disp('  / \   / \');
disp(['Refernce file:  "',reffile,'" ']);
disp(['Refrence Folder: ',refpath])
    
    RRRef={{'Original Refrence (Ref File)',Ref},refpath,reffile,'100% sure since Refrence Loaded Now'};
    RRRef_Shuld_B_deleted=0;
elseif strcmp(answer2,'No, I will use the exisiting RRRef or Ref')
    exsst=exist('Ref','var');
    exst=exist('RRRef','var');
    if exst==1
        Ref=RRRef{1,1}{1,2};
        refpath=RRRef{1,2};
        reffile=RRRef{1,3};
        RRRef_previous=RRRef;
        RRRef_Shuld_B_deleted=0;
        disp('...');
        disp('Previous Refrence Saved to:    RRRef_previous');
        disp('...');
        clear RRRef;
            disp('  \O/');disp('   | ');disp('  / \');
            disp('Definitly Know what The refrence in use is:')
            disp(['file name:   ',reffile])
            disp(['from folder: ',refpath])
         clear exsst exst
         RRRef={{'Original Refrence (Ref File)',Ref},refpath,reffile,'Definitly Know what The refrence in use is'};
    elseif exsst==1 && ~exst==1
       exsst1=exist('reffile','var');
       exsst2=exist('refpath','var');
     RRRef_Shuld_B_deleted=1; % Because We are not so sure about RRRef,esp. ref path and ref file location; so next run should be unsure too (if it is done based on this run)
       if exsst1 && exsst2
            disp('The refrence in use seems to be:')
            disp(['file name:',reffile])
            disp(['from folder:',refpath])
            RRRef={{'Original Refrence (Ref File)',Ref},refpath,reffile,'Not quite sure, but it seems to be this'};
       else
           disp('Refrence filename and\or filepath are missing')
           disp('But I will use existing Ref file anyway ... ')
           RRRef={{'Original Refrence (Ref File)',Ref},'Do not know','Have no idea!','Not sure where the refrence came from! It was just in the workspace'};
       end
       clear exsst exsst1 exsst2
    else
        clear exsst answer2
        error('There is no Ref or RRRef saved in your workspace')
    end
else
    error('unusual answer to the question!')
end
%% Data file
questdlg('Please Load data file now','Ready 2 Load NanoTube Spectra?','Lets GO','Lets GO');
exsst=exist('refpath','var');
if exsst==1
    [sfile,spath] = uigetfile({'*.csv';'*.txt'},'Load Spectra',refpath);

else
   [sfile,spath] = uigetfile({'*.csv';'*.txt'},'Load Spectra'); 
end
S=csvread([spath,sfile]);
     disp('============            ============')
     disp('Nano Tube Spectrum file was loaded') 
     disp(['Spectrum file:  "',sfile,'"  '])
     disp(['loaded from:     ',spath])
     disp('------------            ------------')
SpectrumID=[spath,sfile];
%% Dillution Factor
answer3=questdlg('Dillution Factor?', ...
	'Is Dillution Factor Needed?', ...
	'Yes','No','Yes');
if strcmp(answer3,'Yes')
    DL=input('please enter the value of dillution factor \n  ');
    fprintf('Dillution factor = %6.4f \n',DL)
else
    DL=1.000;
end
%% Perform Analysis
        [szeExcitation,szeEmission]=size(S);
        [RefszeExcitation,RefszeEmission]=size(Ref);
        switch szeExcitation==RefszeExcitation && szeEmission==RefszeEmission
            case false
                disp()
                error('Error. Refrence and Spectra matrix size should match');
            case true
        Emission=S(1,2:szeEmission);
        Excitation=S(2:szeExcitation,1)';
        %Excitation is on Y and Emission is on X axis
        [X,Y] = meshgrid(Emission,Excitation);
        Spectra=S(2:szeExcitation,2:szeEmission);
        Refrence=Ref(2:szeExcitation,2:szeEmission);
        FinalSpectra=DL.*(Spectra-Refrence);
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
                disp('        /\--/\/\/\      /\/\/\--/\')
                disp('There is Another (1) file with The SAME Name (Sample ID) in that folder')
            else
                sampleID=eraseBetween(sampleID,length(sampleID),length(sampleID));
                sampleID=[sampleID,num2str(round(loopCounter))];
                disp('        /\--/\/\/\      /\/\/\--/\')
                disp('Hehehe!')
                disp('There is SEVERAL (More than 1) files with The SAME Name in the folder')
            end
            loopCounter=loopCounter+1;
        end
        clear loopCounter
        disp('       \/\/\/\/\/\/\/\/\/\/\/\/\/\/')
        disp(['your sampleID is: ',sampleID])
        str3=[spath,sampleID,'.csv'];
        str2=['2D_files\',sampleID,'.mat'];
        str1=[spath,sampleID,'.mat'];
        % saving data in RRRef file 
        RRRef{2,1}={'Final Spectra',FinalSpectra};
        RRRef{2,2}={'Original Acquired Spectra (S file)',S};
        RRRef{2,3}={'Excitation','Emission';Excitation,Emission};
        RRRef{2,4}={'SpectrumID','S path','S file';SpectrumID,spath,sfile};
        RRRef{1,5}={'Date And Time',datetime};
        RRRef{1,6}{1,1}='Dillution Factor';
        RRRef{1,6}{2,1}=DL;
        %% Plotting the figures and Saving the files
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
        RRRefBU=RRRef;
        %Saving Part 
        csvwrite(str3,FinalSpectra);
        save(str2,'RRRefBU')
        save(str1,'SpectrumID','sampleID','Spectra','Refrence','RRRefBU')
        % Clearing Part
        clear a ans answer2 b fid FirstDataLine ii RefszeEmission RefszeExcitation rFirstDataLine 
        clear str1 str3 szeEmission szeExcitation sfile spath SpectrumID
        %clear newline
        if RRRef_Shuld_B_deleted
            clear RRRef
            disp('I have to delete RRRef from work space but not anything else!')
            disp('(...)');
            disp('  ')
        end
        clear RRRef_Shuld_B_deleted
        disp(' ------------- Good Luck!,  Nima ------------')
        end
        %str4=[spath,sampleID,'.xlsx'];
        %xlswrite(str4,FinalSpectra,'Final_Spectra')
        %clear str4 [({spath})] 
        
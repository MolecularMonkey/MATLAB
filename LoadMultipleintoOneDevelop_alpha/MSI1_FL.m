function [RawData,FinalData,MatlabOriginDataFileHistory] = MSI1_FL(DFMNS66SS,DataSetNo,answer2)
%MSI1_FL Summary of this function goes here
%   Detailed explanation goes here
%
% This Code combine different spectra to be collected as one matrix that can be copied to Origin(R) or Excel(R) for graphing purposes
%% Asking Part
YAexitflag=0;
while ~YAexitflag
INSTR=questdlg('Which Instrument?','Which Instrument?','NS1','NS3','NS1');
switch INSTR
    case 'NS1'
    list = {'642','659','784'};   YAexitflag=1;         % NS1      
    case 'NS3'
        VISORUV=questdlg('Vis or IR Flourescence?','Vis or IR Flourescence?','IR','VIS','IR');
        switch VISORUV
            case 'IR'
            list={'473','532','638','671','779'}; YAexitflag=1; % NS3 IR PL 
            case 'VIS'
            list={'473','532','638','671',}; YAexitflag=1; % NS3 VIS PL
        end
end
end
exitflag=0;
while ~exitflag
indx = listdlg('ListString',list,'SelectionMode','single');
switch INSTR
    case 'NS1'
        disp('NS1 Instrument')
        if indx==1
            FLOUVW='__642'; exitflag=1; 
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        elseif indx==2
            FLOUVW='__659'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])

        elseif indx==3
            FLOUVW='__784'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        else
            questdlg('You havent selected anything, lets do it again','You havent selected anything; Lets do it again','Lets Go','Lets Go')
        end  
    case 'NS3'
      if strcmp(VISORUV,'VIS')
        disp('NS3 Instrument VIS PL')
        if indx==1
            FLOUVW='_V473'; exitflag=1;
            disp(['Flourescence Wavelength Selected vis-',FLOUVW,' nm'])
        elseif indx==2
            FLOUVW='_V532'; exitflag=1;
            disp(['Flourescence Wavelength Selected vis-',FLOUVW,' nm'])
        elseif indx==3
            FLOUVW='_V638'; exitflag=1;
            disp(['Flourescence Wavelength Selected vis-',FLOUVW,' nm'])
        elseif indx==4
            FLOUVW='_V671'; exitflag=1;
            disp(['Flourescence Wavelength Selected vis-',FLOUVW,' nm'])
        else
            questdlg('You havent selected anything, lets do it again','You havent selected anything; Lets do it again','Lets Go','Lets Go')
        end
      elseif strcmp(VISORUV,'IR')         
        disp('NS3 Instrument IR PL')
        if indx==1
            FLOUVW='__473'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        elseif indx==2
            FLOUVW='__532'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        elseif indx==3
            FLOUVW='__638'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        elseif indx==4
            FLOUVW='__671'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        elseif indx==5
            FLOUVW='__779'; exitflag=1;
            disp(['Flourescence Wavelength Selected ',FLOUVW,' nm'])
        else
            questdlg('You havent selected anything, lets do it again','You havent selected anything; Lets do it again','Lets Go','Lets Go')
        end
      else
          error('You havent selected any device or PL, lets do it again; That should be impossible') % impossible because of YAexitflag 
      end
end
end
disp('***')

%% Raw Data Collection
RawData=[];
MatlabOriginDataFileHistory={};
for ii=1:DataSetNo
    %M-File written
     FlourescenceCombining_LoadFile_filtered %FlourescenceCombining_LoadFile w/out filter is also available
      MatlabOriginDataFileHistory{1, ii+2} =[num2str(ii),'Data Set'];
    fid=fopen([npath,nfile],'rt');
    formatspec='%f %f';
    sizeCNT=[2 Inf];
    CNT=fscanf(fid,formatspec,sizeCNT);
    CNT=CNT';
    MatlabOriginDataFileHistory{2, ii+2}=nfile;
    MatlabOriginDataFileHistory{3, ii+2}=npath;
    fLngth=strlength(nfile);
    MatlabOriginDataFileHistory{5, ii+2}=strrep(eraseBetween(nfile,fLngth-8,fLngth),'_',' ');
    fclose(fid);
    if ii==1
        RawData(:,1)=CNT(:,1); % wavelengths (nm)
        RawData(:,2)=CNT(:,2); % Absorption or flourescenece Intensity
        disp('first data set loaded'); disp('********************************')
    else
        RawData(:,ii+1)=CNT(:,2); % 
    end
end


%% Dilution Factor Multiplication
FinalData=zeros(size(RawData));
FinalData(:,1)=RawData(:,1);
for nn=1:DataSetNo
    FinalData(:,nn+1)=DFMNS66SS(nn).*RawData(:,nn+1);
    MatlabOriginDataFileHistory{4, nn+2}=DFMNS66SS(nn);
end
%% Data Base completion
MatlabOriginDataFileHistory{1, 1}='RawData';
MatlabOriginDataFileHistory{2, 1}='FinalData';
MatlabOriginDataFileHistory{1, 2}=RawData;
MatlabOriginDataFileHistory{2, 2}=FinalData;
MatlabOriginDataFileHistory{3, 1}=['Data Set Number is: ',num2str(DataSetNo)];
MatlabOriginDataFileHistory{3, 2}=DataSetNo;
if strcmp(answer2,'Yes: Providing name of Matrix') %'No: Entering Dillution data now','Yes: Providing name of Matrix'
    MatlabOriginDataFileHistory{4, 1}='Dillutuion Factor Was saved B4 runing the code';
elseif strcmp(answer2,'No: Entering Dillution data now') 
    MatlabOriginDataFileHistory{4, 1}='Dillutuion Factor Was entered after running the code';
end
MatlabOriginDataFileHistory{4, 2}=DFMNS66SS;
MatlabOriginDataFileHistory{5,1}=[FLOUVW,' nm'];

%% Saving Part
[FileName,PathName]=uiputfile({'*.xlsx;*.mat;*.xls;*.csv'},'Save Final Data As',prevpath);
LengthEstr=strlength(FileName);
fFname=eraseBetween(FileName,LengthEstr-3,LengthEstr);
svstr1=[PathName,fFname,FLOUVW,'.mat'];
save(svstr1,'MatlabOriginDataFileHistory')
%svstr2=[PathName,fFname,'__',FLOUVW,'.csv'];
%csvwrite(svstr2,FinalData)
svstr3=[PathName,fFname,FLOUVW,'.xls'];
writematrix(FinalData,svstr3)
disp(['Data Saved to: ',PathName,fFname,FLOUVW]);
disp('---');
%% Ploting Part
x=700+round(1000*rand);
figure(x);
hold on
for ii=1:DataSetNo
    plot(FinalData(:,1)',FinalData(:,ii+1)','DisplayName',MatlabOriginDataFileHistory{5, ii+2})
end
hold off
title(strrep(FLOUVW,'_',' '))
lgd = legend;
end
function [RawData,FinalData,MatlabOriginDataFileHistory] = MSI1_ABS(DFMNS66SS,DataSetNo,answer2)
%MSI1_ABS Summary of this function goes here
% This Code combine different ABS spectra to be collected as one matrix that can be copied to Origin(R) or Excel(R) for graphing purposes

%% Asking Part
exitflag=0;
while ~exitflag
INSTR=questdlg('Which Instrument?','Which Instrument?','NS1','NS3','NS1');
switch INSTR
    case 'NS1'
    VISwvlnght1=400.0017;       %nm     % Start of VIS NS1
    VISNIRwvl=899.5120;         %nm       % END of VIS NS1
    NIRwvlnght2=900.0979;       %nm     % Start of NIR NS1
                          % END of NIR for NS1 1598.282 nm
    exitflag=1;
    case 'NS3'
    VISwvlnght1=400.0830;       %nm     % Start of VIS NS1
    VISNIRwvl=881.8097;         %nm       % END of VIS NS1
    % NS3 Software by SB is written in a way that 879.849 nm is VIS END
    NIRwvlnght2=882.3320;       %nm     % Start of NIR NS1
                          % END of NIR for NS1 1598.282 nm
    exitflag=1;
    case ''
        disp('Lets do it again :-|')
end
disp('***')
end

%% Raw Data Collection
RawData=[];
MatlabOriginDataFileHistory={};
    formatspec='%f %f';
    sizeCNT=[2 Inf];
for ii=1:DataSetNo
    %M-File written
     AbsorbtionCombining_LoadFile_filtered %FlourescenceCombining_LoadFile w/out filter is also available
      MatlabOriginDataFileHistory{1, ii+2} =[num2str(ii),'Data Set'];
      % Write code in a way that opens two files in different VISAbs,NIRAbs
      %Read NIR
    fidNIR=fopen([npath,NIRDATA],'rt');
    NIRAbs=fscanf(fidNIR,formatspec,sizeCNT);
    NIRAbs=NIRAbs';
    fclose(fidNIR);
        %  Read VIS
    fidVIS=fopen([npath,VISDATA],'rt');
    VISAbs=fscanf(fidVIS,formatspec,sizeCNT);
    VISAbs=VISAbs';
    fclose(fidVIS);
    CNT=CombAbs(VISwvlnght1,VISNIRwvl,NIRwvlnght2,VISAbs,NIRAbs);
    MatlabOriginDataFileHistory{2, ii+2}=NIRDATA;
    MatlabOriginDataFileHistory{3, ii+2}=VISDATA;
    MatlabOriginDataFileHistory{4, ii+2}=npath;
    fLngth=strlength(NIRDATA);
    MatlabOriginDataFileHistory{6, ii+2}=strrep(eraseBetween(NIRDATA,fLngth-8,fLngth),'_',' ');
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
    MatlabOriginDataFileHistory{5, nn+2}=DFMNS66SS(nn);
end
%% Data Base completion
MatlabOriginDataFileHistory{1, 1}='RawData';
MatlabOriginDataFileHistory{2, 1}='FinalData';
MatlabOriginDataFileHistory{1, 2}=RawData;
MatlabOriginDataFileHistory{2, 2}=FinalData;
MatlabOriginDataFileHistory{3, 1}=['Data Set Number is: ',num2str(DataSetNo)];
MatlabOriginDataFileHistory{3, 2}=DataSetNo;
if strcmp(answer2,'Yes: Providing name of Matrix') %'No: Entering Dillution data now','Yes: Providing name of Matrix'
    MatlabOriginDataFileHistory{5, 1}='Dillutuion Factor Was saved B4 runing the code';
elseif strcmp(answer2,'No: Entering Dillution data now') 
    MatlabOriginDataFileHistory{5, 1}='Dillutuion Factor Was entered after running the code';
 end
MatlabOriginDataFileHistory{5, 2}=DFMNS66SS;
MatlabOriginDataFileHistory{6,1}='Absorption';
%% Saving Part
[FileName,PathName]=uiputfile({'*.xlsx;*.mat;*.xls;*.csv'},'Save Final Data As',prevpath);
LengthEstr=strlength(FileName);
fFname=eraseBetween(FileName,LengthEstr-3,LengthEstr);
svstr1=[PathName,fFname,'__ABS.mat'];
save(svstr1,'MatlabOriginDataFileHistory')
%svstr2=[PathName,fFname,'__',FLOUVW,'.csv'];
%csvwrite(svstr2,FinalData)
svstr3=[PathName,fFname,'__ABS.xls'];
writematrix(FinalData,svstr3)
disp(['Data Saved to: ',PathName,fFname,'__ABS']);
disp('---');
%% Ploting Part
x=10+round(1000*rand);
figure(x)
hold on
for ii=1:DataSetNo
    plot(FinalData(:,1)',FinalData(:,ii+1)','DisplayName',MatlabOriginDataFileHistory{6, ii+2})
end
hold off
lgd = legend;
title('Absorbance')
end
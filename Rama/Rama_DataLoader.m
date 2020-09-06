% Data Collection
function [MatlabDataFileHistory,RawData,prevpath]=Rama_DataLoader(DataSetNo)
sizeCNT=[2 Inf];
MatlabDataFileHistory{6, DataSetNo+1}='';
RawData=[];
disp('--__--__--__--__--__--');
for ii=1:DataSetNo
queststrng1=['Please Load Raman Data # ',num2str(ii),' '];
queststrng2=['Ready for #',num2str(ii),' ?'];
    questdlg(queststrng1,queststrng2,['Lets GO Raman No.',num2str(ii)],['Lets GO Raman No.',num2str(ii)]); 
if ii==1
    [nfile,npath] = uigetfile({'*__RAM.txt','Raman.txt';'*.txt','Text Files';'*.*',  'All Files (*.*)'},queststrng1);
    fid=fopen([npath,nfile],'rt');
    prevpath=npath;
    disp(['Raman Data Set #',num2str(ii)])

else
    [nfile,npath] = uigetfile({'*__RAM.txt','Raman.txt';'*.txt','Text Files';'*.*',  'All Files (*.*)'},queststrng1,prevpath);
    fid=fopen([npath,nfile],'rt');
    prevpath=npath;
    disp('=+==+==+==+==+==+==+==+==+==+==+==+')
    disp(['Raman Data Set #',num2str(ii)])
end
formatspec='%f %f';
CNTram=fscanf(fid,formatspec,sizeCNT);
CNTram=CNTram';
MatlabDataFileHistory{1, ii+2}=[num2str(ii),'Data Set'];
MatlabDataFileHistory{2, ii+2}=nfile;
MatlabDataFileHistory{3, ii+2}=npath;
fLngth=strlength([npath,nfile]);
MatlabDataFileHistory{5, ii+2}=eraseBetween(strrep(strrep(eraseBetween([npath,nfile],01,fLngth-33),'\',' '),'_',' '),33-3,33);
 fclose(fid);
 if ii==1
        RawData(:,1)=CNTram(:,1); % wavelengths (nm)
        RawData(:,2)=CNTram(:,2); % Raman Intensity
 else
     RawData(:,ii+1)=CNTram(:,2); % Raman Intensity
 end
disp(['Spectra file loaded from: ',npath]);
disp(['Spectra file name: ',nfile]);
disp('------------=======--------------');
end
% Data Base Completion
MatlabDataFileHistory{1, 1}='RawData';
MatlabDataFileHistory{1, 2}=RawData;
MatlabDataFileHistory{2, 1}=['Data Set Number is: ',num2str(DataSetNo)];
MatlabDataFileHistory{2, 2}=DataSetNo;
end
%% Raman Data Refiner
% This M-file reads the raman data and saves the txt file of the specficportion of the data
% that we are interested to
DataSetNo=1;
[MatlabDataFileHistory,RawData,prevpath]=Rama_DataLoader(DataSetNo);
%% BaseLine Averagig between OF1 and OF2  and OF3 and OF4
OF1=1.110419e+03;
OF2=1.22076e+03;
OF3=1.380102e+03;
OF4=1.451496e+03;
[BaseLineCorrected,~,~,~,~,AverageData]=...
    BaseLineRaman(RawData,OF1,OF2,OF3,OF4);
%% Selecting Data between 190 1/cm to inf
OriginalFileName=MatlabDataFileHistory{2,3};
% Select the final Data Point and start enjoying this m-file
[Row2Choose1f,FinalRow2Choose]=Freq2Indice(BaseLineCorrected,1110,2915);
FinalRaman=BaseLineCorrected(Row2Choose1f:end,:);
[FileName,PathName]=uiputfile('*.txt','Save Final Data As',prevpath);
fileID = fopen([PathName,FileName],'w');
fprintf(fileID,'Original Raman Data Loaded from %s Original File name: %s Refined by Raman Data Refiner on %s \n'...
    ,prevpath,OriginalFileName,date);
fprintf(fileID,'%f %f\n',FinalRaman');
fclose(fileID);
disp(['Refined Raman Data saved on ',PathName,FileName]);
%% clearing Part
clear BaseLineCorrected DataSetNo fileID MatlabDataFileHistory OF1 OF2 OF3 OF4
clear prevpath RawData ans Row2Choose1f
clear PathName FileName OriginalFileName

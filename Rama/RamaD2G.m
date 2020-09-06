DataSetNo=input('Enter How many data sets you are going to load? \n      ');
%% Time Data
qqq=questdlg('Timed Series?','Do you have time data? Are you ready to enter them right now?','Yes','No','Yes'); 
    switch qqq
        case 'Yes'
          qgq=questdlg('Matrix or Enter?','Time data saved in Matrix? or you want to enter them right now?','Enter Data Now','Data in Matrix','Data in Matrix');
          switch qgq
          case 'Enter Data Now'
            TTTime=ones(1,DataSetNo);
            disp('enter time data (in Seconds)')
            for iii=1:DataSetNo
            sstrr=['Enter the "time" for data set # ',num2str(iii),' in seconds \n time (s) = '];
            TTTime(iii)=input(sstrr);
            end
          case 'Data in Matrix'
            msgbox(['Name of Time Matrix: with ',num2str(DataSetNo),' Columns and 1 row?'],'Name Time Data Vector');
            DF_Matrix_Name=input('Enter the VarName of matrix saved \n   ','s');
            eval(['Foundt=',DF_Matrix_Name])
            TTTime=Foundt; clear Foundt;
            if size(TTTime,2)~=DataSetNo || size(TTTime,1)~=1
                    error('Time Data Matrix Does not have the correct dimension')
            end
          end                    
        case 'No'
            disp('Never mind, Lets find out D/G anyway')
            TTTime=ones(1,DataSetNo);
    end
    %% Loading Data
[MatlabDataFileHistory,RawData,prevpath]=Rama_DataLoader(DataSetNo);
%% BaseLine Averagig between OF1 and OF2  and OF3 and OF4
OF1=1.110419e+03;
OF2=1.22076e+03;
OF3=1.380102e+03;
OF4=1.451496e+03;
[BaseLineCorrected,Row2Choose1,Row2Choose2,Row2Choose3,Row2Choose4,AverageData]=...
    BaseLineRaman(RawData,OF1,OF2,OF3,OF4);
%% Integration
% Integrating D from DOF1 and DOF2
% and G band from GOF1 and GOF2 
% D band area 
DOF1=1.260109e+3; %1/cm
DOF2=1.330055e+3; %1/cm
[Row2Choose1D,Row2Choose2D]=Freq2Indice(BaseLineCorrected,DOF1,DOF2);
XD=BaseLineCorrected(Row2Choose1D:Row2Choose2D,1);
% G band area
GOF1=1.533e+03; %1/cm
GOF2=1.633e+03; %1/cm
[Row2Choose1G,Row2Choose2G]=Freq2Indice(BaseLineCorrected,GOF1,GOF2);
XG=BaseLineCorrected(Row2Choose1G:Row2Choose2G,1);
%Calculation of D/G area
D=ones(1,DataSetNo); G=ones(1,DataSetNo); D2G=ones(1,DataSetNo);
for jj=1:DataSetNo
    YD=BaseLineCorrected(Row2Choose1D:Row2Choose2D,jj+1);
    IntD=trapz(XD,YD);
    D(jj)=IntD;
    YG=BaseLineCorrected(Row2Choose1G:Row2Choose2G,jj+1);
    IntG=trapz(XG,YG);
    G(jj)=IntG;
    D2G(jj)=D/G;
    MatlabDataFileHistory{4,jj+2}=D/G;
    disp(['====Caclculations for Data Set #',num2str(jj),'==== '])
    fprintf('\n For Data set # %d \n int(D)= %6f \n int(G)= %6f \n D/G= %6f \n' ...
        ,jj,D(jj),G(jj),D2G(jj))
end
%% Data Set Completion
MatlabDataFileHistory{3,1}='Base Line Corrected Data';
MatlabDataFileHistory{3,2}=BaseLineCorrected;
MatlabDataFileHistory{4,1}='D/G ratio based on integral for each data set';
MatlabDataFileHistory{4,2}=D2G;
MatlabDataFileHistory{5,1}='D integral for data set';
MatlabDataFileHistory{5,2}=D;
MatlabDataFileHistory{6,1}='G integral for data set';
MatlabDataFileHistory{6,2}=G;
MatlabDataFileHistory{1,DataSetNo+3}='Base Line Data Averaged for each set';
MatlabDataFileHistory{2,DataSetNo+3}=AverageData;
MatlabDataFileHistory{7,DataSetNo+3}='<- Time (sec) ^';
MatlabDataFileHistory{6,DataSetNo+3}=TTTime;
for iii=1:DataSetNo
    MatlabDataFileHistory{7,iii+2}=TTTime(iii);
end
%% Save Part
[FileName,PathName]=uiputfile({'*.xlsx;*.mat;*.xls;*.csv;*.png'},'Save Final Data As',prevpath);
LengthEstr=strlength(FileName);
fFname=eraseBetween(FileName,LengthEstr-4,LengthEstr);
svstr1=[PathName,fFname,'_AnalyzedRaman.mat'];
save(svstr1,'MatlabDataFileHistory')
svstr3=[PathName,fFname,'_AnalyzedRaman.xls'];
writematrix([TTTime',D2G'],svstr3)
disp(['Data Saved to: ',PathName,fFname,'_AnalyzedRaman']);
disp('---');
%% Plotting Part
RamanPlotting3(DataSetNo,RawData,BaseLineCorrected,AverageData,XD,XG,...
    Row2Choose1,Row2Choose2,Row2Choose3,Row2Choose4,...
    Row2Choose1D,Row2Choose2D,Row2Choose1G,Row2Choose2G,MatlabDataFileHistory)
%% Printing part
mkdir(PathName,[fFname,'_AnalyzedRaman']);
PathName=[PathName,fFname,'_AnalyzedRaman\'];
for iii=1:DataSetNo
figStr1=['-f',num2str(1000+iii)];
% Name of Image
figSavStr=MatlabDataFileHistory{5,iii+2};
figSavStr=eraseBetween(figSavStr,1,10);
LengthEstr=strlength(figSavStr);
figSavStr=eraseBetween(figSavStr,LengthEstr-4,LengthEstr);
figSavStr=[num2str(iii),'_',figSavStr];
figSavStr=[PathName,figSavStr];
% End of Name of Image
print(figStr1,figSavStr,'-dpng');
end
%% D/G Data Ploting 
switch qqq
    case 'Yes'
            figure(1000+DataSetNo+1)
            clf(1000+DataSetNo+1,'reset')
            plot(TTTime,D2G,'k',TTTime,D2G,'bo')
            xlabel('time (sec)')
            ylabel('D/G Ratio')
            title(eraseBetween(FileName,strlength(FileName)-4,strlength(FileName)));
            figStr1=['-f',num2str(1001+DataSetNo)];
            figSavStr=[PathName,'D2G_ratio'];
            print(figStr1,figSavStr,'-dpng');
    case 'No'
end
%% Clearing Part
clear DOF1 DOF2 fFname figSavStr figStr1 FileName GOF1 GOF2
clear iii IntD IntG jj LengthEstr OF1 OF2 OF3 OF4 PathName qgq qqq
clear Row2Choose1 Row2Choose1D Row2Choose1G Row2Choose2 Row2Choose2D Row2Choose2G Row2Choose3 Row2Choose4
clear sstrr svstr1 svstr3 XD XG YD YG h DF_Matrix_Name
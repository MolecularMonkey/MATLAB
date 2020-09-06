% Multiple Spectra into one
%Consist of 7 codes & 520 line of codes in total 
SpectraType=questdlg('Spectra Type?','ABS? or FL?','ABSORBANCE','FLUORESCENCE','ABSORBANCE');
DataSetNo=input('Enter How many data sets you are going to load? \n      ');
DillutionFactorAsking % outputs are answer2 and DFMNS66SS
switch SpectraType
    case 'ABSORBANCE'
        [RawData,FinalData,MatlabOriginDataFileHistory] = MSI1_ABS(DFMNS66SS,DataSetNo,answer2);
    case 'FLUORESCENCE'
        [RawData,FinalData,MatlabOriginDataFileHistory] = MSI1_FL(DFMNS66SS,DataSetNo,answer2);

end
clear answer2
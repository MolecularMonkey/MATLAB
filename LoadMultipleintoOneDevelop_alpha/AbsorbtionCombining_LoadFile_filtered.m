queststrng1=['Please Load VIS and NIR Absorption Data for DataSet# ',num2str(ii),' '];
queststrng2=['Ready to Load Spectra #',num2str(ii),' ?'];
iterrr=0;
aexitFLAG =0;
bexitFLAG =0;
exitFLAG = 0;
while  ~exitFLAG
    iterrr=iterrr+1;
    questdlg(queststrng1,queststrng2,['Lets GO No.',num2str(ii)],['Lets GO No.',num2str(ii)]);
    if ii==1 && iterrr==1
        [nfile,npath] = uigetfile({'*__VIS.txt;*__NIR.txt','NIR VIS Abs txt';'*.txt','Text Files';'*.*',  'All Files (*.*)'},queststrng1,'MultiSelect', 'on');
        prevpath=npath;
    else
        [nfile,npath] = uigetfile({'*__VIS.txt;*__NIR.txt','NIR VIS Abs txt';'*.txt','Text Files';'*.*',  'All Files (*.*)'},queststrng1,'MultiSelect', 'on',prevpath);
        prevpath=npath;
    end
    iterCount =0;
    while size(nfile,2)~=2
         h=msgbox('You must select Two--2--Files together:   This code works on multi Select mode for Abdorption Data','Select Only 2');
         if iterCount >1
             h=msgbox('Select NIR Absorption and VIS Absorption           Select 2 Files Simultaneously','2 Files');
         end
         [nfile,npath] = uigetfile('*.txt',queststrng1,'MultiSelect', 'on',prevpath);
         iterCount =iterCount +1;         
    end
    FileName1=nfile{1, 1};
    FileName2=nfile{1, 2};
if contains(FileName1,'__VIS.txt') && contains(FileName2,'__NIR.txt')
    disp('------          2 Absorption Files Loaded           ------');
    disp(['Absorption File path',npath]); disp(['ABS File Name VIS: ',FileName1]);disp(['ABS File Name NIR: ',FileName2]); disp('************');
    aexitFLAG=1;
         VISDATA=FileName1; NIRDATA=FileName2;
elseif contains(FileName2,'__VIS.txt') && contains(FileName1,'__NIR.txt')
    disp('------          2 Absorption Files Loaded           ------');
    disp(['Absorption File path',npath]); disp(['ABS File Name NIR: ',FileName1]);disp(['ABS File Name VIS: ',FileName2]); disp('************');
    aexitFLAG=1;
         VISDATA=FileName2; NIRDATA=FileName1;
else
disp('NO __VIS or __NIR in file name load again');
end
f1Lngth=strlength(FileName1);
fname1=eraseBetween(FileName1,f1Lngth-8,f1Lngth);
f2Lngth=strlength(FileName2);
fname2=eraseBetween(FileName2,f2Lngth-8,f2Lngth);
if strcmp(fname1,fname2)
    bexitFLAG=1;
else
    MakeSuperSure2=questdlg([FileName2,' & ',FileName2,' selected, names do not match'],'R U Sure?','Yes -_-','I DO NOt Know :(','I DO NOt Know :(');
    switch MakeSuperSure2
        case 'Yes -_-'
                bexitFLAG=1;
        case 'I DO NOt Know :('
                disp('Data Not Loaded, Lets do it again')
    end  
end
if bexitFLAG && aexitFLAG
    exitFLAG=1;
end
end
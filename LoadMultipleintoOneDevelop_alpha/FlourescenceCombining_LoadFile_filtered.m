% this m-file is a subset of LoadMultipleFlourescenceIntoOne m-file
% This m-file also filters the selected files so that only the specified files will be shown for example only __784.txt
% if you want to use the same m-file without filtering just look for FlourescenceCombining_LoadFile.m 
queststrng1=['Please Load ',FLOUVW,' flourescence Data # ',num2str(ii),' '];
queststrng2=['Ready to Load Spectra #',num2str(ii),' ?'];
exitFLAG=0;
iterrr=0;
while  ~exitFLAG
    iterrr=iterrr+1;
    questdlg(queststrng1,queststrng2,['Lets GO FL ',FLOUVW,' No.',num2str(ii)],['Lets GO FL ',FLOUVW,' No.',num2str(ii)]); 
    if ii==1 && iterrr==1
        [nfile,npath] = uigetfile({['*',FLOUVW,'.txt'],'FL.txt';'*.txt','Text Files';'*.*',  'All Files (*.*)'},queststrng1);
        prevpath=npath;
    else
        [nfile,npath] = uigetfile({['*',FLOUVW,'.txt'],'FL.txt';'*.txt','Text Files';'*.*',  'All Files (*.*)'},queststrng1,prevpath);
        prevpath=npath;
    end
    if contains(nfile,[FLOUVW,'.txt'])
         disp(['Spectra file loaded from: ',npath]);
         disp(['Spectra file name: ',nfile]);
         disp('------')
         exitFLAG=1;
    else
        MakeSURE=questdlg(['Your files does not have ',FLOUVW,'.txt in its file name'],'Are You Sure?','Maybe Something Wrong: Let me load again' ,'Its OK','Maybe Something Wrong: Let me load again'); 
        switch  MakeSURE
        case 'Its OK'
            MakeSuperSure=questdlg([nfile,' is selected'],'Are you really sure?','Yes -_-','I DO NOt Know :(','Yes -_-');
                switch MakeSuperSure
                case 'Yes -_-'
                    disp(['Spectra file loaded from: ',npath]);
                    disp(['Spectra file name: ',nfile]);
                    disp(['NO ',FLOUVW,'.txt in file name but you are sure they are good! :)']);
                    exitFLAG=1;
                case 'I DO NOt Know :('
                    hbox=msgbox(['Format of data file name must be ',FLOUVW,'.txt']);
                end
        case 'Maybe Something Wrong: Let me load again'
            hbox=msgbox(['Format of data file name must be ',FLOUVW,'.txt']);
        end
    end
    
    
end
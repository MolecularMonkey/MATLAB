
queststrng1=['Please Load Trimmed Data # ',num2str(ii),' '];
queststrng2=['Ready to Load Trimmed Spectra #',num2str(ii),' ?'];
exitFLAG=0;
iterrr=0;

while  ~exitFLAG
    iterrr=iterrr+1;
    questdlg(queststrng1,queststrng2,['Lets GO Data Set No.',num2str(ii)],['Lets GO Data Set No.',num2str(ii)]); 
    if ii==1 && iterrr==1
        [nfile,npath] = uigetfile({'*.mat','CutSubstractHistory.MAT';'*.*',  'All Files (*.*)'},queststrng1);
        prevpath=npath;
    else
        [nfile,npath] = uigetfile({'*.mat','CutSubstractHistory.MAT';'*.*',  'All Files (*.*)'},queststrng1,prevpath);
        prevpath=npath;
    end
       
    if exist('CutSubstractHistory','var')
    clear CutSubstractHistory
    end
    
    load([npath,nfile]);
    
    if exist('CutSubstractHistory','var')
         disp(['CutSubstractHistory file loaded from: ',npath]);
         disp(['CutSubstractHistory file name: ',nfile]);
         disp('------')
         exitFLAG=1;
    else
        msgbox(['Your files:',npath,nfile,' does not have a variable named CutSubstractHistory']);
            MakeSuperSure=questdlg([nfile,' is not good'],'Break or Reload?','Let me load again -_-','Break :(','Let me load again -_-');
                switch MakeSuperSure
                case 'Break :('
                    clear MakeSuperSure
                error(['Loaded Wrong File',npath,nfile])
                case 'Let me load again -_-'
                    clear MakeSuperSure
                    disp('No CutSubstractHistory loaded; Maybe Something Wrong: Let me load again')
                end
    end
    
    
end
% Do not Clear <<prevpath>> -Need it later
clear queststrng1 queststrng2 exitFLAG iterrr
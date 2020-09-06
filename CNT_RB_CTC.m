questdlg('Please Load CNT file now','Ready 2 Load NanoTube Spectra?','Lets GO','Lets GO'); 
disp('--^^^^----^^^^-----^^^^----^^^^------^^^^----^^^^---')
[cntfile,cntpath] = uigetfile('*.txt');
fid=fopen([cntpath,cntfile],'rt');
formatspec='%f %f';
sizeCNT=[2 Inf];
CNT=fscanf(fid,formatspec,sizeCNT);
fclose(fid);
disp(['CNT file loaded from: ',cntpath]);
disp(['CNT file name: ',cntfile]);
questdlg('Please Load CNT + Rose Bengal[150uM] file now','Ready 2 Load CNT + RB Spectra?','Lets GO','Lets GO'); 
[RBfile,RBpath] = uigetfile('*.txt');
fid2=fopen([RBpath,RBfile],'rt');
CNTRB=fscanf(fid2,formatspec,sizeCNT);
fclose(fid2);
disp(['CNT+RB file loaded from: ',RBpath]);
disp(['CNT+RB file name: ',RBfile]);
load('RB_alone.mat')
disp('using saved RB data for [RB]=150uM') % U:\Data\NS1\nima\RB\1-30-20_onlyRB
disp('------------------------------------------------------------------------------------------');
if RB(1,1284)==CNTRB(1,1284) && CNTRB(1,1284)==CNT(1,1284)
   disp('Seems everything works')
else
    error('You probably need to change the code or you have loaded a wrong file')
end
%CTC_Band
disp('Dillution factor after addition of RB is considered 1.833')
CNT_DL=CNT(2,:).*(1000/1833);
CTC_Spctrm=CNTRB(2,:)-RB(2,:)-CNT_DL;
% 670.0810 nm = 1692
% 574.123 nm = 1284  
CTC_Band=0;
for ii=1284:1:1692
CTC_Band=CTC_Band+CTC_Spctrm(ii);
end
disp('==================================================')
fprintf('Integration of CTC Band resulted in \n %6.4f AUxnm and \n %6.4f AU \n',CTC_Band,CTC_Band/(670.0810-574.123));
disp('==================================================')
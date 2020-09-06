[nfile,npath] = uigetfile({'*.txt';'*.xls';'*.csv'});
    fid=fopen([npath,nfile],'rt');
    formatspec='%f %f';
    sizeCNT=[2 Inf];
    CNT=fscanf(fid,formatspec,sizeCNT);
    CNT=CNT';
    fclose(fid);
bala=max(CNT(:,2));
mmCNT(:,1)=CNT(:,1);
mmCNT(:,2)=CNT(:,2)./bala;
fid=fopen([npath,'norm_',nfile],'w');

formatspec='%f %f\n';

fprintf(fid,formatspec,mmCNT');
fclose(fid);

fid=fopen([npath,'norm_',nfile,'.csv'],'w');

formatspec='%f, %f\n';

fprintf(fid,formatspec,mmCNT');
fclose(fid);
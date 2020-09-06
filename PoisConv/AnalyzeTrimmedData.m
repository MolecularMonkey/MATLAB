dsfgprompt = {'How many Data Set Do You Want to Read/Analyze'};
dlgtitle = 'DataSetNo?';
dims = [1 50];
answer = inputdlg(prompt,dlgtitle,dims);
DataSetNo=str2double(answer{1, 1} );
MultipleAnalyzedTrimmedData={};
MultipleAnalyzedTrimmedData{1,1}='File address and name of Processed 2D of both pristine and trated file';
MultipleAnalyzedTrimmedData{1,2}='Emiss. Range. (1/CM)';
MultipleAnalyzedTrimmedData{1,3}='Substraction Excitations';
MultipleAnalyzedTrimmedData{1,4}='Substraction Coeffivients';
MultipleAnalyzedTrimmedData{1,5}='Functionalized Peak (1/Cm)' ;
MultipleAnalyzedTrimmedData{1,6}='Peak Shift (1/Cm)';
MultipleAnalyzedTrimmedData{1,7}='Functionalized FWHM (1/Cm)' ;
MultipleAnalyzedTrimmedData{1,8}='FWHM change(1/Cm)';
MultipleAnalyzedTrimmedData{1,9}='Functionalized FW0.2M';
MultipleAnalyzedTrimmedData{1,10}='FW0.2M Change';
MultipleAnalyzedTrimmedData{1,11}='Pristine FW0.2M';
MultipleAnalyzedTrimmedData{1,12}='Pristine FWHM (1/Cm)' ;
MultipleAnalyzedTrimmedData{1,13}='Pristine Peak (1/Cm)' ;
MultipleAnalyzedTrimmedData{1,14}='ID No.' ;
MultipleAnalyzedTrimmedData{1,15}='Pristine Norm. Wavenumber Spectra';
MultipleAnalyzedTrimmedData{1,16}='Treated Norm. Wavenumber Spectra';
%'FWHM Change 1/cm';

for ii=1:DataSetNo
   ReadTrimmedData 
   MultipleAnalyzedTrimmedData{ii+1,1}=CutSubstractHistory{2, 1};
   MultipleAnalyzedTrimmedData{ii+1,2}=CutSubstractHistory{2, 5};
   MultipleAnalyzedTrimmedData{ii+1,3}=CutSubstractHistory{1, 4};
   MultipleAnalyzedTrimmedData{ii+1,4}=CutSubstractHistory{2, 4};
   MultipleAnalyzedTrimmedData{ii+1,5}=CutSubstractHistory{2,12};
   MultipleAnalyzedTrimmedData{ii+1,6}=CutSubstractHistory{2,13};
   MultipleAnalyzedTrimmedData{ii+1,7}=CutSubstractHistory{2,15};
   MultipleAnalyzedTrimmedData{ii+1,8}=CutSubstractHistory{2,16};

     
        PCNT=CutSubstractHistory{2, 9}; %Normalized WaveNumber Spectra of Pristine (trimmed)
    if ii==1
        PristineWvnData(:,1)=PCNT(:,1); % wavelengths (nm)
        PristineWvnData(:,2)=PCNT(:,2); % Absorption or flourescenece Intensity
        disp('first data set loaded'); disp('********************************')
    else
        PristineWvnData(:,ii+1)=PCNT(:,2); % 
    end
       fCNT=CutSubstractHistory{2, 10}; %'Normalized WaveNumber Spectra of Treated (trimmed)'
    if ii==1
        TreatedWvnData(:,1)=fCNT(:,1); % wavelengths (nm)
        TreatedWvnData(:,2)=fCNT(:,2); % Absorption or flourescenece Intensity
        disp('first data set loaded'); disp('********************************')
    else
        TreatedWvnData(:,ii+1)=fCNT(:,2); % 
    end
    Tfw20m = fw20m(fCNT(:,1),fCNT(:,2));
    Pfw20m = fw20m(PCNT(:,1),PCNT(:,2));
    fw20mChange=Tfw20m-Pfw20m;
    MultipleAnalyzedTrimmedData{ii+1,9}=Tfw20m;
    MultipleAnalyzedTrimmedData{ii+1,10}=Pfw20m;
    MultipleAnalyzedTrimmedData{ii+1,11}=fw20mChange;
    MultipleAnalyzedTrimmedData{ii+1,12}=CutSubstractHistory{1,14};
    MultipleAnalyzedTrimmedData{ii+1,13}=CutSubstractHistory{2,11};
    MultipleAnalyzedTrimmedData{ii+1,14}=ii;
end
MultipleAnalyzedTrimmedData{2,15}=PristineWvnData;
MultipleAnalyzedTrimmedData{2,16}=TreatedWvnData;
%% Ploting Part
x=1220;
figure(x);
hold on
for ii=1:DataSetNo
    plot(PristineWvnData(:,1)',PristineWvnData(:,ii+1)','DisplayName',num2str(ii))
end
hold off
title('Pristine')
lgd = legend;
figure(x+1);
hold on
for ii=1:DataSetNo
    plot(TreatedWvnData(:,1)',TreatedWvnData(:,ii+1)','DisplayName',num2str(ii))
end
hold off
title('Treated')
lgd = legend;
%% Saving Part
[FileName,PathName]=uiputfile({'*.png;*.mat'},'Save Final Data As',prevpath);
mkdir(PathName,[FileName,'_TrimmedCompilation']);
PathName=[PathName,FileName,'_TrimmedCompilation\'];
for iii=1:2
figStr1=['-f',num2str(1219+iii)];
% Name of Image
if iii==1
figSavStr=[FileName,'Pristine'];
elseif iii==2
figSavStr=[FileName,'Treated'];
end
figSavStr=[PathName,figSavStr];
% End of Name of Image
print(figStr1,figSavStr,'-dpng');
end
save( [PathName,FileName,'.mat'], 'MultipleAnalyzedTrimmedData')
clear prompt dlgtitle dims answer
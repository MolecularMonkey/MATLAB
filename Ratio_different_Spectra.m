disp('Final Spectra has first column as wavelength and rest of the columns are corrected Dillution Factor spectra')
disp('-Wav (nm)--...--Spec1--...--Spec2--');
FinalDataname=input('Enter the name of Matrix: final multiple spectra in one \n     name is : \n','s');
eval(['FinalData=',FinalDataname,';']);
[a,b]=size(FinalData);
fprintf('your matrix has %6.0d columns and %6.0d Data Points \n',b,a)
FirstisWVLNGTH=questdlg('Is your 1st Column Wavelength data?','Is your 1st Column Wavelength data?','Yes','No','Yes');
    ExtFlg=0;    
    while ~ExtFlg
switch FirstisWVLNGTH
    case 'Yes'
        disp('so First column is x-axis and contains Wavelength data')
        fprintf('From  Cloumn 2 to column %5.0f which one is Refrence Spectra? \n , Enter a number between 2 and %5.0f \n',b,b);
        RefColNo=input('Enter the Column number for Refrence Spectra \n    ');
        if RefColNo>1 && round(RefColNo)==RefColNo && RefColNo<=b
            ExtFlg=1;
        elseif RefColNo==1
             disp('-_- Lets enter it again -_-')
             disp('You said First Column contains wvlngth data, Remember?')
        else
            disp('--Incorrect input--')
            disp('-_- Lets enter it again -_-')
        end
    case 'No'
        fprintf('From these %5.0f columns which one is your refrence spectra? \n Enter a number between 1 and %5.0d \n',b,b);
        RefColNo=input('Enter the Column number for Refrence Spectra \n    ');
        if RefColNo>0 && round(RefColNo)==RefColNo && RefColNo<=b
            ExtFlg=1;
        else
            disp('--Incorrect input--')
            disp('-_- Lets enter it again -_-')
        end
end
    end
RelativeSpec=zeros(size(FinalData));
switch FirstisWVLNGTH
    case 'Yes'
    RelativeSpec(:,1)=FinalData(:,1);
    for ii=2:b
    RelativeSpec(:,ii)=FinalData(:,ii)./FinalData(:,RefColNo);
    end
    case 'No'
        for ii=1:b
            RelativeSpec(:,ii)=FinalData(:,ii)./FinalData(:,RefColNo);
        end
end
%% Saving Part
[FileName,PathName]=uiputfile({'*.xlsx;*.mat;*.xls;*.csv'},'Save Final Data As');
LengthEstr=strlength(FileName);
fFname=eraseBetween(FileName,LengthEstr-3,LengthEstr);
svastr1=[PathName,fFname,'_RelSpectra.mat'];
save(svastr1,'FinalData','RelativeSpec')
svaEstr2=[PathName,fFname,'_RelSpec.xls'];
writematrix(RelativeSpec,svaEstr2)
%% Graphing Part
switch FirstisWVLNGTH
        case 'Yes'
x=7089+round(1900*rand);
figure(x);
hold on
for ii=2:b
    plot(RelativeSpec(:,1)',RelativeSpec(:,ii)')
end
hold off
title RelativeSpectra
end

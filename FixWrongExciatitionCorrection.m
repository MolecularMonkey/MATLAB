[sfile,spath] = uigetfile({'*.csv;*.mat','MAT and CSV';'*.csv','CSV';'*.mat','MAT';'*.*','All'},'Load 2D Spectra for Correction');
load('CorrctionFactors.mat','CorrctionFactors')
srtr=eraseBetween(sfile,1,length(sfile)-4);
if strcmpi(srtr,'.mat')
    load([spath,sfile],'RRRefBU')
    disp('MAT file was read in the following location:')
    disp([spath,sfile])
    Uncorrected2D=RRRefBU{2, 1}{1, 2};
    CorrectedSpectra=zeros(size(Uncorrected2D));
        for ii=1:size(CorrctionFactors,1)
        CorrectedSpectra(ii,:)= Uncorrected2D(ii,:).*CorrctionFactors(ii,2);
        end
    RRRefBU{2, 1}{1, 2}=    CorrectedSpectra;
    RRRefBU{2, 1}{2, 1}  =['Spectra Corrected for Wrong Excitation Correction Factors on ',date];
    RRRefBU{2, 6} =RRRefBU{2, 1}{2, 1};
    strfile=eraseBetween(sfile,length(sfile)-3,length(sfile));
    str2=[spath,'Corrected_',sfile];
    save(str2,'RRRefBU');
    disp('Data saved as MAT file in the following location: ')
    disp(str2);
    csvwrite([spath,'Corrected_',strfile,'.csv'],CorrectedSpectra);
    disp('CSV file was saved in the following location:')
    disp([spath,'Corrected_',strfile,'.csv'])  
elseif strcmpi(srtr,'.csv')
    disp('CSV file was read in the following location:')
    disp([spath,sfile])    
    Uncorrected2D=csvread([spath,sfile]);
    a=58;
    Excitation=Uncorrected2D(:,1);
    if Uncorrected2D(1,1)==0 && a==size(Excitation,1)
        disp('Very Raw DATA: Not Reference Corrected Data!')
        disp('Reference Has not been substracted from this data')
        [szeExcitation,szeEmission]=size(Uncorrected2D);
        Emission=Uncorrected2D(1,2:szeEmission);
        Spectra=Uncorrected2D(2:szeExcitation,2:szeEmission);
        CorrectediSpectra=zeros(size(Spectra));
        % ---- Correcting the Excitation
        for ii=1:size(CorrctionFactors,1)
        CorrectediSpectra(ii,:)= Spectra(ii,:).*CorrctionFactors(ii,2);
        end
        CorrectedSpectra=[Excitation,[Emission;CorrectediSpectra]];
        csvwrite([spath,'Corrected_raw_',sfile],CorrectedSpectra);
        disp(['Data Saved to: ',spath,'Corrected_raw_',sfile])
    elseif a~=size(Excitation,1)
        disp('Seems to me that Data has already been processed! and Reference has already been substracted from it!')
        CorrectedSpectra=zeros(size(Uncorrected2D));
        for ii=1:size(CorrctionFactors,1)
        CorrectedSpectra(ii,:)= Uncorrected2D(ii,:).*CorrctionFactors(ii,2);
        end
    csvwrite([spath,'Corrected_CSVonly_',sfile],CorrectedSpectra);
    disp(['Data Saved to: ',spath,'Corrected_CSVonly_',sfile])
    end
    %filter = {'*.csv'};
    %[file, path] = uiputfile(filter);

else
    error('Unknown File Type')
end
%% Loading Default Inputs
if exist('DefaultInputs_Pois1.mat','file')
    load('DefaultInputs_Pois1.mat')
else 
    makingDefaults3
    load('DefaultInputs_Pois1.mat')
end
%% Finding DATA:    FunctionalizedData_RRRefBU and PristineData_RRRefBU 
extflg=0;
while ~extflg
    LoadorRead=questdlg('Do you Want to Load 2D Data from Scratch or Read pre-processed 2D Data?','Load or Read ?',...
        'Read pre-loaded data either saved or in Workspace? (Both Pristine and Treated)','Load Separate 2D spectra raw or Ref Substracted?','Read pre-loaded data either saved or in Workspace? (Both Pristine and Treated)');
      switch LoadorRead
        case 'Read pre-loaded data either saved or in Workspace? (Both Pristine and Treated)'
            if ~exist('PristineData_RRRefBU','var') && ~exist('FunctionalizedData_RRRefBU','var') 
                  DoUhave=questdlg('MAT file with 2 spectra?','Do you have a mat-file that has 2D Data for BOTH the pristine and functionalized sample?','I have the MAT file, lets load','No I do not :(','I have the MAT file, lets load');
                   switch DoUhave
                   case 'I have the MAT file, lets load'
                         [fileName,filepath] = uigetfile({'*.mat';'*.mat'},'Load 1 mat file w/ 2D of Pristine and Functionalized sample');
                         load([filepath,fileName],'PristineData_RRRefBU','FunctionalizedData_RRRefBU') 
                         if exist('PristineData_RRRefBU','var') && exist('FunctionalizedData_RRRefBU','var') 
                            J_Subplot_figuring
                            extflg=1;
                         end
                   end
            else
                filepath=FunctionalizedData_RRRefBU{2, 4}{2, 2}; 
                pfn=PristineData_RRRefBU{2, 4}{2, 3};ffn=FunctionalizedData_RRRefBU{2, 4}{2, 3};
                fileName=[eraseBetween(pfn,strlength(pfn)-2,strlength(pfn)),eraseBetween(ffn,strlength(ffn)-3,strlength(ffn))];
                J_Subplot_figuring
                extflg=1; 
            end
         case 'Load Separate 2D spectra raw or Ref Substracted?'
             RaworRefSubstracted=questdlg('Has Reference been Substracted Or Not?','Ref-Substracted or Not?',...
             'I have Ref-Substracted 2D data','I have very raw 2D Spectra','I have very raw 2D Spectra');
         switch RaworRefSubstracted
             case 'I have very raw 2D Spectra'
                LoadingDataFrom2DFuncPrist
                extflg=1; 
             case 'I have Ref-Substracted 2D data'
                LoadingDataFrom2DFuncPrist_NotVeryRaw
               extflg=1; 
         end
      end 
end
%% SUBSTRACTING DATA
%% substracting more Excitiation Profile
Morre=questdlg('Substracting 1 or 2 Exc. Profile?','How Many Excitation Profile Do you want to substract from the main excitation Profile?','One 1','Two 2','One 1');
figgg=1004;
exxctflg=0;
 switch Morre
     case 'One 1'
definput1 = DefaultInputs{1,2};
prompt = {'Enter the Excitation Wavelength (nm) of your MAIN species   Excitation1(nm)','Enter the Excitation Wavelength (nm) of the INTERFERENCE   Excitation2(nm)'};
dlgtitle = 'Excitations?';
dims = [1 60];
DefCoeff=DefaultInputs{4,2};
while ~exxctflg
answer = inputdlg(prompt,dlgtitle,dims,definput1);
ExcitationWaveLength1=str2double(answer{1,1});
ExcitationWaveLength2=str2double(answer{2,1});
[coeff,Pristine_SubstractedSpectraWvnm,Pristine_SubstractedSpectraWvlg,Exc1,Exc2]=SSaSm(PristineData_RRRefBU,ExcitationWaveLength1,ExcitationWaveLength2,DefCoeff,figgg,figgg+1,1);
      SSSSatisfied=questdlg('Are you satisfied w/ the Excitation?',['Exc1: ',num2str(Exc1),'nm & Exc2:',num2str(Exc2),'nm for Sprctra?'],'Yes!','No?','Yes!');
      switch SSSSatisfied
       case 'Yes!'
          definput1{1,1}=num2str(Exc1);
          definput1{1,2} = num2str(Exc2);
          disp('----------------------');
          disp(['Spectra is from Excitation: ',num2str(Exc1),'nm but the spectra of Exc2:',num2str(Exc2),'nm is substracted from it'])
          disp('---');
          disp(['Coeeficient is ',num2str(coeff)]) 
          disp('----------------------');
          exxctflg=1;
        case 'No?'
          definput1{1,1}=num2str(Exc1);
          definput1{1,2} = num2str(Exc2);
      end 
end
DefaultInputs{1,2}=definput1;
DefaultInputs{4,2}=coeff;
[~,Trated_SubstractedSpectraWvnm,Trated_SubstractedSpectraWvlg,~,~]=SSaS(FunctionalizedData_RRRefBU,Exc1,Exc2,coeff,figgg+2,figgg+3);
     CutSubstractHistory{2,4}=['Main Spectra with Excitation ',num2str(ExcitationWaveLength1),'nm was selected and excitation profile w/ wavelength ',num2str(ExcitationWaveLength2),'nm was substracted from it after multiplying in coeeficient ',num2str(coeff)];
     CutSubstractHistory{1,4}=ExcitationWaveLength1; 
clear coeff definput1 DefCoeff
     case 'Two 2'
        definput2 = DefaultInputs{2,2};
        prompt = {'Enter the Excitation Wavelength (nm) of your MAIN species   Excitation1 (nm)   -- MAIN --','Enter the Excitation Wavelength (nm) of the INTERFERENCE   Excitation2 (nm)','Enter the Excitation Wavelength of the other INTERFERENCE   Excitation3 (nm)'};
        dlgtitle = 'Excitations?';
        dims = [1 60];
        Initialguess=DefaultInputs{5,2};
        Initialguess1=DefaultInputs{6,2};
while ~exxctflg
        answer = inputdlg(prompt,dlgtitle,dims,definput2);
        ExcitationWaveLength1=str2double(answer{1,1});
        ExcitationWaveLength2=str2double(answer{2,1});
        ExcitationWaveLength3=str2double(answer{3,1});
        [coeff1,coeff2,Pristine_SubstractedSpectraWvnm,Pristine_SubstractedSpectraWvlg,Exc1,Exc2,Exc3]=SSbSm(PristineData_RRRefBU,ExcitationWaveLength1,ExcitationWaveLength2,ExcitationWaveLength3,Initialguess,Initialguess1,figgg,figgg+1,1);
      SSSSatisfied=questdlg('Are you satisfied w/ the Excitation?',['Exc1: ',num2str(Exc1),'nm & Exc2:',num2str(Exc2),'nm for Sprctra?'],'Yes!','No?','Yes!');
      switch SSSSatisfied
       case 'Yes!'
          definput2{1,1}=num2str(Exc1);
          definput2{1,2} = num2str(Exc2);
          definput2{1,3} = num2str(Exc3);
          disp('----------------------');
          disp(['Main Spectra is from Excitation: ',num2str(Exc1),'nm >spectra of Exc2:',num2str(Exc2),'nm & Spectra of Exc3:',num2str(Exc3),'nm are substracted from it'])
          disp('---');
          disp(['Coeeficient is ',num2str(coeff1),' and ',num2str(coeff2)]) 
          disp('----------------------');
          exxctflg=1;
       case 'No?'
          definput2{1,1}=num2str(Exc1);
          definput2{1,2} = num2str(Exc2);
          definput2{1,3} = num2str(Exc3);
      end
end
DefaultInputs{2,2}=definput2;
DefaultInputs{5,2}=coeff1;
DefaultInputs{6,2}=coeff2;
          [~,~,Trated_SubstractedSpectraWvnm,Trated_SubstractedSpectraWvlg,~,~,~]=SSbS(FunctionalizedData_RRRefBU,Exc1,Exc2,Exc3,coeff1,coeff2,figgg+2,figgg+3);
        CutSubstractHistory{1,4}=['<FinalSpec = Spec1 - C1.Spec2 - C2.Spec3>',' >>Spec1 Exc: ',num2str(Exc1),'nm >>Spec2 Exc: ',num2str(Exc2),'nm >>Spec3 Exc: ',num2str(Exc3)];
        CutSubstractHistory{2,4}=['C1 is ',num2str(coeff1),'C2 is ',num2str(coeff2)];
          clear definput2 coeff1 coeff2 Exc3
 end

%% Extracting single n,m Data 
definput3 = DefaultInputs{3,2};
prompt = {'Enter the Start Wavelength (nm) of the Emission range of your species  LowerBound(nm)','Enter the End Wavelength (nm) of the Emission range of your species  upperBound(nm)','Enter 0 to stop the code'};
dlgtitle = 'Emission Range?';
dims = [1 70]; remainflg=1;ccount=0;
while remainflg
    answer = inputdlg(prompt,dlgtitle,dims,definput3);
    Emiss1=str2double(answer{1,1});
    Emiss2=str2double(answer{2,1});
    definput3{1,1}=answer{1,1};
    definput3{1,2} = answer{2,1};
    ccount=ccount+1;
    % wavelength graph updated
    if ccount>1
          delete(h0);delete(h1);delete(h2);delete(h3);delete(h4);delete(h5);delete(h6);delete(h7);delete(h8);delete(h9);delete(h10);
          delete(h11);delete(h12);delete(h13);delete(h14);delete(h15);      
    end
 switch Morre
     case 'One 1'
    figure(figgg+1)
    subplot(3,1,1)
    hold on
    h0=xline(Emiss1);h1=xline(Emiss2);
    hold off
    subplot(3,1,3)
    hold on
    h2=xline(Emiss1);h3=xline(Emiss2);
    hold off
    figure(figgg+3)
    subplot(3,1,1)
    hold on
    h4=xline(Emiss1);h5=xline(Emiss2);
    hold off
    subplot(3,1,3)
    hold on
    h6=xline(Emiss1);h7=xline(Emiss2);
    hold off
    % wavenumber graph updated
    Emiss1vwn=wvl2wvn(Emiss1);
    Emiss2vwn=wvl2wvn(Emiss2);
    figure(figgg)
    subplot(3,1,1)
    hold on
    h8=xline(Emiss1vwn);h9=xline(Emiss2vwn);
    hold off
    subplot(3,1,3)
    hold on
    h10=xline(Emiss1vwn);h11=xline(Emiss2vwn);
    hold off
    figure(figgg+2)
    subplot(3,1,1)
    hold on
    h12=xline(Emiss1vwn);h13=xline(Emiss2vwn);
    hold off
    subplot(3,1,3)
    hold on
    h14=xline(Emiss1vwn);h15=xline(Emiss2vwn);
    hold off
     case 'Two 2'
    figure(figgg+1)
    subplot(2,2,2)
    hold on
    h0=xline(Emiss1);h1=xline(Emiss2);
    hold off
    subplot(2,2,4)
    hold on
    h2=xline(Emiss1);h3=xline(Emiss2);
    hold off
    figure(figgg+3)
    subplot(2,2,2)
    hold on
    h4=xline(Emiss1);h5=xline(Emiss2);
    hold off
    subplot(2,2,4)
    hold on
    h6=xline(Emiss1);h7=xline(Emiss2);
    hold off
    % wavenumber graph updated
    Emiss1vwn=wvl2wvn(Emiss1);
    Emiss2vwn=wvl2wvn(Emiss2);
    figure(figgg)
    subplot(2,2,2)
    hold on
    h8=xline(Emiss1vwn);h9=xline(Emiss2vwn);
    hold off
    subplot(2,2,4)
    hold on
    h10=xline(Emiss1vwn);h11=xline(Emiss2vwn);
    hold off
    figure(figgg+2)
    subplot(2,2,2)
    hold on
    h12=xline(Emiss1vwn);h13=xline(Emiss2vwn);
    hold off
    subplot(2,2,4)
    hold on
    h14=xline(Emiss1vwn);h15=xline(Emiss2vwn);
    hold off   
 end
    remainflg=str2double(answer{3,1});
end
DefaultInputs{3,2}=definput3;
%% Plotting
disp('Prisrine')
    Pristine_SubstractedSpectraWvnm_cut=CutSpectrum(Pristine_SubstractedSpectraWvnm',Emiss2vwn,Emiss1vwn);
    Pristine_SubstractedSpectraWvlg_cut=CutSpectrum(Pristine_SubstractedSpectraWvlg',Emiss1,Emiss2);
disp('Treated')
    Trated_SubstractedSpectraWvnm_cut=CutSpectrum(Trated_SubstractedSpectraWvnm',Emiss2vwn,Emiss1vwn);
    Trated_SubstractedSpectraWvlg_cut=CutSpectrum(Trated_SubstractedSpectraWvlg',Emiss1,Emiss2);
    figure(figgg+4)
    subplot(2,2,1)    
    plot(Pristine_SubstractedSpectraWvlg_cut(:,1),Pristine_SubstractedSpectraWvlg_cut(:,2));
    title({['Exc: ',num2str(Exc1),'nm'];'Pristine'})
    subplot(2,2,2)
    plot(Pristine_SubstractedSpectraWvnm_cut(:,1),Pristine_SubstractedSpectraWvnm_cut(:,2));
    title({['Exc: ',num2str(Exc1),'nm'];'Pristine'})
    subplot(2,2,3)
    plot(Trated_SubstractedSpectraWvlg_cut(:,1),Trated_SubstractedSpectraWvlg_cut(:,2));
    title({['Exc: ',num2str(Exc1),'nm'];'Treated'})
    xlabel('wavelength (nm)')
    subplot(2,2,4);
    plot(Trated_SubstractedSpectraWvnm_cut(:,1),Trated_SubstractedSpectraWvnm_cut(:,2));
    xlabel('wavenumber (1/cm)')
    title({['Exc: ',num2str(Exc1),'nm'];'Treated'})
    %% Normalize Spectrum
    functionalizedCNTwvn=NormSpec(Trated_SubstractedSpectraWvnm_cut);
    PristineCNTwvn=NormSpec(Pristine_SubstractedSpectraWvnm_cut);
    figure(figgg+5);
    plot(PristineCNTwvn(:,1),PristineCNTwvn(:,2),functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2));
    title(['Exc: ',num2str(Exc1),'nm']);
    xlabel('Wavenumber 1/cm')
    ylabel('Normalized Intensity')
    legend('Pristine','Treated')
    figure(figgg+6)
    plot(Pristine_SubstractedSpectraWvlg_cut(:,1),Pristine_SubstractedSpectraWvlg_cut(:,2),Trated_SubstractedSpectraWvlg_cut(:,1),Trated_SubstractedSpectraWvlg_cut(:,2));
    title(['Exc: ',num2str(Exc1),'nm']);
    xlabel('Wavelength 1/cm')
    ylabel('Intensity')
    legend('Pristine','Treated')
    figure(figgg+7)
    functionalizedCNTWvlg=NormSpec(Trated_SubstractedSpectraWvlg_cut);
    PristineCNTWvlg=NormSpec(Pristine_SubstractedSpectraWvlg_cut);
    plot(PristineCNTWvlg(:,1),PristineCNTWvlg(:,2),functionalizedCNTWvlg(:,1),functionalizedCNTWvlg(:,2));
    title(['Exc: ',num2str(Exc1),'nm']);
    xlabel('Wavelength 1/cm')
    ylabel('Normalized Intensity')
    legend('Pristine','Treated')
    %% FWHM and Peak 
    % Peak
    [~,I]=max(PristineCNTwvn(:,2));
    PristinePeak=PristineCNTwvn(I,1);
    [~,I]=max(functionalizedCNTwvn(:,2));
    FunctionalizedPeak=functionalizedCNTwvn(I,1);
    PeakShift=FunctionalizedPeak-PristinePeak;
    % FWHM
    PristineFWHM=fwhm(PristineCNTwvn(:,1),PristineCNTwvn(:,2));
    FunctionalizedFWHM=fwhm(functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2));
    FWHMchange=FunctionalizedFWHM-PristineFWHM;
    %% Reference Back UP
CutSubstractHistory{1,1}='File address and name of Processed 2D of both pristine and trated file';
CutSubstractHistory{2,1}=[filepath,fileName];
CutSubstractHistory{1,2}='Pristine Spectra Name and Address';
CutSubstractHistory{2,2}=PristineData_RRRefBU{2, 4}{2, 1};
CutSubstractHistory{1,3}='Functionalized Spectra Name and Address';
CutSubstractHistory{2,3}=FunctionalizedData_RRRefBU{2, 4}{2, 1} ;
CutSubstractHistory{1,5}=['Cut Wavelength Emission Range; Lower limit: ',num2str(Emiss1),'nm and upper limit: ',num2str(Emiss2),'nm'];
CutSubstractHistory{2,5}=['Cut Wavenumber Emission Range; Lower limit: ',num2str(Emiss1vwn),'cm-1 and upper limit: ',num2str(Emiss2vwn),'cm-1'];
CutSubstractHistory{1,6}='Pristine Spectra Cut';
CutSubstractHistory{2,6}{1,1}='Wavenumber spectra';
CutSubstractHistory{2,6}{1,2}=Pristine_SubstractedSpectraWvnm_cut;
CutSubstractHistory{2,6}{2,1}='Wavelength spectra';
CutSubstractHistory{2,6}{2,2}=Pristine_SubstractedSpectraWvlg_cut;
CutSubstractHistory{1,7}='Trated Spectra Cut';
CutSubstractHistory{2,7}{1,1}='Wavenumber spectra';
CutSubstractHistory{2,7}{1,2}=Trated_SubstractedSpectraWvnm_cut;
CutSubstractHistory{2,7}{2,1}='Wavelength spectra';
CutSubstractHistory{2,7}{2,2}=Trated_SubstractedSpectraWvlg_cut;
CutSubstractHistory{1,8}='filepath';
CutSubstractHistory{2,8}=filepath;
CutSubstractHistory{1,9}='Normalized WaveNumber Spectra of Pristine (trimmed)';
CutSubstractHistory{2,9}= PristineCNTwvn;
CutSubstractHistory{1,10}='Normalized WaveNumber Spectra of Treated (trimmed)';
CutSubstractHistory{2,10}= functionalizedCNTwvn;
CutSubstractHistory{1,11}='Pristine Peak (1/Cm)' ;
CutSubstractHistory{2,11}=PristinePeak;
CutSubstractHistory{1,12}='Functionalized Peak (1/Cm)' ;
CutSubstractHistory{2,12}=FunctionalizedPeak;
CutSubstractHistory{1,13}='Peak Shift (1/Cm)' ;
CutSubstractHistory{2,13}=PeakShift;
CutSubstractHistory{1,14}='Pristine FWHM (1/Cm)' ;
CutSubstractHistory{2,14}=PristineFWHM;
CutSubstractHistory{1,15}='Functionalized FWHM (1/Cm)' ;
CutSubstractHistory{2,15}=FunctionalizedFWHM;
CutSubstractHistory{1,16}='FWHM change(1/Cm)' ;
CutSubstractHistory{2,16}=FWHMchange;

%% Saving Part
    [FileName,PathName]=uiputfile('*.mat','Save Final Data As',filepath);
    mkdir(PathName,[eraseBetween(FileName,strlength(FileName)-3,strlength(FileName)),'_cut_',num2str(Exc1)]); %[eraseBetween(FileName,strlength(FileName)-4,strlength(FileName))
    PathName=[PathName,eraseBetween(FileName,strlength(FileName)-3,strlength(FileName)),'_cut_',num2str(Exc1),'\'];
    save([PathName,FileName,'.mat'],'CutSubstractHistory')
    disp('MAT file data of trimmed functionalized and pristine 2D saved');
    disp(['Data saved to: ',PathName,FileName]);
    %% Printing part 
for iii=figgg-3:figgg+5
figStr1=['-f',num2str(iii)];
% Name of Image
figSavStr=[eraseBetween(FileName,strlength(FileName)-3,strlength(FileName)),num2str(iii)];
figSavStr=[PathName,figSavStr,'.png'];
% End of Name of Image
print(figStr1,figSavStr,'-dpng');
end
%% Saving Default Inputs
save DefaultInputs_Pois1.mat DefaultInputs
%% Clearing Part 
clear DoUhave answer dims dlgtitle Excitation Emission figgg
clear fileName FileName filepath FinalSpectra LoadorRead Pristine_SubstractedSpectraWvlg Pristine_SubstractedSpectraWvnm
clear prompt remainflg Trated_SubstractedSpectraWvlg Trated_SubstractedSpectraWvnm X Y
clear pfn iii extflg ffn figSavStr figStr1 Exc1 Exc2 ccount
clear h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15
clear definput3 Exc2
clear exxctflg SSSSatisfied


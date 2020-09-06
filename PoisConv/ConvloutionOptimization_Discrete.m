%% Finding DATA:    FunctionalizedData_RRRefBU and PristineData_RRRefBU 
extflg=0;
while ~extflg
    LoadorRead=questdlg('Do you Want to Load and prepare the trimmed Data from Scratch or Read pre-processed pre-trimmed Data?','Load or Read ?',...
        'Read Pre-processed Pre-Trimmed Data either saved as MAT or in Workspace?','Load and Process Raw Spectra?','Read Pre-processed Pre-Trimmed Data either saved as MAT or in Workspace?');
      switch LoadorRead
        case 'Read Pre-processed Pre-Trimmed Data either saved as MAT or in Workspace?'
            if ~exist('CutSubstractHistory','var') 
                  DoUhave=questdlg('MAT file with 2 trimmed spectra?','Do you have a mat-file that has trimmed data for BOTH the pristine and functionalized sample?','I have the MAT file, lets load','No I do not :(','I have the MAT file, lets load');
                   switch DoUhave
                   case 'I have the MAT file, lets load'
                         [fileName,filepath] = uigetfile({'*.mat';'*.mat'},'Load 1 mat file w/ 2D of Pristine and Functionalized sample');
                         load([filepath,fileName],'CutSubstractHistory') 
                         if exist('CutSubstractHistory','var')
                            extflg=1;
                         end
                   end
                   PristineCNTwvn=CutSubstractHistory{2,9};
                   functionalizedCNTwvn=CutSubstractHistory{2,10};
            else
                   PristineCNTwvn=CutSubstractHistory{2,9};
                   functionalizedCNTwvn=CutSubstractHistory{2,10};
                   filepath=CutSubstractHistory{2,8};
                   extflg=1; 
            end
         case 'Load and Process Raw Spectra?'
             PreparationofDATAfrom2DFiles_v8_27
             PristineCNTwvn=CutSubstractHistory{2,9};
             functionalizedCNTwvn=CutSubstractHistory{2,10};
             filepath=CutSubstractHistory{2,8};
             extflg=1; 
      end 
end
%% Start of the Code
gfiggg=1010;
figure(gfiggg);
subplot(3,1,1)
plot(PristineCNTwvn(:,1),PristineCNTwvn(:,2))
title('Pristine CNT') ; ylabel('Normalized Intensity')
    [~,I]=max(PristineCNTwvn(:,2));
    peakvalue_pristine=PristineCNTwvn(I,1);
    width_pristine=fwhm(PristineCNTwvn(:,1),PristineCNTwvn(:,2));
    text(peakvalue_pristine-width_pristine/10,0.5,'\leftarrow FWHM \rightarrow');
    text(peakvalue_pristine,0.4,num2str(width_pristine));
    text(peakvalue_pristine,0.9,['\uparrow ',num2str(peakvalue_pristine)])
subplot(3,1,2)
plot(functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2))
[~,I]=max(functionalizedCNTwvn(:,2));
peakvalue_functionalized=functionalizedCNTwvn(I,1);
width_functionalized=fwhm(functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2));
title('Functionalized CNT'); ylabel('Normalized Intensity')
    text(peakvalue_functionalized-width_functionalized/10,0.5,'\leftarrow FWHM \rightarrow');
    text(peakvalue_functionalized,0.4,num2str(width_functionalized));
    text(peakvalue_functionalized,0.9,['\uparrow ',num2str(peakvalue_functionalized)])
    %% Optimization Part
    % timed 1000000
%Variables2BOpt(1)=lambda;
%Variables2BOpt(2)=ChangeperFunctionalization;   
Spectra=PristineCNTwvn;
X=Spectra(:,1);
Intensity=Spectra(:,2);
%PoissionCorrelation2(lambda,ChangeperFunctionalization,Spectrax,Spectray)
ModeledFunction=@(Variables2BOpt,X)PoissionCorrelation_Discrete2(Variables2BOpt(1),Variables2BOpt(2),X,Intensity);
    Variables2BOpt0(1)=0.005;
    Variables2BOpt0(2)=95;
    %Not Usefull%[x,resnorm,~,exitflag,output] = lsqcurvefit(ModeledFunction,Variables2BOpt0,functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2));
    Fsumsquares = @(Variables2BOpt)(1000000*sum((ModeledFunction(Variables2BOpt,X) - functionalizedCNTwvn(:,2)).^2));
    opts = optimoptions('fminunc','Algorithm','quasi-newton','StepTolerance',eps,'FunctionTolerance',eps);
    [xunc,ressquared,eflag,outputu] = ...
    fminunc(Fsumsquares,Variables2BOpt0,opts);
%% 
lambda=xunc(1);
ChangeperFunctionalization=xunc(2); 

    %hx = PoissionCorrelation(lambda,ChangeperFunctionalization,Spectra(:,1),Intensity);
    hx = PoissionCorrelation_Discrete(Spectra,lambda,ChangeperFunctionalization);
    %% Visualization
    [~,I]=max(Intensity);
    peakvalue_pristine=X(I); 
    % plotting Part
    figure(gfiggg+1);
    PoisFunc=poisspdf((X-peakvalue_pristine)./ChangeperFunctionalization,lambda);
    %integerr=([0:10].*ChangeperFunctionalization)+peakvalue_pristine;
    %ingPoisFunc=ContPoission((integerr-peakvalue_pristine)./ChangeperFunctionalization,lambda);
    subplot(3,1,1)
    plot(X,Intensity);
    title('Pristine CNT spectrum')
    text(peakvalue_pristine,0.9,['\uparrow ',num2str(peakvalue_pristine)])
    width_pristine=fwhm(X,Intensity);
    text(peakvalue_pristine-width_pristine./10,0.5,'\leftarrow FWHM \rightarrow')
    text(peakvalue_pristine,0.4,num2str(width_pristine))
    ylabel('Normalized Intensity')
    subplot(3,1,2) 
    plot(X,PoisFunc)
    title('Probability Distribution Profile')
    ylabel('Probability')
    %hold on
    %plot(integerr,ingPoisFunc,'o');
    %hold off
    text(peakvalue_pristine-width_pristine./2,0.1,['\lambda: ',num2str(lambda)])
    text(peakvalue_pristine-1.2.*width_pristine,0.055,['RedShift/G: ',num2str(ChangeperFunctionalization),'(1/cm)'])
    subplot(3,1,3)
    plot(hx(:,1),hx(:,2));
    xlabel('Optical Frequency 1/cm'); ylabel('Normalized Intensity')
    [~,I]=max(hx(:,2));
    peakvalue_modeled=hx(I,1);
    width_modeled=fwhm(hx(:,1),hx(:,2));
    title('Modeled Spectrum')
    text(peakvalue_modeled-width_modeled/10,0.5,'\leftarrow FWHM \rightarrow');
    text(peakvalue_modeled,0.4,num2str(width_modeled));
    text(peakvalue_modeled,0.9,['\uparrow ',num2str(peakvalue_modeled)])
    figure(gfiggg);
    subplot(3,1,3);
    plot(hx(:,1),hx(:,2)); hold on
    plot(functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2));
    title('Modeled Spectrum')
    legend('Modeled Spectrum','Experimental Data');
    hold off
    xlabel('Optical Frequency 1/cm'); ylabel('Normalized Intensity')
    title('Modeled Spectrum')
    text(peakvalue_modeled-width_modeled/10,0.5,'\leftarrow FWHM \rightarrow');
    text(peakvalue_modeled,0.4,num2str(width_modeled));
    text(peakvalue_modeled,0.9,['\uparrow ',num2str(peakvalue_modeled)])
load('CNTDATA_ofSP_1.mat');
PristineCNT=FULL7_6Data(:,[1,2]);
functionalizedCNT=FULL7_6Data(:,[1,3]);
PristineCNTwvn=wvlspec2wvn_f(PristineCNT')';
functionalizedCNTwvn=wvlspec2wvn_f(functionalizedCNT')';
figure(1111)
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
%hold on
%Splnefitted=spline(functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2),PristineCNTwvn(:,1));
%plot(PristineCNTwvn(:,1),Splnefitted);
%hold off;legend('Experimental Spectra','')
[~,I]=max(functionalizedCNTwvn(:,2));
peakvalue_functionalized=functionalizedCNTwvn(I,1);
peakvalue_functionalized2=8843;
width_functionalized=fwhm(functionalizedCNTwvn(:,1),functionalizedCNTwvn(:,2));
title('Functionalized CNT'); ylabel('Normalized Intensity')
    text(peakvalue_functionalized-width_functionalized/10,0.5,'\leftarrow FWHM \rightarrow');
    text(peakvalue_functionalized,0.4,num2str(width_functionalized));
    text(peakvalue_functionalized,0.9,['\uparrow ',num2str(peakvalue_functionalized)])
    %peakvalue=8914;% Max of Pristine Peak here is 8914 1/Cm
    lambda=1.0;
    ChangeperFunctionalization=95;
    Spectra=PristineCNTwvn;
    X=Spectra(:,1);
    Intensity=Spectra(:,2);
    Px = PoissionCorrelation2(lambda,ChangeperFunctionalization,X,Intensity);
    hx=NormSpec(Px);
    [~,I]=max(Intensity);
    peakvalue_pristine=X(I); 
    % plotting Part
    figure(23)
    PoisFunc=ContPoission((X-peakvalue_pristine)./ChangeperFunctionalization,lambda);
    integerr=([0:10].*ChangeperFunctionalization)+peakvalue_pristine;
    ingPoisFunc=ContPoission((integerr-peakvalue_pristine)./ChangeperFunctionalization,lambda);
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
    hold on
    plot(integerr,ingPoisFunc,'o');
    hold off
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
    figure(1111)
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
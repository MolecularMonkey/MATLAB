function [Px] = PoissionCorrelation_Discrete2(lambda,ChangeperFunctionalization,Spectrax,Spectray)
%PoissionCorrelation computes the cross correlation of Spectra with a poision functions
%   Normalization part at the end 
%check to see if f and g have the right dimensions
[bf0,bf1]=size(Spectrax);
[bf2,bf3]=size(Spectray);
if bf1~=1 || bf3~=1 
    error('dimensions of input Spectra should be Nx1')
end
if bf0~=bf2
    error('dimensions of input Spectra should match')
end

if ~exist('ChangeperFunctionalization','var')
    ChangeperFunctionalization=1;
end
   X=Spectrax;
   Intensity=Spectray;
   y=zeros(size(X));
for iii=1:length(X)
    xi=X(iii);
    PoisFunc=poisspdf((X-xi)./ChangeperFunctionalization,lambda);
    y(iii)=trapz(X,Intensity.*PoisFunc);
end
    %z(:,1)=X;
    %z(:,2)=y;
    %% Normalization Part
    maxy=max(y);
    Px =y./maxy;
end


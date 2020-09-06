function [hx] = PoissionCorrelation_Discrete(Spectra,lambda,ChangeperFunctionalization)
%PoissionCorrelation computes the cross correlation of Spectra with a poision functions
%   Detailed explanation goes here
%check to see if f and g have the right dimensions
[~,bf]=size(Spectra);
if bf~=2 
    error('dimensions of input Spectra should be Nx2')
end
if ~exist('ChangeperFunctionalization','var')
    ChangeperFunctionalization=1;
end
   X=Spectra(:,1);
   Intensity=Spectra(:,2);
   y=zeros(size(X));
for iii=1:length(X)
    xi=X(iii);
    PoisFunc=poisspdf((X-xi)./ChangeperFunctionalization,lambda);
    y(iii)=trapz(X,Intensity.*PoisFunc);
end
    z(:,1)=X;
    z(:,2)=y;
    hx = NormSpec(z);
end


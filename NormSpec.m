function NormalizedSpectrum = NormSpec(Spectra)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[~,bf]=size(Spectra);
if bf~=2 
    error('dimensions of input Spectra should be Nx2')
end
bala=max(Spectra(:,2));
NormalizedSpectrum(:,1)=Spectra(:,1);
NormalizedSpectrum(:,2)=Spectra(:,2)./bala;
end


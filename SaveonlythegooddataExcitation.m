CorrctionFactors=zeros(57,2);
for ii=1:size(CorrectionFactorsAll,1)
    Excii=CorrectionFactorsAll(ii,1);
    if ~mod(Excii,5)
        n=Excii/5-103;
        CorrctionFactors(n,2)=CorrectionFactorsAll(ii,2);
        CorrctionFactors(n,1)=Excii;
    end
end    
save CorrctionFactors CorrctionFactors CorrectionFactorsAll
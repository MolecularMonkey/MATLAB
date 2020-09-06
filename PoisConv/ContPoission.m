function y=ContPoission(x,lambda)
[a,b]=size(lambda);
if a~=1 || b~=1
    error('lambda should be scalar')
end
if lambda>30
    disp('{please take a look at >> doc NormalDistribution ')
    error('For large lambda: please use Normal Distribution Function not Poisson')
elseif lambda<1e-6
     error('Too small value for lambda')
elseif lambda>=16 
        NC= 1.000; 
else
        load NormalizationConstant_Total.mat NCT lambdavalues
        NC=interp1(lambdavalues,NCT,lambda,'spline');

end
%disp(['Value of lambda is ',num2str(lambda)])
%disp(['Value of Normalization Constant is ',num2str(NC)])
%% Function
y=zeros(size(x));
for i=1:length(x)
    xi=x(i);
    if xi<0
        y(i)=0;
    else
        y(i)=(exp(-lambda).*lambda.^(xi)./gamma(xi+1))./NC;
    end
end
end
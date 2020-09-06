function [BaseLineCorrected,Row2Choose1,Row2Choose2,Row2Choose3,Row2Choose4,AverageData]=BaseLineRaman(RawData,OF1,OF2,OF3,OF4)
% averaging to find baseline
% base line area to substract from is from OF1=1.110419e+03;OF2=1.22076e+03; 1/cm to OF1=1.110419e+03;OF2=1.22076e+03 1/cm
%% Finding the indices corresponding to OF1 thru OF4 
if OF1>OF2
    error('OF1 should be greater than OF2');
elseif OF3<OF2 || OF4<OF3
    error('Order Should be OF1<OF2<OF3<OF4');
end
DifferenceMatrix=666*ones(size(RawData,1),4);
Row2Choose1=0;
Row2Choose2=0;
Row2Choose3=0;
Row2Choose4=0;
[llength,bb]=size(RawData);
OpticalFrequencies=RawData(:,1);
for nn=1:llength
    DifferenceMatrix(nn,1)=abs(OpticalFrequencies(nn)-OF1);
    if DifferenceMatrix(nn,1)==0 && nn>1
        Row2Choose1=nn;
        break
    end
end
if Row2Choose1==0
    [minVal1,ind1]=min(DifferenceMatrix(:,1));
    if minVal1>15
        error('No Optic. freq. close to OF1 were found')
    elseif ind1==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Point to 1st for avaraging is %6.1f \n',OpticalFrequencies(ind1))
        Row2Choose1=ind1;
    end
end
for mm=Row2Choose1:llength
    DifferenceMatrix(mm,2)=abs(OpticalFrequencies(mm)-OF2);
    if DifferenceMatrix(mm,2)==0 && mm>1
        Row2Choose2=mm;
        break
    end
end
if Row2Choose2==0
    [minVal2,ind2]=min(DifferenceMatrix(:,2));
    if minVal2>15
        error('No Optic. freq. close to the OF2 were found')
    elseif ind2==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Point to 2nd for avaraging is %6.1f \n',OpticalFrequencies(ind2))
        Row2Choose2=ind2;
    end
end
for oo=Row2Choose2:llength
    DifferenceMatrix(oo,3)=abs(OpticalFrequencies(oo)-OF3);
    if DifferenceMatrix(oo,3)==0 && oo>1
        Row2Choose3=oo;
        break
    end
end
if Row2Choose3==0
    [minVal3,ind3]=min(DifferenceMatrix(:,3));
    if minVal3>15
        error('No Optic. freq. close to the OF3 were found')
    elseif ind3==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Point to 3rd for avaraging is %6.1f \n',OpticalFrequencies(ind3))
        Row2Choose3=ind3;
    end
end
for pp=Row2Choose3:llength
    DifferenceMatrix(pp,4)=abs(OpticalFrequencies(pp)-OF4);
    if DifferenceMatrix(pp,4)==0 && pp>1
        Row2Choose4=pp;
        break
    end
end
if Row2Choose4==0
    [minVal4,ind4]=min(DifferenceMatrix(:,2));
    if minVal4>15
        error('No Optic. freq. close to OF4 were found')
    elseif ind4==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Point to 2nd for avaraging is %6.1f \n',OpticalFrequencies(ind4))
        Row2Choose4=ind4;
    end
end
%% Averaging the Base Line
AverageData=zeros(1,bb);
BaseLineCorrected=zeros(size(RawData));
BaseLineCorrected(:,1)=RawData(:,1);
for jj=2:bb
AverageData(jj)=mean(RawData([Row2Choose1:Row2Choose2,Row2Choose3:Row2Choose4],jj));
BaseLineCorrected(:,jj)=RawData(:,jj)-AverageData(jj);
end

end
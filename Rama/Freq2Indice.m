function [Row2Choose1f,Row2Choose2f]=Freq2Indice(SData,OF1,OF2)
if OF1>OF2
    error('OF1 should be less than OF2');
end
DifferenceMatrix=666*ones(size(SData,1),2);
Row2Choose1f=0;
Row2Choose2f=0;
[llength,~]=size(SData);
OpticalFrequencies=SData(:,1);
for nn=1:llength
    DifferenceMatrix(nn,1)=abs(OpticalFrequencies(nn)-OF1);
    if DifferenceMatrix(nn,1)==0 && nn>1
        Row2Choose1f=nn;
        break
    end
end
if Row2Choose1f==0
    [minVal1,ind1]=min(DifferenceMatrix(:,1));
    if minVal1>15
        error('No Optic. freq. close to OF1 were found')
    elseif ind1==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Point to 1st OF is %6.1f \n',OpticalFrequencies(ind1))
        Row2Choose1f=ind1;
    end
end
for mm=Row2Choose1f:llength
    DifferenceMatrix(mm,2)=abs(OpticalFrequencies(mm)-OF2);
    if DifferenceMatrix(mm,2)==0 && mm>1
        Row2Choose2f=mm;
        break
    end
end
if Row2Choose2f==0
    [minVal2,ind2]=min(DifferenceMatrix(:,2));
    if minVal2>15
        error('No Optic. freq. close to the OF2 were found')
    elseif ind2==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Point to 2nd OF is %6.1f \n',OpticalFrequencies(ind2))
        Row2Choose2f=ind2;
    end
end
end
function CuttedSpectra=CutSpectrum(RawData,X1,X2)
DifferenceMatrix=666*ones(size(RawData,1),2);
if X1>X2
    error('X1 should be less than X2');
end
Row2Choose1=0;
Row2Choose2=0;
[llength,~]=size(RawData);
XDATA=RawData(:,1);
for nn=1:llength
    DifferenceMatrix(nn,1)=abs(XDATA(nn)-X1);
    if DifferenceMatrix(nn,1)==0 %&& nn>1
        Row2Choose1=nn;
        break
    end
end
if Row2Choose1==0
    [minVal1,ind1]=min(DifferenceMatrix(:,1));
    if minVal1>25
        error('No X close to X1 were found')
    else
        %fprintf('Nearest Available Point to 1st X is %6.1f \n',XDATA(ind1))
        Row2Choose1=ind1;
    end
end
for mm=Row2Choose1:llength
    DifferenceMatrix(mm,2)=abs(XDATA(mm)-X2);
    if DifferenceMatrix(mm,2)==0 && mm>1
        Row2Choose2=mm;
        break
    end
end

if Row2Choose2==0
    [minVal2,ind2]=min(DifferenceMatrix(:,2));
    if minVal2>25
        error('No X close to the X2 were found')
    else
        %fprintf('Nearest Available Point to 2nd X is %6.1f \n',XDATA(ind2))
        Row2Choose2=ind2;
    end
end
CuttedSpectra(:,1)=RawData(Row2Choose1:Row2Choose2,1);
CuttedSpectra(:,2)=RawData(Row2Choose1:Row2Choose2,2);
fprintf('Spectra were Cut from %6.1f to %6.1f \n',XDATA(ind1),XDATA(ind2))
end

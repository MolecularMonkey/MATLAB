function [AdsorptionCombined] = CombAbs(VISwvlnght1,VISNIRwvl,NIRwvlnght2,VISAbs,NIRAbs)
%UNTITLED2 Summary of this function goes here
%   CUT VISAbs from VISwvlnght1 to NIRwvlnght2
%   CUT NIRAbs from NIRwvlnght2 unitll the end
%   Concatenate two files together
% first cut NIR From here (after reaching to this value )
NIR_Row2Choose=0;
NIRVwln=NIRAbs(:,1);
szeNIR=size(NIRVwln);
DifferenceMatrix=100.*ones(size(NIRVwln));
for ii=1:szeNIR
    DifferenceMatrix(ii)=abs(NIRVwln(ii)-NIRwvlnght2);
    if DifferenceMatrix(ii)==0 && ii>1
        NIR_Row2Choose=ii;
        break
    end
end
if NIR_Row2Choose==0
    [minVal,ind]=min(DifferenceMatrix);
    if minVal>10
        error('No wavelength close to the chosen value were found for NIR')
    else
        NIR_Row2Choose=ind;
    end
end
% then cut VIS From here (after reaching to this value ) 
%start of VIS
VIS_Row2Choose1=0;
VISwvln=VISAbs(:,1);
szeVIS=size(VISwvln);
for ii=1:szeVIS
    DifferenceMatrix(ii)=abs(VISwvln(ii)-VISwvlnght1);
    if DifferenceMatrix(ii)==0 && ii>1
        VIS_Row2Choose1=ii;
        break
    end
end
if VIS_Row2Choose1==0
    [minVal,ind]=min(DifferenceMatrix);
    if minVal>10
        error('No wavelength close to the chosen value were found for VIS')
    else
        VIS_Row2Choose1=ind;
    end
end

% then cut VIS From here (before reaching to this value ) 
% end of VIS
VIS_Row2Choose2=0;

for ii=1:szeVIS
    DifferenceMatrix(ii)=abs(VISwvln(ii)-VISNIRwvl);
    if DifferenceMatrix(ii)==0 && ii>1
        VIS_Row2Choose2=ii;
        break
    end
end
if VIS_Row2Choose2==0
    [minVal,ind]=min(DifferenceMatrix);
    if minVal>10
        error('No wavelength close to the chosen value were found for VIS_last')
    else
        VIS_Row2Choose2=ind;
    end
end
NIR_Correct=NIRAbs(NIR_Row2Choose:end,:);
VIS_Correct=VISAbs(VIS_Row2Choose1:VIS_Row2Choose2,:);
AdsorptionCombined=[VIS_Correct;NIR_Correct];
end

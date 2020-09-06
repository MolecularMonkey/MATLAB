if exist('RRRefBU','var')==1
disp('Reading Data from  ..RRRefBU..  cell array');
disp('.....')
else
    error('RRRefBU is not present')
end
ExcitationWaveLength=input('Please input the exciation wavelength you want to choose (nm) \n');
if ExcitationWaveLength<400
    error('Our 2D-scanner cannot excite at this wavelength')
elseif ExcitationWaveLength>1000
    error('Very weak excitation energy!')
end
S=RRRefBU{2,2}{1,2};
FinalSpectra=RRRefBU{2,1}{1,2};
[szeExcitation,szeEmission]=size(S);
ExcWvln=S(:,1);
DifferenceMatrix=zeros(size(ExcWvln));
Row2Choose=0;
for ii=1:szeExcitation
    DifferenceMatrix(ii)=abs(ExcWvln(ii)-ExcitationWaveLength);
    if DifferenceMatrix(ii)==0 && ii>1
        Row2Choose=ii;
        break
    end
end
if Row2Choose==0
    [minVal,ind]=min(DifferenceMatrix);
    if minVal>10
        error('No Excitation wavelength close to the chosen value were found')
    elseif ind==1
        error('2000 End of the world for Computers because Indice cannot be 1')
    else
        fprintf('Nearest Available Excitation to The Chosen Value is %6.1f \n',ExcWvln(ind))
        Row2Choose=ind;
    end
end
clear ind 
WaveLengthSpectrum(1,:)=S(1,2:szeEmission);       %emission wavelengths
WaveLengthSpectrum(2,:)=FinalSpectra(Row2Choose-1,:);     % (Row2Choose-1) because Finalspectra does not have the first row
% plotting the functions
WavenumberSpectrum = wvlspec2wvn_f(WaveLengthSpectrum);
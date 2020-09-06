answer = questdlg('Have you saved your data in a matrix named S?', ...
	'S=Spectra', ...
	'Yes','No','No');
switch answer
    case 'No'
        error('Error. You must input the spectra in a matrix named S (Capital S) S=[excitation emition matrix with the wavelengths]')
    case 'Yes'
        sampleID = input('Enter the name of your Sample ID: \n  ', 's'); 
        str1=[sampleID,'.mat'];
        [szeExcitation,szeEmission]=size(S);
        Emission=S(1,2:szeEmission);
        Excitation=S(2:szeExcitation,1)';
        %Excitation is on Y and Emission is on X axis
        [X,Y] = meshgrid(Emission,Excitation);
        Spectra=S(2:szeExcitation,2:szeEmission);
        figure(4)
        contourf(X,Y,Spectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        figure(5)
        mesh(X,Y,Spectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        figure(6)
        surf(X,Y,Spectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        save(str1,'Excitation','Emission','sampleID','Spectra')
end

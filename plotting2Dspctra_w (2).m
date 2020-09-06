answer = questdlg('Have you saved your data in a matrix named "S"?', ...
	'S=Spectra', ...
	'Yes','No','No');
answer2=questdlg('Have you saved your refrence data in a matrix named "Ref"?', ...
	'Ref=Refrence', ...
	'Yes','No','No');
logggic1=strcmp(answer,'Yes');  logggic2=strcmp(answer2,'Yes');
switch logggic1 && logggic2
    case false
        error('Error. You must save Refrence in Ref the spectra in a matrix named S (Capital S) S=[excitation emition matrix with the wavelengths]')
    case true
        [szeExcitation,szeEmission]=size(S);
        [RefszeExcitation,RefszeEmission]=size(Ref);
        switch szeExcitation==RefszeExcitation && szeEmission==RefszeEmission
            case false
                error('Error. Refrence and Spectra matrix size should match');
            case true
        Emission=S(1,2:szeEmission);
        Excitation=S(2:szeExcitation,1)';
        %Excitation is on Y and Emission is on X axis
        [X,Y] = meshgrid(Emission,Excitation);
        Spectra=S(2:szeExcitation,2:szeEmission);
        Refrence=Ref(2:szeExcitation,2:szeEmission);
        FinalSpectra=Spectra-Refrence;
        sampleID = input('Enter the name of your Sample ID: \n  ', 's'); 
        str1=[sampleID,'.mat'];
        figure(1)
        contourf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        figure(2)
        mesh(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        figure(3)
        surf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        save(str1,'Excitation','Emission','sampleID','Spectra','FinalSpectra','Refrence')
        end
end

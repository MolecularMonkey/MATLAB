        Excitation=PristineData_RRRefBU{2, 3}{2, 1}  ;
        Emission=PristineData_RRRefBU{2, 3}{2, 2};
        [X,Y] = meshgrid(Emission,Excitation);
        FinalSpectra=PristineData_RRRefBU{2, 1}{1, 2}  ;
        figure(1001)
        subplot(1,2,1)
        contourf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        title 'Pristine'
        xlim([850 1400]);ylim([520 800]);colorbar
        figure(1002)
        subplot(1,2,1)
        mesh(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        title 'pristine'
        xlim([850 1400]);ylim([520 800]);
        view([-1,-3,3])
        figure(1003)
        subplot(1,2,1)
        surf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        title 'pristine'
        xlim([850 1400]);ylim([520 800]);
        Excitation=FunctionalizedData_RRRefBU{2, 3}{2, 1}  ;
        Emission=FunctionalizedData_RRRefBU{2, 3}{2, 2};
        [X,Y] = meshgrid(Emission,Excitation);
        FinalSpectra=FunctionalizedData_RRRefBU{2, 1}{1, 2}  ;
        figure(1001)
        subplot(1,2,2)
        contourf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        title 'Treated'
        xlim([850 1400]);ylim([520 800]);colorbar
        figure(1002)
        subplot(1,2,2)
        mesh(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        title 'Treated'
        view([-1,-3,3])
        xlim([850 1400]);ylim([520 800]);
        figure(1003)
        subplot(1,2,2)
        surf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        view([-1,-3,3])
        title 'Treated'
        xlim([850 1400]);ylim([520 800]);
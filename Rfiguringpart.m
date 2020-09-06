        Excitation=RRRefBU{2, 3}{2, 1}  ;
        Emission=RRRefBU{2, 3}{2, 2};
        [X,Y] = meshgrid(Emission,Excitation);
        FinalSpectra=RRRefBU{2, 1}{1, 2}  ;
        figure(11)
        contourf(X,Y,FinalSpectra)
        title( {'2D';eraseBetween(strrep(RRRefBU{2, 4}{2, 1},'\',' '),1,50)} )
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        figure(22)
        mesh(X,Y,FinalSpectra)
        title( {'2D';eraseBetween(strrep(RRRefBU{2, 4}{2, 1},'\',' '),1,50)} )
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        figure(33)
        surf(X,Y,FinalSpectra)
        title( {'2D';eraseBetween(strrep(RRRefBU{2, 4}{2, 1},'\',' '),1,50)} )
        xlabel 'Emission Wavelength (nm)'
        ylabel 'Excitation Wavelength (nm)'
        view([-1,-3,3])
        
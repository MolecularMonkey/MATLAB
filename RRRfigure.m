function RRRfigure(RRRefBU)
        FinalSpectra=RRRefBU{2,1}{1,2};
        Emission=RRRefBU{2,3}{2,2};
        Excitation=RRRefBU{2,3}{2,1};
        [X,Y] = meshgrid(Emission,Excitation);
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
end
        
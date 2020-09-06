% Here we are loading 2d data of functionalized and Pristine Data
%% Pristine Data Loading
queststrng1='Please Load 2D flourescence Data for Pristine/Control Sample'; queststrng2='Control/Pristine'; disp(queststrng1);
questdlg(queststrng1,queststrng2,'Lets GO Control (Pristine)','Lets GO Control (Pristine)'); 
clear RRRefBU
[sfile,spath] = uigetfile({'*.mat','MAT';'*.*','All'},'Load Pristine 2D Spectra');
load([spath,sfile],'RRRefBU')
PristineData_RRRefBU=RRRefBU;
Excitation=RRRefBU{2, 3}{2, 1};
Emission=RRRefBU{2, 3}{2, 2};
FinalSpectra=RRRefBU{2, 1}{1, 2};
[X,Y] = meshgrid(Emission,Excitation);
        % Plotting the 2D figures 
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

%% Functionalized data Loaing
queststrng1='Please Load 2D flourescence Data for Functionalized Sample'; queststrng2='Functionalized'; disp(queststrng1);
questdlg(queststrng1,queststrng2,'Lets GO Functionalized','Lets GO Functionalized');   
clear RRRefBU
[sfile2,spath2] = uigetfile({'*.mat','MAT';'*.*','All'},'Load Treated 2D Spectra');
alkjh=[spath2,sfile2];blkjh=[spath,sfile];
if strcmp(alkjh,blkjh)
    error('Pristine and Treated cannot be the same')
else
    clear blkjh alkjh
end
load([spath2,sfile2],'RRRefBU')
FunctionalizedData_RRRefBU=RRRefBU;
Excitation=RRRefBU{2, 3}{2, 1};
Emission=RRRefBU{2, 3}{2, 2};
FinalSpectra=RRRefBU{2, 1}{1, 2};
[X,Y] = meshgrid(Emission,Excitation);
        % Plotting the 2D figures 
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
        xlim([850 1400]);ylim([520 800]);
        view([-1,-3,3])
        figure(1003)
        subplot(1,2,2)
        surf(X,Y,FinalSpectra)
        xlabel 'Emission Wavelength (nm)'
        view([-1,-3,3])
        title 'Treated'
        xlim([850 1400]);ylim([520 800]);
       % Here we save the pristine and Functionalized 2D files
       %save PristineData_RRRefBU FunctionalizedData_RRRefBU 
       pfn=PristineData_RRRefBU{2, 4}{2, 3};
       ffn=FunctionalizedData_RRRefBU{2, 4}{2, 3};
       filepath=FunctionalizedData_RRRefBU{2, 4}{2, 2}; 
       fileName=[eraseBetween(pfn,strlength(pfn)-2,strlength(pfn)),eraseBetween(ffn,strlength(ffn)-3,strlength(ffn))];
       save([filepath,fileName,'.mat'],'FunctionalizedData_RRRefBU','PristineData_RRRefBU')
       disp('MAT file data of functionalized and pristine 2D saved');
       disp(['Data saved to: ',filepath,fileName]);
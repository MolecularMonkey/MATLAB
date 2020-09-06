definput2 = {'650','740','570'};
prompt = {'Enter the Excitation Wavelength (nm) of your MAIN species   Excitation1 (nm)   -- MAIN --','Enter the Excitation Wavelength (nm) of the INTERFERENCE   Excitation2 (nm)','Enter the Excitation Wavelength of the other INTERFERENCE   Excitation3 (nm)'};
dlgtitle = 'Excitations?';
dims = [1 60];
answer = inputdlg(prompt,dlgtitle,dims,definput2);


subplot(3,2,1)
subplot(3,2,3)
subplot(3,2,5)
subplot(2,2,2)
subplot(2,2,4)



%this program gives the values of 2 wavelength and calculate the difference
%between them in cm-1
SampleID=input('sample ID \n','s');
lamb1=input('please enter the first wavelength \n (nm) \n');
lamb2=input('please enter the shifted wavelength \n (nm) \n');
Lamb1Cm=lamb1*1e-7;
Lamb2Cm=lamb2*1e-7;
OpticFreq1=1/Lamb1Cm;
OpticFreq2=1/Lamb2Cm;
Shift=OpticFreq2-OpticFreq1;
diff=lamb2-lamb1;
disp('   ------------   ')
disp(SampleID)
if diff>0
    fprintf('red shifted \n OpticalFrequency Shift %7.3f cm-1 \n Wavelength Shift %7.3f nm \n',Shift,diff); 
elseif diff<0
    fprintf('blue shifted \n OpticalFrequency Shift %7.3f cm\^-1 \n Wavelength Shift %7.3f nm \n',Shift,diff); 
else
    disp('no shifts');
end
disp('   _______________   ')

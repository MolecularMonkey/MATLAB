function TwoD2Multiple1D(RRRefBU,Excitation1,Increment,Excitation2)
%TWOD2MULTIPLE1D Input is a 2D Flourescence spectrum and Output is Multiple 1D Spectra
%   Detailed explanation goes here
start=RRRefBU{2,2}{1,2}(2,1);
final=RRRefBU{2,2}{1,2}(end,1);
Resolution=RRRefBU{2,2}{1,2}(10,1)-RRRefBU{2,2}{1,2}(11,1);  % difference between 10th and 11th as the resolution of our 2d scan 
if Excitation1<start-1 || Excitation2>final+1
     error('Excitation range is not compatible with our 2D scanner');
elseif Increment<Resolution
     fprintf('The resolution of our 2D scan is %4.2f nm \n ',Resolution)
     error('Increment is to small')
end
%Check to see if the folder already exist or not 
% If Not create them promptly
% If Yes Change the name
MatFileName=eraseBetween(MatFileName,length(MatFileName)-3,length(MatFileName));
 loopCounter=1;
while logical(exist([MatFilePath,'\',MatFileName],'dir'))
            if loopCounter>=10
                disp('too many files with the same name')
                error('Error in saving file name')
            end
            if loopCounter==1
                MatFileName=[MatFileName,num2str(round(loopCounter))];
            else
                MatFileName=eraseBetween(MatFileName,length(MatFileName),length(MatFileName));
                MatFileName=[MatFileName,num2str(round(loopCounter))];
            end
            
            loopCounter=loopCounter+1;
end
stringg=[MatFilePath,MatFileName];
eval(['mkdir(''',stringg,''');'])
% Slicing 2D Finally
for ff=Excitation1:Increment:Excitation2
    str1=['WaveLengthSpectrum_',num2str(ff)];
    str2=['WavenumberSpectrum_',num2str(ff)];
    strTot=['[',str1,',',str2,',ChosenExcWvln]=slicing2Dexc(RRRefBU,ff);'];
    eval(strTot);
    sstr=[MatFileName,'__',num2str(ChosenExcWvln)];
    ffid=fopen([MatFilePath,'\',MatFileName,'\',sstr,'.txt'],'wt');
    sssstr=['fprintf(ffid,','''%8.6E\t%8.6E\n'',',str1,');'];
    eval(sssstr)
    fclose(ffid);
end
end



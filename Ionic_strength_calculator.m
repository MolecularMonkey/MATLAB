IS_Buf=input('Ionic strength of your Buffer? \n in Molar \n') ;
Desired_CNT_IS=0.075;   %250*0.3/1000 = 0.075 (0.3=[NaCL]) 
NaClMolar=0.3;
CNT1stIS=(250/1000)*IS_Buf;
NaClIS=Desired_CNT_IS-CNT1stIS;
if NaClIS<0
   error('Initial Ionic Strength is higer than the Desired Ionic Strength \n');
end
V_NaCL=NaClIS*1000/NaClMolar; % Micro Liter
if V_NaCL<1
    disp('I doubt you can add less than 1 microliter!! \n');
elseif V_NaCL>250
    error('Concentration of NaCL Solution should be greater than 300uM \n')
end
fprintf('Add %6.4f microLiter of 0.3M NaCl \n and %6.4f microLiter of DI Water \n',V_NaCL,250-V_NaCL);

%Temperature Generation For Simulated Annealing_Simulated Annealing
DRasieT=0.1;        % 10% of time from T-start to T-high 
DHighT=0.2+0.1;     % 20% of the time in T high
DCoolT=0.65+0.2+0.1; % 65% of the time: cool down phase 
% thus 5% stays in the cooled temperature
% Maximum Temperature Slope Should be 20K/1ns in heating Step
% Maximum Temperature Slope Should be 5K/1ns in cooling Step
%% System Information
% T start
T_s=298; % K = 25 deg C
T_H=298+40;% K  = 65 deg C
%Simulation Time
Time=30*1000; %ns
timed=[0,DRasieT*Time,DHighT*Time,DCoolT*Time,Time];
Temped=[T_s,T_H,T_H,T_s,T_s];
%% writing Part
% Assuming Three Temp Groups: DNA Water_and_ions CNT
% Assuming CNT is freezed 

SATEXT=[pwd,'\SA.txt'];
fid1=fopen(SATEXT,'w');
%-----
fprintf(fid1,'annealing         = single single single  \n');
%-----
fprintf(fid1,'annealing-npoints = 5 5 5 \n');
%-----
fprintf(fid1,'annealing-time    = %5.1f %5.1f %5.1f %5.1f %5.1f ',timed); % DNA
fprintf(fid1,' %5.1f %5.1f %5.1f %5.1f %5.1f ',timed); % Water & Ions
fprintf(fid1,' %5.1f %5.1f %5.1f %5.1f %5.1f \n',timed);  %  CNT   
%-----
fprintf(fid1,'annealing-temp    = %5.1f %5.1f %5.1f %5.1f %5.1f ',Temped); % DNA
fprintf(fid1,' %5.1f %5.1f %5.1f %5.1f %5.1f ',Temped); % Water & Ions
% one of the two below lines should be kept (Comment out the other)
fprintf(fid1,' %5.1f %5.1f %5.1f %5.1f %5.1f \n',zeros(1,5)); % for Freezed CNT  
%5.1fprintf(fid1,' %5.1f %5.1f %5.1f %5.1f %5.1f \n',Temped);  % for restrained CNT   

%------
fclose(fid1);
plot(timed,Temped-273);
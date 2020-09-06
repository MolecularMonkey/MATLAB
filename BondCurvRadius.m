%% this program gets the n,m and returns minimum bond curvature
%it also returns radius, chiral angle and maximum Bond Curvature
disp('n,m of nanotube')
nn=input('Enter SWCNT n: ');
mm=input('Enter SWCNT m: ');
SWCNTS_Radius=(sqrt(3)*0.1421*sqrt(nn^2+mm^2+nn*mm))/(2*pi);
alpha1=180*atan((sqrt(3)*mm)/(2*nn+mm))/pi;
alpha2=60+alpha1;
alpha3=60-alpha1;
Bond_Curvature1=sin(alpha1*pi/180)^2/SWCNTS_Radius;
Bond_Curvature2=sin(alpha2*pi/180)^2/SWCNTS_Radius;
Bond_Curvature3=sin(alpha3*pi/180)^2/SWCNTS_Radius;
BCR1=Bond_Curvature1^-1; %Bond Curvature Radius
BCR2=Bond_Curvature2^-1;
BCR3=Bond_Curvature3^-1;
radius_string=['SWCNT Radius is ',num2str(SWCNTS_Radius),' nm'];
disp(radius_string)
ChrlAngle_string=['SWCNT Chiral angle is ',num2str(alpha1),' deg'];
disp(ChrlAngle_string)
fprintf('minimum bond curvature radius is %7.4f nm \n',min([BCR1,BCR2,BCR3]));
fprintf('maximum bond curvature is %7.4f nm-1 \n',max([Bond_Curvature1,Bond_Curvature2,Bond_Curvature3]));
disp('------------');
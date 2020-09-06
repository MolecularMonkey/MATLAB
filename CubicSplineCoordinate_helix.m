r=input('enter the radius of the helix \n in Angstrom \n');
p1=input('Enter the pitch of the helix \n in Angstrom \n');
p=p1/(2*pi);
%sz=round(input('How many points of cubic spline coordinates \n  \n')); 
sz=9;
t=0:1:sz-1;
degree_per_point=360/7; %  each point is set to rotate 5 degrees
tt=t.*degree_per_point.*pi./180;
x=r.*cos(tt); 
y=r.*sin(tt);
z=p.*tt;
[FileName,PathName]=uiputfile({'*.txt'},'Save Final Data As');
fid=fopen([PathName,FileName],'w');
for iii=1:sz
    strrr=['P',num2str(iii),'=[x(',num2str(iii),'),y(',num2str(iii),'),z(',num2str(iii),')]'];
    eval(strrr);
    eval(['dt=[P',num2str(iii),'];']);
    fprintf(fid,'{');
    fprintf(fid,' %3.1f',dt);
    fprintf(fid,'} ');
end
fprintf(fid,'\n \n Radius is %6.3f Angstrom and Pitch is %6.3f Angstrom \n',r,p1);
fprintf(fid,'\n Degree per point is %6.3f degrees \n',degree_per_point);
fclose(fid);
plot3(x,y,z)

x=[0.5
    0.333333333
    0.25
    0.2
    0.166666667
    0.05];

PiBondLength=[1.33487
1.33853
1.34082
1.34203
1.34291
1.3474];
PiRMSD=[0
0.005196152
0.005658033
0.005681628
0.00551428
2.43238E-16];
figure(1)
SigmaBondLength=[1.45069
1.44828
1.447066667
1.44612
1.44562
1.44358];
SigmaRMSD=[0
0
0.001997632
0.001859068
0.001925812
0];
errorbar(x,SigmaBondLength,SigmaRMSD,'o','MarkerSize',15,...
    'MarkerEdgeColor','blue','MarkerFaceColor','red','CapSize',18)
hold on
errorbar(x,PiBondLength,PiRMSD,'o','MarkerSize',15,...
    'MarkerEdgeColor','red','MarkerFaceColor','blue','CapSize',18)
legend('\sigma Bond','\pi bond','FontSize',18)
title('Average Bond Length and RMSD for different polymer chain length')
xlabel('1/(No. of monomers)','Interpreter','latex')
ylabel('Bond length (\AA)','Interpreter','latex')
xlim([0 0.55])
ylim([1.33 1.465])
hold off
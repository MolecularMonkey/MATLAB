%Example script for PCA analysis 

%Data matrix. Rows are samples, columns are variables. In this example,
%there are three samples and 5 variables.

X = [9 32 10 1 21; 18 20 22 4 12; 24 12 30 6 6]; 
%semicolon suppresses output. If you wnt to show output, remove the semicolon

%Perform mean centering. Center each variable around a mean value.
Xcenter = X - mean(X); 

%plot X and Xcenter as bar graphs. For the X-coordinates, I chose arbitrary
%m/z values. In a real SIMS data set, each m/z would correspond to a
%different ion measured
figure(1)
bar([1 8 24 65 92],X')% The prime is used to invert X and plot each column as a separate bar 
legend('sample 1', 'sample 2', 'sample 3')
figure(2)
bar([1 8 24 65 92],Xcenter')
legend('sample 1', 'sample 2', 'sample 3')

%Find Z matrix. This transforms the n X p matrix into a square p X p matrix. 
%Note that a lot of the information in Z is redundant. The determinant of Z is 0.  
Z = Xcenter'*Xcenter;

%Find the eigenvalues and eigenvectors of Z
[V,D] = eig(Z);
%V will contain the eigenvectors of Z and D the eigenvalues along the matrix diagonal. 
%The eigenvectors are the principal components, and the eigenvalues tell us
%which eigenvectors are most important. The eigenvector with the largest
%eigenvalue is the most important. 

lambda = diag(D)

%In this example, the 5th eigenvalue is 646, all others are zero. Only one
%eigenvector is needed to represent all three samples. 

Q = V(:,5) %select the 5th eigenvector as your principal component

%Calculate the scores matrix. This gives the weights of the principal component needed to reproduce the data 
Tfull = Xcenter*Q; 

%Check how well the scores and loadings can reproduce the data
Xcheck = Tfull*Q'

%Plot scores as bar plot or line plot
bar(Tfull)
plot(Tfull,'*-')
%Note that Xcheck is equivalent to Xcenter

%Compare this result with pca(X):
[COEFF, SCORE, LATENT] = pca(X)

%biplot allows you to visualize the scores and the data
biplot(COEFF(:,1:2),'scores',SCORE(:,1:2),'varlabels',{'v_1','v_2','v_3'});


%Try another example: 
load hald %this loads example variables in Matlab

ingredients %This displays the n x p matrix for analysis 

ingredients_center = ingredients - mean(ingredients) %mean center the matrix 

Zingredients = ingredients_center'*ingredients_center %create your Z matrix 

[V,D]=eig(Zingredients) %Find the eigenvectors and eigenvalues. 

%Caculate the scores matrix 
Tfullingredients = ingredients_center*V

%Check that your calculated values match 
ingredients_centercheck = Tfullingredients*V'

%Use the matlab function 
[coeff,score,latent] = pca(ingredients);

%plot the results 
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3','v_4'});

%Analysis of Polymer Samples - Import Data using Toolbox
bar(MassNegative,Negativeions)
[COEFF, SCORE, LATENT] = pca(Positiveions'); %The positive ion data has 52 variables and 55 samples  
[COEFF, SCORE, LATENT] = pca(Negativeions'); %The negative ion data has 35 variabls and 54 samples 

%Plot results
biplot(COEFF(1:35,[1 2]),'scores',SCORE([1:8 51 52 53],[1 2]));
%This produces a 2D plot for the negative ions. The first entry in COEFF specifies which
%coefficients or scores will be ploted. The second variable are the
%principal components that will be used, in this case the first and second.
%The first entry in SCORES is the samples that will be plotted, and the
%second entry in SCORES should match the second in COEFF 

biplot(COEFF(1:35,[1 2 3]),'scores',SCORE([1:8 20 21 28 51 52 53],[1 2 3]));
%This is a 3-D plot. Here, I plot PEG, PS, and PMMA polymers 
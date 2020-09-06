%This mfile Slices a 2d Spectra from 2 specified wavelengths
Excitation1=540;
Excitation2=800;
Increment=5;
[MatFileName,MatFilePath] = uigetfile('*.mat');
load([MatFilePath,MatFileName],'-mat')
%eval(['cd ',MatFilePath]);
TwoD2Multiple1D_V1(RRRefBU,Excitation1,Increment,Excitation2,MatFilePath,MatFileName)
%cd C:\Users\nima\Documents\MATLAB
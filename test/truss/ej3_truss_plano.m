%% Test elemento trust en plano bidimensional
% tres barras conectadas en un mismo plano 
clear, clc, close all

% link truss
nodos=csvread( "ej3_nodos.csv");
sz=size(nodos)
n=sz(1)

conectividades = csvread( "ej3_conectividad.csv")            

restricciones=[1,2,4,3,6,9];           % indice de grados de libertad restrigidos

Fe=zeros(n,3);
Fe(3,2)=500;

[u,Fr,M]= Truss(n,nodos,conectividades,restricciones,Fe);

disp("Fuerzas de reacción")
disp(Fr)


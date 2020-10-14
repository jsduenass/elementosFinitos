%% Test elemento trust en plano bidimensional
% tres barras conectadas en un mismo plano 
clear, clc, close all

% link truss
nodos=csvread( "ej3_nodos.csv");
sz=size(nodos);
n=sz(1);

conectividades = csvread( "ej3_conectividad.csv")            
dof=2;                                          % grados de libertad
restricciones=[3,4,5,6,7,8];                    % indice de grados de libertad restrigidos

Fe=zeros(n,dof);
Fe(1,2)=-18;

[u,Fr,sigma,M]= Truss(n,dof,nodos,conectividades,restricciones,Fe);

disp("Fuerzas de reacción")
disp(Fr)


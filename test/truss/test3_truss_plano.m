%% Test elemento trust en plano bidimensional
% tres barras conectadas en un mismo plano 
clear, clc, close all

% link truss
nodos=csvread( "test3_nodos.csv");
n=size(nodos,1);
dim=size(nodos,2);

conectividades = csvread( "test3_conectividad.csv")            
restricciones=[3,4,5,6,7,8];                    % indice de grados de libertad restrigidos

Fe=zeros(n,dim);
Fe(1,2)=-18;

[u,Fr,sigma,M]= Truss(nodos,conectividades,restricciones,Fe);

disp("Fuerzas de reacción")
disp(Fr)

assert(true)
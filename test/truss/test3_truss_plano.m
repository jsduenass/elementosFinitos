clear clc
%% Test elemento truss unidimensional
nodos=cumsum([0;70;70;50;100;70]);


elementos=[(1:5)',(2:6)'];
r=[40;70;90;60;40]*10^-3;        % radio [m]
A=pi*r.^2;
E=200e6*ones(size(r));          % modulo de elasticidad [Pa]

conectividades=[elementos,A,E];

restricciones=[1];
Fe=zeros(size(nodos));
Fe(5)=-100;                      % fuerza externa [N]          
[u,Fr,sigma,M]= Truss(nodos,conectividades,restricciones,Fe);
assert(true)
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
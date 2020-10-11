clc, clear, close 'all'

%% ejercicio 1 sistema de resortes
n=3;                % numero de nodos 
% conectividad entre nodos [nodosA, nodosB, rigidez]
conectividades = csvread( "conectividad.csv")            
            
nodosR=[1];           % nodos Restrigidos

Fe=zeros(n,1);          % Fuerzas externas
Fe(2)=45;

Fe(3)=30;

[u,Fr,M]=sistema_resorte(n,conectividades,nodosR,Fe);

disp("desplazamientos")
disp(u)

disp("Fuerzas de reacción")
disp(Fr)

disp("Matriz de rigidez")
disp(M)

clear, clc, close 'all'
% function handle


%% ejercicio 1 sistema de resortes
% solución de sistema unidmensional de resortes

n=3;                % numero de nodos 
% conectividad entre nodos [nodosA, nodosB, rigidez]
conectividades = csvread( "conectividad3.csv")            
            
nodosR=[1];           % nodos Restrigidos

Fe=zeros(n,1);          % Fuerzas externas
Fe(2)=45;

Fe(3)=30;

[u,Fr,M]=sistema_resorte(n,conectividades,nodosR,Fe)


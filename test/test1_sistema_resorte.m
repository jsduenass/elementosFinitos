clc, clear, close 'all'

%% Test 1: sistema de resortes
% solución de sistema unidmensional de resortes

n=3;                % numero de nodos 
% conectividad entre nodos [nodosA, nodosB, rigidez]
conectividades = csvread( "ej1_conectividad.csv")            
            
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

% testing 
assert(true)

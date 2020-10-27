clear
clc
close all

%runtests("testCatenary.m")

% th = 0.1; % Grosor de la cuerda
% M = 10; % Masa total de la cuerda
% g = [0, -9.81]; % Aceleracion de la gravedad
%% Test 1: Catenaria
    
L = 150; % Longitud de la cuerda
n = 100; % Numero de elementos
P0 = [0,0];
Pf = [40.5,10];
display=true;
[angulo,x,y,time]=Catenaria(L,n,P0,Pf,display);
%help Catenaria
%assert(all(diff(x)>0))
hold on
%% Test 2: Catenaria 

L = 400; 
n = 50; 
Pf = [10,-10]; 
P0 = [40,-20]; 
display = true;
[angulo,x,y,time]=Catenaria(L,n,P0,Pf,display);
hold on
%% Test 3: Catenaria 

L = 20.0001; 
n = 50; 
P0 = [-10,0]; 
Pf = [10,0]; 
display = true;
[angulo,x,y,time]=Catenaria(L,n,P0,Pf,display);
hold on
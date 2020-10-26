clear
clc
close all

L = 8; % Longitud de la cuerda
n = 100; % Numero de elementos
th = 0.1; % Grosor de la cuerda
m = 10; % Masa total de la cuerda

g = [0, -9.81]; % Aceleracion de la gravedad
P0 = [0,0];
Pf = [4,-2];

lambda = Pf(2)-P0(2);
d = Pf(1)-P0(1);

syms alpha;
a = double(vpasolve(2*sinh(alpha*d/2)==alpha*sqrt(L^2-lambda^2), alpha,10));

u = fsolve(@(u)catenary(u,a,P0,Pf),P0);

t = linspace(P0(1),Pf(1),n);
y=1/a*cosh(a*(t+u(1)))+u(2);

plot(t,y)

function F = catenary(u,a,P0,Pf)
    F(1) = 1/a*cosh(a*(P0(1)+u(1)))+u(2)-P0(2);
    F(2) = 1/a*cosh(a*(Pf(1)+u(1)))+u(2)-Pf(2);
end

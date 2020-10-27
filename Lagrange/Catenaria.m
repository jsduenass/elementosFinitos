clear
clc
close all

L = 12; % Longitud de la cuerda
n = 200; % Numero de elementos
th = 0.1; % Grosor de la cuerda
m = 10; % Masa total de la cuerda
le = L/n;

g = [0, -9.81]; % Aceleracion de la gravedad
P0 = [0,0];
Pf = [3,-2];

lambda = Pf(2)-P0(2);
d = Pf(1)-P0(1);

syms alpha z;
a = double(vpasolve(2*sinh(alpha*d/2)==alpha*sqrt(L^2-lambda^2), alpha,10));

C = fsolve(@(C)catenary(C,a,P0,Pf),P0);

x = [];
y = [];

x(1)=P0(1);
f = @(x)(1/a*cosh(a*(x+C(1)))+C(2));

  tic
for k=2:n+1
    x(k)=double(vpasolve(sqrt((z-x(k-1)).^2+(f(z)-f(x(k-1))).^2)==le,z,1.1*x(k-1)));
    
end
toc
%0.866326

longitud=sqrt(diff(x).^2+diff(f(x)).^2);
y=f(x);
x(end)
y(end)

angulo= atan2(diff(y),diff(x));


%%
subplot(2,1,1)
plot(x,y,".")
hold on
plot(x,y,"--")
hold off
axis equal

subplot(2,1,2)
plot(x(1:end-1),angulo)
axis equal


function F = catenary(C,a,P0,Pf)
    F(1) = 1/a*cosh(a*(P0(1)+C(1)))+C(2)-P0(2);
    F(2) = 1/a*cosh(a*(Pf(1)+C(1)))+C(2)-Pf(2);
end



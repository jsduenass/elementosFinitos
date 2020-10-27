clear
clc
close all

L = 8; % Longitud de la cuerda
n = 60; % Numero de elementos
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

x = linspace(P0(1),Pf(1),n);
y=1/a*cosh(a*(x+u(1)))+u(2);

angulo=atan( sinh(a*(x+u(1)))  );
xb=0;       yb=0;
le=L/(n);

le=sqrt(diff(x).^2+diff(y).^2);

for k=1:n-1 
    
    xc(k)=le(k)/2*cos(angulo(k))+ xb(k) ;
    yc(k)=le(k)/2*sin(angulo(k))+ yb(k);
    
    xb(k+1)=xb(k)+le(k)*cos(angulo(k));
    yb(k+1)=yb(k)+le(k)*sin(angulo(k));
end

plot(x,y,":")
hold on 
plot(xc,yc,".")
plot(xb,yb)

axis equal
%set(gca,'DataAspectRatio',[1 1 1])



function F = catenary(u,a,P0,Pf)
    F(1) = 1/a*cosh(a*(P0(1)+u(1)))+u(2)-P0(2);
    F(2) = 1/a*cosh(a*(Pf(1)+u(1)))+u(2)-Pf(2);
end


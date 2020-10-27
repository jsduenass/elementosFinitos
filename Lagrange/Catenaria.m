clear
clc
close all

L = 3.001; % Longitud de la cuerda
n = 100; % Numero de elementos
th = 0.1; % Grosor de la cuerda
m = 10; % Masa total de la cuerda
le = L/n;

g = [0, -9.81]; % Aceleracion de la gravedad
P0 = [0,0];
Pf = [3,0];

lambda = Pf(2)-P0(2);
d = Pf(1)-P0(1);

syms alpha;
a = double(vpasolve(2*sinh(alpha*d/2)==alpha*sqrt(L^2-lambda^2), alpha,10));

C = fsolve(@(C)catenary(C,a,P0,Pf),P0);

x = [];
y = [];

x(1)=P0(1);
x(2)=P0(1)+le/1000;
y(1) = 1/a*cosh(a*(x(1)+C(1)))+C(2);
y(2) = 1/a*cosh(a*(x(2)+C(1)))+C(2);

angulo = atan2(y(2)-y(1),x(2)-x(1));

for i=2:n+1
    x(i) = x(i-1)+le*cos(angulo(i-1));
    y(i) = 1/a*cosh(a*(x(i)+C(1)))+C(2);
    angulo(i) = atan2(y(i)-y(i-1),x(i)-x(i-1));
end

scatter(x,y)
hold on
plot(x,y,"--")

% angulo = atan2(diff(y),diff(x));
% xb=0;       yb=0;
% 
% le=sqrt(diff(y).^2+diff(x).^2);
% 
% 
% for k=1:n-1
%     xc(k)=le(k)/2*cos(angulo(k))+ xb(k) ;
%     yc(k)=le(k)/2*sin(angulo(k))+ yb(k);
%     
%     xb(k+1)=xb(k)+le(k)*cos(angulo(k));
%     yb(k+1)=yb(k)+le(k)*sin(angulo(k));
% end
% 
% plot(x,y,"--")
% hold on 
% plot(xc,yc,"o")
% plot(xb,yb)
% %plot(x,sinh(a*(x+C(1))))

axis equal

function F = catenary(C,a,P0,Pf)
    F(1) = 1/a*cosh(a*(P0(1)+C(1)))+C(2)-P0(2);
    F(2) = 1/a*cosh(a*(Pf(1)+C(1)))+C(2)-Pf(2);
end



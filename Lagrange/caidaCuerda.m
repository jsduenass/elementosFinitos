clc, clear, close all
%%Caida de una cuerda

%% segmentacion

close all, clear
L=20;
M=1;

n=10;
n=n+2;
le=L/n;
m=M/n;


% curva catenaria
a=4.5;
x= linspace(-6,6,n);

y=a*cosh(x/a);


angulo=atan(diff(y)./diff(x));
xb=0;       yb=0;

for k=1:n-1 
    
    xc(k)=le/2*cos(angulo(k))+ xb(k) ;
    yc(k)=le/2*sin(angulo(k))+ yb(k);
    
    xb(k+1)=xb(k)+le*cos(angulo(k));
    yb(k+1)=yb(k)+le*sin(angulo(k));
end


%plot(x,y)
plot(xb,yb)
axis equal
hold on 
scatter(xc,yc)
hold off


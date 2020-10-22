clc, clear, close all
%% Lagrangiano

%% pendulo simple

tspan=linspace(0,6,500);   % tiempo
dt=tspan(2);
y0=[85*pi/180;0];
le=10;
m=10;
I=10;
g=9.81;

[t,y] = ode45(@(t,y)penduloSimple(t,y,le,m,I,g), tspan, y0);

rc=le/2*[cos(y(:,1)),sin(y(:,1))];
xc=rc(:,1);     yc=rc(:,2);
close all

for k=1:length(t)
    
    plot(xc(1:k),yc(1:k),":")
    hold on
    plot([0,2*xc(k)],[0,2*yc(k)])
    
    ylim([-1.2*le,1.2*le])
    xlim([-le,le])

    %axis equal
    set(gca,'DataAspectRatio',[1 1 1])
    hold off
    pause(dt)
end

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


%% estudio de sistema resorte
tspan=linspace(0,5,100);   % tiempo
dt=tspan(2);
x0=-7;
v0=0;
y0=[x0;v0];                   % [x0;v0]
m=10;                         % masa
k=350;                        % constante de resorte


[t,y] = ode45(@(t,y)eq_movimiento(t,y,k,m), tspan, y0);

plot(t,y)
legend(["pos","velocidad"])

figure()

xmin=min(y(:,1));
xMax=max(y(:,1));

for k=1:length(t)
    x=y(k,1);
    v=y(k,2);
    plot([x,x,x+v/10],[2,3,3])
    rectangle('Position',[x-2 0 4 2],'Curvature',0.2);
    
    xline(xmin,"--r")
    xline(xMax,"--r")
    
    xline(0)
    yline(0)
    
    
    ylim([-5,10])
    
    xlim([1.2*xmin,1.2*xMax])
    
    %axis equal
    set(gca,'DataAspectRatio',[1 1 1])
    pause(dt)
    
end

function dy=eq_movimiento(t,y,k,m)
    M=[0,  1;
      -k/m,0];
    dy=M*y;
end

function dy=penduloSimple(t,y,le,m,I,g)
    phi=y(1);   dphi=y(2);
    
    dy=[           dphi           ;
        -2*le*m*g/(le*m+4*I)*cos(phi)];
end
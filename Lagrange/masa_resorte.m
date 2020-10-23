clc, clear, close all
%% Lagrangiano

%estudio de sistema resorte
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

%% Aire
rho = 1.19;
v1 = [1,1];%Modificar
area_frontal = 1;%Modificar
Cd = 0.82;

Fd = -1/2* rho * norm(v1) * area_frontal * Cd * v1;

%% Gráficas
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

%% Funciones
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
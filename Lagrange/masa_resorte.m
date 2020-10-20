clc, clear, close all
%% Lagrangiano
% estudio de sistema resorte
tspan=linspace(0,20,500);   % tiempo
x0=-3;
v0=5;
y0=[x0;v0];                   % [x0;v0]
m=10;                       % masa
k=3;                        % constante de resorte

[t,y] = ode45(@(t,y)eq_movimiento(t,y,k,m), tspan, y0);

plot(t,y)
legend(["pos","velocidad"])

figure()
dt=t(2);
xmin=min(y(:,1));
xMax=max(y(:,1));

for k=1:length(t)
    x=y(k,1);
    v=y(k,2);
    plot([x,x,x+v],[2,3,3])
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
    M=[0,1;-k/m,0];
    dy=M*y;
end
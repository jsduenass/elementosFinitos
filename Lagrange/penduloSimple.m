clc, clear, close all
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

clc, clear, close all
% pendulo simple
Fps=28;
dt=1/Fps;
tspan=0:dt:6;   % tiempo

y0=[-20*pi/180;0];
le=10;
m=10;
I=10;
g=9.81;

[t,y] = ode45(@(t,y)penduloSimple1(t,y,le,m,g), tspan, y0);

rc=le/2*[cos(y(:,1)),sin(y(:,1))];
xc=rc(:,1);     yc=rc(:,2);
close all

for k=1:length(t)
    
    plot(xc(1:k),yc(1:k),".")
    hold on
    plot([0,2*xc(k)],[0,2*yc(k)],"-ok")
    
    ylim([-1.2*le,0.2*le])
    xlim([-le,le])

    %axis equal
    set(gca,'DataAspectRatio',[1 1 1])
    imgs(k)=getframe(gcf) ;
    hold off
    pause(dt)
end

 %% write video

fileName='media/animation.mp4'
animate(fileName,imgs,Fps)
 


%% functions
function dy=penduloSimple1(t,y,le,m,g)
    phi=y(1);   dphi=y(2);
    
    dy=[           dphi           ;
        -3*g/(2*le)*cos(phi)];
end

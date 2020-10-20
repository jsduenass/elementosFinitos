clc, clear, close all
%% Lagrangiano
% estudio de sistema resorte
tspan=linspace(0,10,100);   % tiempo
y0=[0;1];                   % [x0;v0]
m=10;                       % masa
k=3;                        % constante de resorte

[t,y] = ode45(@(t,y)eq_movimiento(t,y,k,m), tspan, y0);

plot(t,y)
legend(["pos","velocidad"])


function dy=eq_movimiento(t,y,k,m)
    M=[0,1;-k/m,0];
    dy=M*y;
end
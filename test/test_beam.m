%clear, clc

nodos=cumsum([0;70;70;50;100;70]);

r=[40;70;90;60;40];             % [mm]
A=pi.*r.^2;                     % [mm]^2
E=200*10^3*ones(size(r));       % [N/mm^2]
I=1/4*pi*r.^4;                  % [mm^4]


conectividades=[(1:5)', (2:6)',A,E,I];
restricciones=[1;2;11;12];
dof=2;
Fe=zeros(size(nodos,1),dof);
id=[2,3,4,5];
Fe(id,1)=-[1000;1000;1500;1500]     %[N]
Fe


[u,Fr,sigma,K,KP]= Beam(nodos,conectividades,restricciones,Fe);
sum(u)

disp("Fuerza de reacción en el apoyo derecho")
Fa=Fr(1,1)*10^-3;
disp(" "+Fa+" kN")

disp("Momento de reacción en el apoyo derecho")
Ma=Fr(1,2)*10^-3;
disp(" "+Ma+" kN/mm")

disp("traza de la matriz global con N mm x10^-12")

disp(" "+trace(K)*10^-12)

disp("traza de la matriz auxiliar con N mm x10^-12")

disp(" "+trace(KP)*10^-12)

disp("deflección maxima en los nodos en mm multiplicado por 10000")

disp(" "+max(abs(u(:,1)))*10^4+" kN/mm ")



% 2.38 kN

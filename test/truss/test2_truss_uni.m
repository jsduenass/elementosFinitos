clear clc
%% Test elemento truss unidimensional
nodos=cumsum([0;70;70;50;100;70]);


elementos=[(1:5)',(2:6)'];
r=[40;70;90;60;40]*10^-3;        % radio [m]
A=pi*r.^2;
E=200e6*ones(size(r));          % modulo de elasticidad [Pa]

conectividades=[elementos,A,E];

restricciones=[1];
Fe=zeros(size(nodos));
Fe(5)=-100;                      % fuerza externa [N]          
[u,Fr,sigma,M]= Truss(nodos,conectividades,restricciones,Fe);

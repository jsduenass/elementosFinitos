clear, clc, close all
% format shortg

x=12*[0,10,30,40];
y=12*[0,20,20,0];

nodos=[x',y',zeros(4,1)];
A=[15;7.5;15];
E=30*10^6*ones(size(A));
I=[305;125;305];
conectividades=[(1:3)',(2:4)',A,E,I];

%Dirichlet
restricciones=[1,2,3,10,11,12];

% Newman
Fe=zeros(size(nodos));
p=-1200;
L=20;
Fe(2:3,2)=p*L/2;
Fe(2:3,3)=p*L^2/12*[1;-1];     %[Lb*ft]
Fe(2:3,3)=12*Fe(2:3,3)          %[Lb*in]
[u,Fr,K]= Frame(nodos,conectividades,restricciones,Fe);

disp("desplazamiento del segundo nodo")
disp( norm(u(2,1:2))*1000)

disp("Fuerza de reaccion en el primer nodo")
disp(norm(Fr(1,1:2)/1000))

disp("angulo de deflección en el tercer nodo")
disp(u(3,3)*1000)


function [K]= Beam(n,dim,nodos,conectividades,restricciones,Fe)
% modelación de elementos tipo frame para (dim) numero de dimensiones donde:
% n-> numero de nodos
% dim -> numero de dimensiones
% nodos -> matriz de coordenadas de nodos nodos(i,:)=[xi,yi,zi]  
% conetividades -> conetividades(i,:)=[indiceNodoA, indiceNodoB, constante de rigidez k]
% restricciones-> lista de indices de grados de libertad restringidos
% Fe-> fuerzas externas aplicadas Fe(i,:)=[Fxi,Fyi,Fzi]


    
    dof=2;
    K=zeros(dof*n,dof*n);    			% Matriz de rigidez global
    Fe=reshape(Fe',[dim*n,1]);
    
    %---conetividades---   
    NodosA= conectividades(:,1);        % vector nodos de partida de conectividad 
    NodosB= conectividades(:,2);        % vector nodos de llegada de conectividad
    Area= conectividades(:,3);          % vector de area transversal de elemento  
    Elasticidad=conectividades(:,4);   % vector de modulo de elasticidad
    Inercia=conectividades(:,5);        % vector de momento de inercia
    for c=1:length(NodosA)

        i=NodosA(c);    j=NodosB(c);        
        A=Area(c);      E=Elasticidad(c);        I=Inercia(c);
        ri=nodos(i,:)';                    % vector de posición nodo A
        rj=nodos(j,:)';                    % vector de posición nodo B
        Le=norm(rj-ri);              % Le de elemento
        Longitud(c)=Le;
        
        %matriz de rigidez elemental
        ke=E*I/Le^3*[  12,   6*Le,    -12,    6*Le;
                     6*Le,  4*Le^2, -6*Le,  2*Le^2;
                      -12,   -6*Le,    12,    -6*Le;
                     6*Le,  2*Le^2, -6*Le,  4*Le^2];   
        eqA= dof*(i-1)+1:dof*i;             % indices de ecuaciones relacionadas al nodo A

        eqB= dof*(j-1)+1:dof*j;             % indices de ecuaciones relacionadas al nodo B
        

        % adicion a la matriz global
        K([eqA,eqB],[eqA,eqB])=K([eqA,eqB],[eqA,eqB]) + ke;

    end
%  
%      %---Restricciones--- 
%     kP=10^10*max(abs(rigidez));       % Penalización
%     KP=K;
%     for R=restricciones
%         KP(R,R)=KP(R,R)+ kP;    
%         KP(R,:)=KP(R,:)/kP;
%     end
   
    disp("end")
end
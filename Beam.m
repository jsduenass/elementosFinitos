function [u,Fr,sigma,K,KP]= Beam(nodos,conectividades,restricciones,Fe)
% modelación de elementos tipo vigaen una unica dimension donde:
% nodos -> matriz de coordenadas de nodos nodos(i,:)=[xi,yi,zi]  
% conetividades -> conetividades(i,:)=[indiceNodoA, indiceNodoB, constante de rigidez k]
% restricciones-> lista de indices de grados de libertad restringidos
% Fe-> fuerzas externas aplicadas Fe(i,:)=[Fxi,Fyi,Fzi]

    n=size(nodos,1);                      % numero de nodos
    
    dof=2;                              % grados de libertad
    K=zeros(dof*n,dof*n);    			% Matriz de rigidez global
    
    Fe=reshape(Fe',[],1);
    
    %---conetividades---   
    NodosA= conectividades(:,1);        % vector nodos de partida de conectividad 
    NodosB= conectividades(:,2);        % vector nodos de llegada de conectividad
    Area= conectividades(:,3);          % vector de area transversal de elemento  
    Elasticidad=conectividades(:,4);    % vector de modulo de elasticidad
    Inercia=conectividades(:,5);        % vector momento de inercia sección transversal
    for c=1:length(NodosA)

        i=NodosA(c);    j=NodosB(c);        
        A=Area(c);      E=Elasticidad(c);    I=Inercia(c);   
        ri=nodos(i,:)';                    % vector de posición nodo A
        rj=nodos(j,:)';                    % vector de posición nodo B
        Le=norm(rj-ri);                    % Le de elemento
        Longitud(c)=Le;
          
        %matriz de rigidez elemental
        ke=E*I/Le^3*[  12,   6*Le,    -12,    6*Le;
                     6*Le,  4*Le^2, -6*Le,  2*Le^2;
                      -12,   -6*Le,    12,    -6*Le;
                     6*Le,  2*Le^2, -6*Le,  4*Le^2];   
        rigidez(c)=max(ke,[],'All');
        
        eqA= dof*(i-1)+1:dof*i;             % indices de ecuaciones relacionadas al nodo A

        eqB= dof*(j-1)+1:dof*j;             % indices de ecuaciones relacionadas al nodo B
        

        % adicion a la matriz global
        K([eqA,eqB],[eqA,eqB])=K([eqA,eqB],[eqA,eqB]) + ke;

    end
    
    %---Restricciones---
    k_p=10^10*max(abs(rigidez));           % factor de penalización
    KP=K;                                  % matriz de rigidez penalizada
    for j=1:length(restricciones)
        R=restricciones(j);
        KP(R,R)=KP(R,R)+ k_p;    
        KP(R,:)=KP(R,:)/k_p;
    end
    
    %---Deformaciones---
    u=mldivide(KP,Fe);
    
    %-- Fuerzas de reacción
    %Fr=-k_p*u(restricciones); 
    Fr= K*u-Fe; 
    
    %--- esfuerzo normal ---
    eqA=dof*NodosA-(dof-1:-1:0);
    eqB=dof*NodosB-(dof-1:-1:0);
    
    sigma=E.*vecnorm(u(eqA)-u(eqB),2,2)./Le';
    
    u=reshape(u,dof,[])';
   
    Fr=reshape(Fr,dof,[])';
    disp("end")
   
end
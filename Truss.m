function [u,Fr,sigma,K]= Truss(nodos,conectividades,restricciones,Fe)
% modelación de elementos tipo trust en 1, 2 o 3 dimensiones
% nodos -> matriz  de coordenadas.   nodos(i,:)=[xi,yi,zi]  
% conetividades -> matriz de propiedades
% conetividades(i,:)=[NodosA,  NodosB, Area, E,Le]
%                     NodosA -> indice nodos de partida, 
%                     NodosB -> indice nodos de llegada, 
%                         A  ->  Area transversal, 
%                         E  ->  Modulo Elasticidad
%                         Le ->  logitud del elemento
% restricciones-> lista de indices de grados de libertad restringidos
% Fe-> fuerzas externas aplicadas Fe(i,:)=[Fxi,Fyi,Fzi]
    
    [n,dim]=size(nodos);        % numero de nodos, numero de dimensiones por nodo
   
    
    K=zeros(dim*n,dim*n);       % Matriz global de rigidez
    Fe=reshape(Fe',[dim*n,1]);
    
    %---conetividades---   
    NodosA= conectividades(:,1);        % vector nodos de partida de conectividad 
    NodosB= conectividades(:,2);        % vector nodos de llegada de conectividad
    Area= conectividades(:,3);          % vector de area transversal de elemento  
    E=conectividades(:,4);              % vector de modulo de elasticidad
    Le=[];                              % vector de longitud de elemento
    rigidez=[];                         % vector de constantes de rigidez
    
    for c=1:length(NodosA)

        i=NodosA(c);    j=NodosB(c);        

        ri=nodos(i,:)';                    % vector de posición nodo A
        rj=nodos(j,:)';                    % vector de posición nodo B
        Le(c)=norm(rj-ri);                 % Le de elemento
        ke=Area(c)*E(c)/Le(c);             % constante de rigidez del elemento
        rigidez(c)=ke;                       
        
        %visualización 
%         v=[ri,rj];
%         plot3(v(1,:),v(2,:),v(3,:))
%         hold on
%         
        uni=(rj-ri)'./norm(rj-ri);         % vector de cosenos directores  [l,m,n]
        
        L=[uni, zeros(size(uni));zeros(size(uni)),uni];		% matriz de giro

        Ki=L'*ke*[1,-1;-1,1]*L;            % matriz de rigidez en coordenadas globales

        eqA= dim*i-(dim-1:-1:0);           % indices de ecuaciones relacionadas al nodo A
             
        eqB= dim*j-(dim-1:-1:0);           % indices de ecuaciones relacionadas al nodo B

    
        % adicion a la matriz global
        K([eqA,eqB],[eqA,eqB])=K([eqA,eqB],[eqA,eqB]) + Ki;

    end
 
    %---Restricciones--- 
    k_p=10^10*max(abs(rigidez));           % factor de penalización
    KP=K;                                  % matriz de rigidez penalizada
    for R=restricciones
        KP(R,R)=KP(R,R)+ k_p;    
        KP(R,:)=KP(R,:)/k_p;
    end
    
    %---Deformaciones---
    u=mldivide(KP,Fe);
    
    %-- Fuerzas de reacción
    %Fr=-k_p*u(restricciones); 
    Fr= K*u-Fe; 
    
    %--- esfuerzo normal ---
    eqA=dim*NodosA-(dim-1:-1:0);
    eqB=dim*NodosB-(dim-1:-1:0);
    
    sigma=E.*vecnorm(u(eqA)-u(eqB),2,2)./Le';
end
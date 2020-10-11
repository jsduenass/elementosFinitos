function [u,Fr,M]= Truss(n,nodos,conectividades,restricciones,Fe)
% modelación de elementos tipo trust 3 en tres dimensiones 
%(3 dof)degrees of freedom donde:
% n-> numero de nodos
% nodos -> matriz de coordenadas de nodos nodos(i,:)=[xi,yi,zi]  
% conetividades -> conetividades(i,:)=[indiceNodoA, indiceNodoB, constante de rigidez k]
% restriccones-> lista de indices de grados de libertad restringidos
% Fe-> fuerzas externas aplicadas Fe(i,:)=[Fxi,Fyi,Fzi]

    M=zeros(3*n,3*n);    % Matriz de rigidez
    Fe=reshape(Fe',[3*n,1]);
    
    %---conetividades---   
    NodosA= conectividades(:,1);        % vector nodos de partida de conectividad 
    NodosB= conectividades(:,2);        % vector nodos de llegada de conectividad
    rigidez= conectividades(:,3);       % vector de constantes de rigidez k  

    for c=1:length(NodosA)

        i=NodosA(c);    j=NodosB(c);    k=rigidez(c);    

        ri=nodos(i,:)';         % vector de posición nodo A
        rj=nodos(j,:)';         % vector de posición nodo B
        
        %visualización 
        v=[ri,rj];
        plot3(v(1,:),v(2,:),v(3,:))
        hold on
        
        u=(rj-ri)'./norm(rj-ri);	%vector de cosenos directores  [l,m,n]
        
        L=[u, zeros(size(u));zeros(size(u)),u];		% matriz de giro

        K=L'*k*[1,-1;-1,1]*L;       % matriz de rigidez en coordenadas globales

        eqA= 3*i-2:3*i;             % indices de ecuaciones relacionadas al nodo A

        eqB= 3*j-2:3*j;             % indices de ecuaciones relacionadas al nodo B


        % adicion a la matriz global
        M([eqA,eqB],[eqA,eqB])=M([eqA,eqB],[eqA,eqB]) + K;

    end
 
     %---Restricciones--- 
    kP=10^10*max(abs(rigidez));       % Penalización

    for R=restricciones
        M(R,R)=M(R,R)+ kP;    
        M(R,:)=M(R,:)/kP;
    end
    
    u=mldivide(M,Fe);
    
    Fr=kP*u(restricciones); 
end
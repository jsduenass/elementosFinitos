function [K]= Frame(n,dim,nodos,conectividades,restricciones,Fe)
% modelación de elementos tipo frame para (dim) numero de dimensiones donde:
% n-> numero de nodos
% dim -> numero de dimensiones
% nodos -> matriz de coordenadas de nodos nodos(i,:)=[xi,yi,zi]  
% conetividades -> conetividades(i,:)=[indiceNodoA, indiceNodoB, constante de rigidez k]
% restricciones-> lista de indices de grados de libertad restringidos
% Fe-> fuerzas externas aplicadas Fe(i,:)=[Fxi,Fyi,Fzi]


    
    dof=3;
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
        %visualización 
%         v=[ri,rj];
%         plot3(v(1,:),v(2,:),v(3,:))
%         hold on
%         
        uni=(rj-ri)'./norm(rj-ri);              %vector de cosenos directores  [l,m,n]
        
        % transformación a coordenadas globales 
        L=zeros(6);
        L(1:2,1:2)=[uni; -uni(1),uni(2)];
        L(3,3)=1;
        L(4:5,4:5)=[uni; -uni(1),uni(2)];
        L(6,6)=1;
        
        K1 = E*A/Le;         K2 = 12*E*I/Le^3;
        K3 = 6*E*I/Le^2;     K4 = 2*E*I/Le;

        Kbe=[ K1   0     0 -K1   0    0;
               0  K2    K3   0 -K2   K3;
               0  K3  2*K4   0 -K3   K4;
             -K1   0     0  K1   0    0;
               0 -K2   -K3   0  K2  -K3;
               0  K3    K4   0 -K3 2*K4];
        
        Ki=L'*Kbe*L;                 % matriz de rigidez en coordenadas globales

        eqA= dof*(i-1)+1:dof*i;             % indices de ecuaciones relacionadas al nodo A

        eqB= dof*(j-1)+1:dof*j;             % indices de ecuaciones relacionadas al nodo B
        

        % adicion a la matriz global
        K([eqA,eqB],[eqA,eqB])=K([eqA,eqB],[eqA,eqB]) + Ki;

    end
%  
%      %---Restricciones--- 
%     kP=10^10*max(abs(rigidez));       % Penalización
%     KP=K;
%     for R=restricciones
%         KP(R,R)=KP(R,R)+ kP;    
%         KP(R,:)=KP(R,:)/kP;
%     end
%     
%     %---Deformaciones---
%     u=mldivide(KP,Fe);
%     
%     %-- Fuerzas de reacción
%     %Fr=-kP*u(restricciones); 
%     Fr= K*u; 
%     
%     %--- esfuerzo normal ---
%     u_prima=reshape(u,dim,n);
%     
%     for c=1:length(NodosA)
% 
%         i=NodosA(c);    j=NodosB(c);        
% 
%         ri=nodos(i,:)';                    % vector de posición nodo A
%         rj=nodos(j,:)';                    % vector de posición nodo B
%         Le=norm(rj-ri);              % Le de elemento
%         uni=(rj-ri)'./norm(rj-ri);              %vector de cosenos directores  [l,m,n]
%         
%         L=[uni, zeros(size(uni));zeros(size(uni)),uni];		% matriz de giro
% 
%         delta_u=u_prima(:,j)-u_prima(:,i);
%         sigma=E(c)*(delta_u)/Le
%         
%         %visualización 
% %         v=[ri,rj];
% %         plot3(v(1,:),v(2,:),v(3,:))
% %         hold on
% %         
%         uni=(rj-ri)'./norm(rj-ri);              %vector de cosenos directores  [l,m,n]
%         
%         L=[uni, zeros(size(uni));zeros(size(uni)),uni];		% matriz de giro
% 
% 
%     end
%     
    disp("end")
end
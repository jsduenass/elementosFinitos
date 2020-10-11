
function [u,Fr,M]=sistema_resorte(n,conectividades,nodosR,Fe)
    % sistema resorte unidimensional 
    %
    % [u,Fr,M]= sistema_resorte(n,conectivades, nodosR,Fe)
    % es una funcion utilizada para resolver un sistema de resortes estatico
    % dando como resultado las deformaciones [u], fuerzas de reaccion [Fr]
    % y la matriz de rigidez [M]
    %
    % los parametros de entrada son
    % n: numero  de nodos
    % conectividades: conexion entre  nodoA y nodoB atraves de un resorte con cierta rigidez  
    % nodosR: nodos Restringidos
    % Fe: vector de Fuerzas externas sobre los nodos

    M=zeros(n,n);    % Matriz de rigidez

    %---conetividades---   
    NodosA= conectividades(:,1);        % vector nodos de partida de conectividad 
    NodosB= conectividades(:,2);        % vector nodos de llegada de conectividad
    rigidez= conectividades(:,3);       % vector de constantes de rigidez k  

    %---Ecuaciones--- 
    for c=1:length(NodosA)
        i=NodosA(c);    j=NodosB(c);
        k=rigidez(c);

        M(i,i)= M(i,i) + k;         M(i,j)= M(i,j) - k;
        M(j,i)= M(j,i) - k;         M(j,j)= M(j,j) + k;

    end

    %---Restricciones--- 
    kP=10^10*max(abs(rigidez));       % Penalización

    for R=nodosR
        M(R,R)=M(R,R)+ kP;    
        M(R,:)=M(R,:)/kP;
    end

    %---Solución---  
    % deformaciones   M*u=Fe
    u=mldivide(M,Fe);   

    % Reacciones 
    Fr=kP*u(nodosR);          

end

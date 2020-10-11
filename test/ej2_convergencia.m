%% ejercicio 2  prueba de convergencia de solución
% estudio de un perfil con sección de area variable utilizando un numero
% progresivo de elementos finitos con el objetivo verificar la convergencia
% del resultado


% definición del perfil 
E=1;
L=10;   a=5;   b=20;
Area_v=@(x) pi*(a-x*(a-b)/L).^2;  % area variable del perfil 
Area_c=@(x) pi*(a +0*x).^2;      % area constante 

% apreciación de convergencia de la solución 
convergencia(L,E,Area_v)

% apreciación de la presencia de ruido inerente debido al uso de aproximaciones
convergencia(L,E,Area_c)

function conectividad=segmentar(n,nodoIni,L,E,A)
    % proceso de segmentación de la viga definido un numero n de nodos
    % y las propiedades de la viga
    % entrega como resutlado la matriz de conectividades
    conectividad=zeros(n-1,3);
    for c=1:n-1
        x=L*(c-1)/(n-1);
        k=E*A(x)*(n-1)/L;
        conectividad(c,:)=[nodoIni+c,nodoIni+c+1,k];
    end
    
end

function convergencia(L,E,Area)
% iteración de analisis de la viga con un numero progresivo de elementos
    close 'all'
    figure()
  
    for N_nodos=5:5:100
        n=N_nodos;                % numero de nodos
        nodoIni=0;

        conectividades=segmentar(n,nodoIni,L,E,Area);
        nodosR=[1];           % nodos Restrigidos

        Fe=zeros(n,1);          % Fuerzas externas
        Fe(n)=500;

        [u,Fr,M]=sistema_resorte(n,conectividades,nodosR,Fe);

        e=diff(u);

        esfuerzo=E*e*(n-1)/L;

        x=linspace(0,L,n-1);


        subplot(2,1,1)
        plot(x,Area(x))
        title("Area")

        subplot(2,1,2)
        plot(x,esfuerzo)

        title("esfuerzo")

        hold on

        %ylim([0,10])

        pause(1)
    end
end


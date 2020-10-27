function [angulo,x,y,time]=Catenaria(L,n,P0,Pf,display)
    % 
    % Curva catenaria 
    % [angulo,x,y,time]=Catenaria(L,n,P0,Pf,display)
    %
    % Entrega la versión discretizada (con elementos de longitud constante)
    % de la curva formada por una cuerda  en reposo/colgada. 
    % L: longitud de la cuerda
    % n: numero de elementos 
    % P0: [x0,y0] coordenadas de punto anclaje inicial     
    % Pf: [xf,yf] coordenadas de punto anclaje final donde xf>x0
    % display: condicional true -> muestra la curva  false -> no 
    %
    % angulo: angulo respecto a el eje x de cada elemento
    % x: vector de posición x de cada elemento
    % y: vector de posición y de cada elemento
    % time: tiempo de solución vector x cumple 
    %       la restricción de longitud del elemento 
    %
    % Ejemplo de uso
    %[angulo,x,y,time]=Catenaria(150,50,[0,0],[40,-20],true);
    
    le = L/n;               % longitud de elemento 

    lambda = Pf(2)-P0(2);   % distancia vertical entre punto de anclaje
    d = Pf(1)-P0(1);        % distancia horizontal 
    syms alph z
    a = double(vpasolve(2*sinh(alph*d/2)==alph*sqrt(L^2-lambda^2), alph,10));

    C = fsolve(@(C)catenary(C,a,P0,Pf),P0);     %condiciones de borde

    x = [];     y = [];

    x(1)=P0(1);
    % altura de la catenaria en terminos de x
    f = @(x)(1/a*cosh(a*(x+C(1)))+C(2));        

      tic
    for k=2:n+1
        m=atan(sinh(a*(x(k-1)+C(1))));  % pendiente: derivada df/dx
        next_x=x(k-1)+le*cos(m);        % aproximación del proximo x
        
        % soución de proximo x que cumple la restricción longitud del elemento 
        x(k)=double(vpasolve((z-x(k-1)).^2+(f(z)-f(x(k-1))).^2==le^2,z,next_x));

    end
    time=toc;

    longitud=sqrt(diff(x).^2+diff(f(x)).^2);
    
    y=f(x); 

    angulo= atan2(diff(y),diff(x));

    if (display)
        plot(x,y,"o","LineWidth",1.8,"MarkerSize",4)
        hold on
        plot(x,y,"--","LineWidth",1.2)
        grid on
        hold off
        axis equal
    end
% subplot(2,1,2)
% plot(x(1:end-1),angulo)
% axis equal


    
end

function F = catenary(C,a,P0,Pf)
        F(1) = 1/a*cosh(a*(P0(1)+C(1)))+C(2)-P0(2);
        F(2) = 1/a*cosh(a*(Pf(1)+C(1)))+C(2)-Pf(2);
    end
function [angulo,x,y,time]=Catenaria(L,n,P0,Pf,display)

    le = L/n;

    lambda = Pf(2)-P0(2);
    d = Pf(1)-P0(1);
    syms alph z
    a = double(vpasolve(2*sinh(alph*d/2)==alph*sqrt(L^2-lambda^2), alph,10));

    C = fsolve(@(C)catenary(C,a,P0,Pf),P0); %condiciones de borde

    x = [];     y = [];

    x(1)=P0(1);
    f = @(x)(1/a*cosh(a*(x+C(1)))+C(2));

      tic
    for k=2:n+1
        m=atan(sinh(a*(x(k-1)+C(1))));
        next_x=x(k-1)+le*cos(m);
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
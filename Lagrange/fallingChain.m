clear ,clc
close all
% chain system
load initialCondition    % L angulo
L=1;
g=1;

Fps=10;
dt=1/Fps;
tspan=0:dt:5;   % tiempo
n=length(angulo);

y0= [angulo'-pi/2;zeros(n,1)];

[t,states] = ode45(@(t,y)chainSystem(t,y,L,g), tspan, y0);

phi=states(:,1:n);


x= cumsum(L*sin(phi),2);
y= cumsum(L*cos(phi),2);

for k=1:length(x)
    plot([0,x(k,:)],[0,y(k,:)],"-o")
    hold on
    %plot(x(1:k,:),y(1:k,:),"--")
    hold off
    axis equal
    xlim([-10,10])
    ylim([-10,10])
    pause(0.1)
end

function dy=chainSystem(t,y,l,g)
    n=length(y)/2;
    phi=y(1:n);   dphi=y(n+1:2*n);
    phiI=phi;
    phiJ=phiI';

    aij=(2*(n-(1:n)+1))./2.*ones(n);
    aij=tril(aij,-1)+tril(aij,-1)'+  (3.*(n-(1:n))+1)./3.*eye(n);
    
    M1=aij.*sin(phiI-phiJ);
    M2=aij.*cos(phiI-phiJ);        % phi_..

    bi=(2*(n-(1:n)')+1)./2;
    b=g/l*sin(phi).*bi;

    eq_dphi=mldivide(M2,M1*dphi.^2+b);
    dy=[dphi;eq_dphi];

end
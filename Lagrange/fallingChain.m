clear ,clc
close all
% chain system
load initialCondition    % datos:L angulo

g=-9.8;

Fps=10;
dt=1/Fps;
tspan=[0:dt:30];   % tiempo
n=length(angulo);

y0= [pi/2-angulo';zeros(n,1)];      %vector inicial angulo y velocidad

[t,states] = ode23t(@(t,y)chainSystem(t,y,L,g), tspan, y0);
%[t2,states] = MEBDF_DRIVER(tspan,y0,options)


phi=states(:,1:n);
dphi=states(:,n+1:2*n);

x= cumsum(L*sin(phi),2);
y= cumsum(L*cos(phi),2);

for k=1:length(x)
    plot([0,x(k,:)],[0,y(k,:)],"-o")
    hold on
    plot(x(1:k,:),y(1:k,:),":")
    hold off
    axis equal
    xlim(1.5*[min(x,[],"all"),max(x,[],"all")+10])
    ylim([min(y,[],"all"),max(y,[],"all")])
    pause(0.1*dt)
end

function dy=chainSystem(t,y,l,g)
    n=length(y)/2;
    phi=y(1:n);   dphi=y(n+1:2*n);
    phiI=phi;
    phiJ=phiI';

    aij=(2*(n-(1:n)+1))/2.*ones(n);
    aij=tril(aij,-1)+tril(aij,-1)'+  (3.*(n-(1:n))+1)./3.*eye(n);
    
    M1=aij.*sin(phiI-phiJ);
    M2=aij.*cos(phiI-phiJ);        % phi_..

    bi=(2*(n-(1:n)')+1)./2;
    b=g/l*sin(phi).*bi;

    eq_dphi=-mldivide(M2,M1*dphi.^2+b);
    dy=[dphi;eq_dphi];

end
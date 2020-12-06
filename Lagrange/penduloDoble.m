% pendulo doble
g=1;
l=1;

Fps=10;
dt=1/Fps;
tspan=0:dt:20;   % tiempo
y0=[-20*pi/180;0;0;0];

[t,states] = ode45(@(t,y)chainSystem(t,y,l,g), tspan, y0);

phi=states(:,1:2);

x= cumsum(l*cos(phi),2);
y= cumsum(l*sin(phi),2);


for k=1:length(x)
    plot([0,x(k,:)],[0,y(k,:)],"-o")
    hold on
    plot(x(1:k,:),y(1:k,:),"--")
    hold off
    axis equal
    xlim([-3,3])
    ylim([-3,3])
    pause(0.1)
end
    

function dy=chainSystem(t,y,l,g)
    n=2;
    phi=y(1:n);   dphi=y(n+1:2*n);
   
    c12=cos(y(1)-y(2));
    s12=sin(y(1)-y(2));
    
    M2=[    4/3,    1/2*c12 ;
        1/2*c12,      1/3   ];
    
    M1=[      0,    1/2*s12;  
        -1/2*s12,       0   ];
    
    b=g/l*[3/2*cos(y(1));1/2*cos(y(2))];

    eq_dphi=-mldivide(M2,M1*dphi.^2+b);
    dy=[dphi;eq_dphi];

end




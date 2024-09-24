close all
clear all


x0 = [0.022,0.06,1,1,2330];
fun = @(x)italgrip1617(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0];
llindarslb=[0.0053,0.06];
IESlb=[1,1,2330];
%limits superiors variables
%alphasub=[10^-3,10^-3,10^-2];
llindarsub=[0.022,0.065];
IESub=[1,1,2350];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
%nonlcon = @nonlinConstraints;
%options = optimoptions('fmincon', 'Algorithm', 'interior-point', 'Display', 'iter');
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);

%[x,Error] = particleswarm(fun,nvars,lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);
[Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1,pos]=italgrip1617(x(1),x(2),x(3),x(4),x(5));

italgrip_1617(x(1),x(2),x(3),x(4),x(5));

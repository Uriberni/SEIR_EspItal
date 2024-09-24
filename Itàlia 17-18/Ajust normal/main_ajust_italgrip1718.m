close all
clear all


x0 = [0.04,0.9,1,1,3130];
fun = @(x) italgrip1718(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0];
llindarslb=[0.035,0.80];
IESlb=[1,1,2950];
%limits superiors variables
%alphasub=[10^-3,10^-3,10^-2];
llindarsub=[0.045,0.94];
IESub=[10,10,3135];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);
[Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1,pos]=italgrip1718(x(1),x(2),x(3),x(4),x(5));

italgrip_1718(x(1),x(2),x(3),x(4),x(5));

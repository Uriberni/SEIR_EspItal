close all
clear all


x0 = [0.0001,0.00014,0.00017,0.0053,0.4026,1,1,2550];
fun = @(x) italgrip1415(x(1:3),x(4),x(5),x(6),x(7),x(8));

% limits inferiors variables
alphaslb=[0.000101,0.00014,0.000174];
llindarslb=[0.0053,0.37];
IESlb=[1,1,2500];
%limits superiors variables
alphasub=[0.000103,0.000142,0.000176];
llindarsub=[0.0053,0.4026];
IESub=[10,10,2950];

%procés optimització
lb=[alphaslb,llindarslb,IESlb];
ub=[alphasub,llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);

[Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1,pos]=italgrip1415(x(1:3),x(4),x(5),x(6),x(7),x(8));

italgrip_1415(x(1:3),x(4),x(5),x(6),x(7),x(8));
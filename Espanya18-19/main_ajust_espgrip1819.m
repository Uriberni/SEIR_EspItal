close all
clear all


x0 = [0.012,0.09,1,1,1330];
fun = @(x) espgrip1819(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0];
llindarslb=[0.01,0.09];
IESlb=[1,1,750];
%limits superiors variables
%alphasub=[0.00019,0.0004,0.0009];
llindarsub=[0.019,0.09];
IESub=[3,3,1330];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(Error);
disp(x);
[Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1]=espgrip1819(x(1),x(2),x(3),x(4),x(5));
espgrip_1819(x(1),x(2),x(3),x(4),x(5));
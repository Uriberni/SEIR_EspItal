close all
clear all


x0 = [0.005,0.02,1,1,1570];
fun = @(x) espgrip1718(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0]35;
llindarslb=[0.0045,0.018];
IESlb=[1,1,1560];
%limits superiors variables
%alphasub=[10^-3,10^-3,10^-3];
llindarsub=[0.0055,0.025];
IESub=[4,4,1590];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);

[Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1,suma2]=espgrip1718(x(1),x(2),x(3),x(4),x(5));

espgrip_1718(x(1),x(2),x(3),x(4),x(5))


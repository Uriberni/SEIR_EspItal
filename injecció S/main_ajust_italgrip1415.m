
clear all


x0 = [0.005,0.4,1,1,2550];
fun = @(x) italgrip1415(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0];
llindarslb=[0.0015,0.37];
IESlb=[1,1,2500];
%Smeslb=[220,-12];
%limits superiors variables
%alphasub=[10^-3,10^-3,0.0005];
llindarsub=[0.009,0.5];
IESub=[10,10,2950];
%Smesub= [260,-8];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);
[Error,Nous_agru,Inf,c,difnous,Nous_agru2]=italgrip1415(x(1),x(2),x(3),x(4),x(5));


italgrip_1415(x(1),x(2),x(3),x(4),x(5));
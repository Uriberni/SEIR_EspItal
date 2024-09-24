close all
clear all


x0 = [0.0029,0.4,1,1,1300];
fun = @(x) italgrip1516(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0]35;
llindarslb=[0.0015,0.3];
IESlb=[1,1,1300];
%limits superiors variables
%alphasub=[10^-3,10^-3,10^-3];
llindarsub=[0.0029,0.5];
IESub=[Inf,Inf,1400];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);

italgrip_1516(x(1),x(2),x(3),x(4),x(5))
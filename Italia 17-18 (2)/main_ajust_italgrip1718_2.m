close all
clear all


x0 = [0.01,0.6,1,1,3350];
fun = @(x) italgrip1718_2(x(1),x(2),x(3),x(4),x(5));

% limits inferiors variables
%alphaslb=[0,0,0];
llindarslb=[0.008,0.6];
IESlb=[1,1,3350];
%limits superiors variables
%alphasub=[10^-3,10^-3,10^-2];
llindarsub=[0.01,0.7];
IESub=[10,10,3650];

%procés optimització
lb=[llindarslb,IESlb];
ub=[llindarsub,IESub];
[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);

italgrip_1718_2(x(1),x(2),x(3),x(4),x(5));
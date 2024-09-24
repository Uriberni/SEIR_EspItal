close all
clear all


x0 = [0.0001,0.0001,0.0001,0.01,0.14,1,1,1500];
fun = @(x) espgrip1617(x(1:3),x(4),x(5),x(6),x(7),x(8));

% limits inferiors variables
alphaslb=[0,0,0];
llindarslb=[0,0.14];
IESlb=[1,1,1495];
%limits superiors variables
alphasub=[10^-3,10^-3,10^-3];
llindarsub=[0.01,0.14];
IESub=[Inf,Inf,1505];

%procés optimització
lb=[alphaslb,llindarslb,IESlb];
ub=[alphasub,llindarsub,IESub];
A = [1, -1, 0, 0, 0, 0, 0, 0;   % x(1) - x(2) <= 0  %amb aquestes restriccions imposem que les alphes 
     0, 1, -1, 0, 0, 0, 0, 0] ;  % x(2) - x(3) <= 0  estiguin ordenades: alpha1<alpha2<alpha3
  % x(4) - x(5) <= 0  %restringim els llindars a: llindar1<llindar2
b=[0;0];
[x,Error] = fmincon(fun,x0,A,b,[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp('error fins màxim és');disp(Error);
[Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1]=espgrip1617(x(1:3),x(4),x(5),x(6),x(7),x(8));

espgrip_1617(x(1:3),x(4),x(5),x(6),x(7),x(8))

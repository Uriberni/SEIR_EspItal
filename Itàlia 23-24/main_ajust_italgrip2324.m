clear all
close all

x0 = [0.0001,0.0001,0.0001,0.005,0.4,1,1,2550];
fun = @(x) italgrip2324(x(1:3),x(4),x(5),x(6),x(7),x(8));

% limits inferiors variables
alphaslb=[0,0,0];
llindarslb=[0.0015,0.37];
IESlb=[1,1,2500];
%Smeslb=[220,-12];
%limits superiors variables
alphasub=[0.001,0.001,0.004];
llindarsub=[0.009,0.5];
IESub=[10,10,2950];
%Smesub= [260,-8];

%procés optimització
lb=[alphaslb,llindarslb,IESlb];
ub=[alphasub,llindarsub,IESub];
A = [1, -1, 0, 0, 0, 0, 0, 0;   % x(1) - x(2) <= 0  %amb aquestes restriccions imposem que les alphes 
     0, 1, -1, 0, 0, 0, 0, 0];  % x(2) - x(3) <= 0  estiguin ordenades: alpha1<alpha2<alpha3
b=[0;0];
[x,RMSE] = fmincon(fun,x0,A,b,[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp('error fins màxim és');disp(RMSE);
[Error,Nous_agru,Inf,difnous,Nous_agru2,Imax,I1,I2,IMAX,Nous,N]=italgrip2324(x(1:3),x(4),x(5),x(6),x(7),x(8));


italgrip_2324(x(1:3),x(4),x(5),x(6),x(7),x(8));
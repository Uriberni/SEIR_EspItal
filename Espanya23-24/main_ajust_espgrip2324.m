clear all
close all

x0 = [0.0001,0.0001,0.0001,0.005,0.20,1,1,1478];
fun = @(x) espgrip2324(x(1:3),x(4),x(5),x(6),x(7),x(8));

% limits inferiors variables
alphaslb=[0,0,0];
llindarslb=[0.0015,0.18];
IESlb=[1,1,1475];
%Smeslb=[220,-12];
%limits superiors variables
alphasub=[0.001,0.001,0.004];
llindarsub=[0.009,0.25];
IESub=[10,10,1510];
%Smesub= [260,-8];

%procés optimització
lb=[alphaslb,llindarslb,IESlb];
ub=[alphasub,llindarsub,IESub];
A = [1, -1, 0, 0, 0, 0, 0, 0;   % x(1) - x(2) <= 0  %amb aquestes restriccions imposem que les alphes 
     0, 1, -1, 0, 0, 0, 0, 0];  % x(2) - x(3) <= 0  estiguin ordenades: alpha1<alpha2<alpha3
b=[0;0];
[x,Error] = fmincon(fun,x0,A,b,[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp('error fins màxim és');disp(Error);
[Error,Nous_agru,Inf,difnous,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N]=espgrip2324(x(1:3),x(4),x(5),x(6),x(7),x(8));


espgrip_2324(x(1:3),x(4),x(5),x(6),x(7),x(8));

close all
clear all

inj_t0=[70,75,80,85,90,95,100,105,115,125];
inj_q0=zeros(1,10);

x0 = [inj_t0,inj_q0];
fun = @(x) italgrip1415(x(1:10),x(11:20));

% limits inferiors variables
%alphaslb=[0,0,0];
%llindarslb=[0.0015,0.37];
%IESlb=[1,1,2500];
inj_tlb=50*ones(1,10);
inj_qlb=zeros(1,10);

%Smeslb=[220,-12];
%limits superiors variables
%alphasub=[10^-3,10^-3,0.0005];
%llindarsub=[0.009,0.5];
%IESub=[10,10,2950];
inj_tub=300*ones(1,10);
inj_qub=300*ones(1,10);
%Smesub= [260,-8];

%procés optimització
lb=[inj_tlb,inj_qub];
ub=[inj_tub,inj_qub];
options = optimoptions('fmincon','Display','iter','MaxIterations', 1000, 'OptimalityTolerance', 1e-6);
nvars=20;
%[x, fval] = ga(fun, nvars, [], [], [], [], lb, ub, []);
[x,fval] = fmincon(fun,x0,[],[],[],[],lb,ub);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(fval);
[Error,Nous_agru,Inf,difnous,Nous_agru2,peak_day,peak_value]=italgrip1415(x(1:10),x(11:20));
inj_t=x(1:10);
inj_q=x(11:20);

italgrip_1415(x(1:10),x(11:20));
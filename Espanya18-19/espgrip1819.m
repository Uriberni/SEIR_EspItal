function [Error,Nous_agru,Inf,Nous_agru2,Imax,I1,I2,IMAX,Nous_set,N,nError,alpha1]=espgrip1819(llindar1,llindar2,Iini,Eini,Sini)
espanya1819_matriu;
a=[0.03;0.04;0.04;0.041];
Inf=[a;Inf];
%Inf=Inf(3:end);
%N=10^5;
deltat=1;
t0=1;
tfin=length(Inf)*7;
temps=t0:deltat:tfin;

%llindar1=0.0348;   %% avalulem en segona iteració // reajustar per Itàlia
%llindar2=0.1979;   %% avalulem en segona iteració // reajustar per Itàlia
beta=0.25;
gamma=0.14286;
Npassos=length(temps);
Imax=max(Inf);
S=zeros(Npassos,1);
%S0=f*N;
S(1)=Sini;
E=zeros(Npassos,1);
I=zeros(Npassos,1);
R=zeros(Npassos,1);
Nous=zeros(Npassos,1);
alpha1=zeros(Npassos,1);
I(1)=Iini;
E(1)=Eini;
%Total(1)=S(1)+E(1)+I(1)+R(1);
Nous_agru=zeros(length(Inf)*7,1);
for i=2:Npassos
%Alpha1=Alpha(1);
%Alpha2=Alpha(2);
%Alpha3=Alpha(3);
    if Nous_agru(i-1)<[llindar1*Imax]
        alpha=0.00000935299350580203;   
    elseif Nous_agru(i-1)>[llindar1*Imax] && Nous_agru(i-1)<[llindar2*Imax]
        alpha=0.000170752230869022;   
    elseif Nous_agru(i-1)>llindar2*Imax
        alpha=0.000204421108915661;
    end
    alpha1(i)=alpha;
    S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
    E(i)=E(i-1)+(alpha*S(i-1)*I(i-1)-beta*E(i-1))*deltat;
    I(i)=I(i-1)+(beta*E(i-1)-gamma*I(i-1))*deltat;
    R(i)=R(i-1)+(gamma*I(i-1))*deltat;
    Nous(i)=beta*E(i-1);

    %agrupació casos per setmanes

     if i<7
     Nous_agru(i)=sum(Nous(1:i));
     else
     Nous_agru(i)=sum(Nous(i-6:i));              
     end 

end

I1=llindar1*Imax;
I2=llindar2*Imax;
%error  quadràtic mig
[~,pos]=max(Inf);
suma = 0;
Nous_set=zeros(15,1);
for i=1:pos
    Nous_set(i)=Nous_agru(i*7);
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/pos);
Nous_agru2=Nous_agru(7:end);
IMAX=max(Nous_agru2);
N=mean(Inf(1:pos));
nError=Error/N; 
end
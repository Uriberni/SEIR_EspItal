function [Error,Nous_agru,Inf]=italgrip1516(llindar1,llindar2,Iini,Eini,Sini)
italia1516_matriu;
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
Nous_agru=zeros(length(Inf)*7,1);
%Total(1)=S(1)+E(1)+I(1)+R(1);

for i=2:Npassos
%Alpha1=Alpha(1);
%Alpha2=Alpha(2);
%Alpha3=Alpha(3);
    if Nous(i-1)<[llindar1*Imax]
        alpha=0.000187077381711778;   
    elseif Nous(i-1)>[llindar1*Imax] && Nous(i-1)<[llindar2*Imax]
        alpha=0.000272593663099661;   
    elseif Nous(i-1)>llindar2*Imax
        alpha=0.000501293608154266;
    end
    alpha1(i)=alpha;
    S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
    E(i)=E(i-1)+(alpha*S(i-1)*I(i-1)-beta*E(i-1))*deltat;
    I(i)=I(i-1)+(beta*E(i-1)-gamma*I(i-1))*deltat;
    R(i)=R(i-1)+(gamma*I(i-1))*deltat;
    Nous(i)=beta*E(i-1);
  
    %agrupació dels casos nous per setmane

     if i<7
     Nous_agru(i)=sum(Nous(1:i));
     else
     Nous_agru(i)=sum(Nous(i-6:i));              
     end 

end


%error  quadràtic mig
[~,pos]=max(Inf);
suma = 0;
Nous_set=zeros(12,1);
for i=1:pos
    Nous_set(i)=Nous_agru(i*7);
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/pos);
end
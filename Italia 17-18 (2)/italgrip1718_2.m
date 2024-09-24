function [Error,Nous_agru,Inf]=italgrip1718_2(llindar1,llindar2,Iini,Eini,Sini)
italia1718_matriu_2;
%N=10^5;
deltat=1;
tfin=length(Inf)*7;
temps=7:deltat:tfin;
total_setmanes=length(Inf);


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
        alpha=0.0000902452678029312;   
    elseif Nous(i-1)>[llindar1*Imax] && Nous(i-1)<[llindar2*Imax]
        alpha=0.000129485790444009;   
    elseif Nous(i-1)>llindar2*Imax
        alpha=0.00524106828510761;
    end
    alpha1(i)=alpha;
    S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
    E(i)=E(i-1)+(alpha*S(i-1)*I(i-1)-beta*E(i-1))*deltat;
    I(i)=I(i-1)+(beta*E(i-1)-gamma*I(i-1))*deltat;
    R(i)=R(i-1)+(gamma*I(i-1))*deltat;
    Nous(i)=beta*E(i-1);
    %Total(i)=S(i)+E(i)+I(i)+R(i);

%agrupació dels casos nous per setmanes
     if i<7
     Nous_agru(i)=sum(Nous(1:i));
     else
     Nous_agru(i)=sum(Nous(i-6:i));              
     end 

end

Nous_set=zeros(total_setmanes,1);
for k=1:total_setmanes
    Nous_set(k)=Nous_agru(k*7);
end

%error  quadràtic mig fins valor màxim d'INFECTATS
[~,pos]=max(Inf);
Error=[Inf(pos+2)-Nous_set(pos+2)]^2;
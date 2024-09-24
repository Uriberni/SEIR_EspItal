function [Error,Nous_agru,Inf,Nous_agru2,peak_day,a,sinj1,S,Nous_set]=italgrip1617_S(llindar1,llindar2,llindar3,S_inj)
italia1617_matriu;
Inf=ital1617.GRIP105HAB;
a=[1.34;2.56;3.34;3.4;3.5];
%0.5*ones(3,1);
Inf=[a;Inf];
%N=10^5;
deltat=1;
tfin=length(Inf)*7;
temps=1:deltat:tfin;
total_setmanes=length(Inf);


%llindar1=0.0348;   %% avalulem en segona iteració // reajustar per Itàlia
%llindar2=0.1979;   %% avalulem en segona iteració // reajustar per Itàlia
beta=0.25;
gamma=0.14286;
Npassos=length(temps);
Imax=max(Inf);
S=zeros(Npassos,1);
%S0=f*N;
S(1)=2330.00223537169;
E=zeros(Npassos,1);
I=zeros(Npassos,1);
R=zeros(Npassos,1);
Nous=zeros(Npassos,1);
alpha1=zeros(Npassos,1);
sinj1=zeros(Npassos,1);
[~,pos]=max(Inf);
peak_day=7*pos;
I(1)=1;
E(1)=1;
Nous_agru=zeros(length(Inf)*7,1);
%Total(1)=S(1)+E(1)+I(1)+R(1);

for i=2:Npassos
Sinj1=S_inj(1);
Sinj2=S_inj(2);
Sinj3=S_inj(3);
Sinj4=S_inj(4);
    if Nous_agru(i-1)<[0.0141983931737054*Imax]
        alpha=0.000102266042282028;   
    elseif Nous_agru(i-1)>[0.0141983931737054*Imax] && Nous_agru(i-1)<[0.0623369179289880*Imax]
        alpha=0.000141968526274661;   
    elseif Nous_agru(i-1)>0.0623369179289880*Imax
        alpha=0.000175321328302776;
    end
    alpha1(i)=alpha;

sinj=0;
    if i >= peak_day 
        if  i==peak_day
            sinj=Sinj1;
            a=i;
        elseif Nous_agru(i-1) > llindar1*Imax && mod(i,7)==0
            sinj=Sinj1;
        elseif Nous_agru(i-1) < llindar1*Imax && Nous_agru(i-1) > llindar2*Imax && mod(i,7)==0
            sinj=Sinj2;
        elseif Nous_agru(i-1) < llindar2*Imax && Nous_agru(i-1) > llindar3*Imax && mod(i,7)==0
            sinj=Sinj3;
        elseif Nous_agru(i-1) < llindar3*Imax && mod(i,7)==0
            sinj=Sinj4;
        end
        S(i)=S(i-1)+sinj-alpha*S(i-1)*I(i-1)*deltat;
        sinj1(i)=sinj;
    else
        S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
    end

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
I1=llindar1*Imax;
I2=llindar2*Imax;
Nous_agru2=Nous_agru(7:end);
IMAX=max(Nous_agru2);

Nous_set=zeros(total_setmanes,1);
for k=1:total_setmanes
    Nous_set(k)=Nous_agru(k*7);
end

%error  quadràtic mig fins valor màxim d'INFECTATS
suma = 0;
for i=pos:length(Inf)
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/(length(Inf)-pos));

N=mean(Inf(1:pos));
nError=(Error/N)*100; 
end

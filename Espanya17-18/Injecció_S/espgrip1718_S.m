function [Error,Nous_agru,Inf,Nous_agru2,peak_day,a,sinj1,S,Nous_set]=espgrip1718_S(llindar1,llindar2,llindar3,S_inj)
espanya1718_matriu;
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
S(1)=1570.03114863359;
E=zeros(Npassos,1);
I=zeros(Npassos,1);
R=zeros(Npassos,1);
Nous=zeros(Npassos,1);
alpha1=zeros(length(Inf),1);
sinj1=zeros(Npassos,1);
[~,pos]=max(Inf);
peak_day=7*pos;
I(1)=1.55264851827080;
E(1)=1.63211530658512;
Nous_agru=zeros(length(Inf)*7,1);
total_setmanes=length(Inf);
%Total(1)=S(1)+E(1)+I(1)+R(1);

for i=2:Npassos
Sinj1=S_inj(1);
Sinj2=S_inj(2);
Sinj3=S_inj(3);
Sinj4=S_inj(4);
    if Nous_agru(i-1)<[0.00500000000000000*Imax]
        alpha=0.00000935299350580203;   
    elseif Nous_agru(i-1)>[0.00500000000000000*Imax] && Nous_agru(i-1)<[0.0215000000664046*Imax]
        alpha=0.000170752230869022;   
    elseif Nous_agru(i-1)>0.0215000000664046*Imax
        alpha=0.000204421108915661;
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
  
    %agrupació dels casos nous per setmane

     if i<7
     Nous_agru(i)=sum(Nous(1:i));
     else
     Nous_agru(i)=sum(Nous(i-6:i));              
     end 

end
I1=llindar1*Imax;
I2=llindar2*Imax;
Nous_set=zeros(total_setmanes,1);
for k=1:total_setmanes
    Nous_set(k)=Nous_agru(k*7);
end
Nous_agru2=Nous_agru(7:end);
IMAX=max(Nous_agru2);

%Càlcul de RMSE 
suma = 0;
for i=pos:length(Inf)
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/(length(Inf)-pos));



IMAX=max(Nous_agru2);
N=mean(Inf(1:pos));
nError=(Error/N)*100; 

end
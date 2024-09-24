function [Error]=espgrip_2324(Alpha)
espanya;
Inf=esp.productegrip105HabARI;
Inf(1)=[];
%N=10^5;
deltat=1;
t0=1;
tfin=length(Inf)*7;
temps=7:deltat:tfin;
data_ini=datetime(2017,11,19);
total_setmanes=length(Inf);
total_dies=length(Inf)*7;
tt=data_ini+calweeks(0:total_setmanes-1);
ttt=data_ini+caldays(0:total_dies-7);

llindar1=0.0348;   %% avalulem en segona iteració // reajustar per Itàlia
llindar2=0.1979;   %% avalulem en segona iteració // reajustar per Itàlia
beta=0.25;
gamma=0.14286;
Npassos=length(temps);
Imax=max(Inf);
S=zeros(Npassos,1);
%S0=f*N;
S(1)=1562;
E=zeros(Npassos,1);
I=zeros(Npassos,1);
R=zeros(Npassos,1);
Nous=zeros(Npassos,1);
alpha1=zeros(Npassos,1);
I(1)=1;
E(1)=4;
Nous_agru=zeros(length(Inf)*7,1);
%Total(1)=S(1)+E(1)+I(1)+R(1);

for i=2:Npassos
Alpha1=Alpha(1);
Alpha2=Alpha(2);
Alpha3=Alpha(3);
    if I(i-1)<[llindar1*Imax]
        alpha=Alpha1;   
    elseif I(i-1)>[llindar1*Imax] && I(i-1)<[llindar2*Imax]
        alpha=Alpha2;   
    elseif I(i-1)>llindar2*Imax
        alpha=Alpha3;
    end
    alpha1(i)=alpha;
    S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
    E(i)=E(i-1)+(alpha*S(i-1)*I(i-1)-beta*E(i-1))*deltat;
    I(i)=I(i-1)+(beta*E(i-1)-gamma*I(i-1))*deltat;
    R(i)=R(i-1)+(gamma*I(i-1))*deltat;
    Nous(i)=beta*E(i-1);
    %Total(i)=S(i)+E(i)+I(i)+R(i);



%agrupació dels casos nous per setmanes
a=0;
     if i<7
     Nous_agru(i)=sum(Nous(1:i));
     else
     Nous_agru(i)=sum(Nous(i-6:i));              
     end 
 end

%error  quadràtic mig
suma = 0;
Nous_set=zeros(24,1);
for i=1:24
    Nous_set(i)=Nous_agru(i*7);
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/24);

Nous_agru2=Nous_agru(7:end);
%gràfic SEIR
%{
plot(temps,S);
hold on
plot(temps,E);
plot(temps,I);
plot(temps,R);
%plot(temps,Total);
plot(temps,Nous);
plot(temps,Inf);
legend('Susceptibles','Latents','Infectats','Recuperats');
xlabel('Temps (dies)');
ylabel('Casos/10^5 hab');
title('Gràfica SEIR');
hold off
%}
%gràfica dels casos experimentals vs model
figure
temps2=(7:7:171);
plot(tt,Inf,'-or');
hold on
plot(ttt,Nous_agru2,'-ob');
yline( 0.0348*Imax,'--' )
yline( 0.1979*Imax,'--' )
legend('Experimentals','Model')
xlabel('Temps (dies)');
ylabel('Casos/10^5 hab');
title('experimentals vs Model');
hold off
end

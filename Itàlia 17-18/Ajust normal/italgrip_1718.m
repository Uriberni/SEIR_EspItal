function [Error,alpha1]=italgrip_1718(llindar1,llindar2,Iini,Eini,Sini)
italia1718_matriu;
Inf=ital1718.GRIP105HAB;
a=0.5*ones(1,1);
Inf=[a;Inf];

%N=10^5;
deltat=1;
t0=1;
tfin=length(Inf)*7;
temps=1:deltat:tfin;
data_ini=datetime(2017,11,12);
total_setmanes=length(Inf);
total_dies=length(Inf)*7;
tt=data_ini+calweeks(0:total_setmanes-1);
ttt=data_ini+caldays(0:total_dies-7);

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
    if Nous_agru(i-1)<[llindar1*Imax]
        alpha=0.000102266042282028;   
    elseif Nous_agru(i-1)>[llindar1*Imax] && Nous_agru(i-1)<[llindar2*Imax]
        alpha=0.000141968526274661;   
    elseif Nous_agru(i-1)>llindar2*Imax
        alpha=0.000175321328302776;
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
suma = 0;
for i=1:pos
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/pos);

Nous_agru2=Nous_agru(7:end);


%grafica dels casos experimentals vs model
figure
%temps2=(1:7:7*length(Inf));
%plot(temps2,Inf,'-or');
plot(tt,Inf,'-or');
hold on
plot(ttt,Nous_agru2,'-b');
ax = gca;
ax.XTick = tt;
ax.XTickLabelRotation = 45;
ax.XAxis.TickLabelFormat = 'dd-MMM-yyyy';
yline( llindar1*Imax,'--' )
yline( llindar2*Imax,'--' )
legend('Experimentals','Model')
xlabel('Temps (setmanes)');
ylabel('Casos/10^5 hab');
title('experimentals vs Model Itàlia(17-18)');
hold off
disp(Error)
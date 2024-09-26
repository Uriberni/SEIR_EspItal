function [Error,Nous_agru,Inf,difnous,Nous_agru2,peak_day,a,sinj1,S]=italgrip_1415(llindar1,llindar2,llindar3,S_inj)
italia1415_matriu;

Inf=ital1415.GRIP105HAB;
dif2dies=zeros(length(Inf),1);
for z=1:length(Inf)
    if [z+2]<28
    dif2dies(z)=Inf(z+2)-Inf(z);
    end
end
for n=1:z
    if dif2dies(n)>3
        break
    end
end
Inf=Inf(n:end);

%N=10^5;
deltat=1;
t0=1;
tfin=length(Inf)*7;
temps=1:deltat:tfin;
data_ini=datetime(2014,11,16);
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
S(1)=2501.13409703652;
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
difnous=zeros(Npassos,1);
threshold_day=40;
a=1;
b=1;
for i=2:Npassos
Sinj1=S_inj(1);
Sinj2=S_inj(2);
Sinj3=S_inj(3);
Sinj4=S_inj(4);
    if Nous_agru(i-1)<[0.00523280211295327*Imax]
        alpha=0.000102266042282028;
    elseif Nous_agru(i-1)>[0.00523280211295327*Imax] && Nous_agru(i-1)<[0.454333572583868*Imax]
        alpha=0.000141968526274661;   
    elseif Nous_agru(i-1)>0.454333572583868*Imax
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
        
    %S(i)=S(i-1)+S_inj-alpha*S(i-1)*I(i-1)*deltat;
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
difnous(i)=Nous_agru(i)-Nous_agru(i-1);
end

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

Nous_agru2=Nous_agru(7:end);

S1=S(7:end);
%grafica dels casos experimentals vs model
figure
%temps2=(1:7:7*length(Inf));
%plot(temps2,Inf,'-or');
plot(tt,Inf,'-or');
hold on
grid on
plot(ttt,Nous_agru2,'-b');
ylabel('Casos/10^5 hab');
yyaxis right 
plot(ttt,S1,'-g');
ax = gca;
ax.XTick = tt;
ax.XTickLabelRotation = 45;
ax.XAxis.TickLabelFormat = 'dd-MMM-yyyy';
ax.YAxis(2).Color = 'g';
%yline( llindar1*Imax,'--' )
%yline( llindar2*Imax,'--' )
legend('Experimentals','Model','Susceptibles');
xlabel('Temps (setmanes)');
ylabel('Susceptibles/10^5 hab','Color','green');
title('experimentals vs Model Itàlia(14-15)');
hold off
yyaxis left
yline(llindar1*Imax, '--', 'HandleVisibility', 'off');
yline(llindar2*Imax, '--', 'HandleVisibility', 'off');
yline(llindar3*Imax, '--', 'HandleVisibility', 'off');
disp(Error)
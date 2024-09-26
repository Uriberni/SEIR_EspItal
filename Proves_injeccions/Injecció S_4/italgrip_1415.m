function []=italgrip_1415(S_inj)
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
temps=7:deltat:tfin;
data_ini=datetime(2017,11,19);
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
I(1)=1;
E(1)=1;
Nous_agru=zeros(length(Inf)*7,1);
%Total(1)=S(1)+E(1)+I(1)+R(1);
difnous=zeros(Npassos,1);
threshold_day=40;
peak_day=0;
a=1;
b=1;
for i=2:Npassos
%Alpha1=Alpha(1);
%Alpha2=Alpha(2);
%Alpha3=Alpha(3);
    if Nous_agru(i-1)<[0.00523280211295327*Imax]
        alpha=0.000102266042282028;
    elseif Nous_agru(i-1)>[0.00523280211295327*Imax] && Nous_agru(i-1)<[0.454333572583868*Imax]
        alpha=0.000141968526274661;   
    elseif Nous_agru(i-1)>0.454333572583868*Imax
        alpha=0.000175321328302776;
    end
    alpha1(i)=alpha;
      
    if i >= peak_day && b==0
        if mod(i,7)==0
            S(i)=S(i-1)+S_inj-alpha*S(i-1)*I(i-1)*deltat;
        else
            S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
        end 
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

    if i >= threshold_day && Nous_agru(i-1) > Nous_agru(i) && b==1
         peak_value = Nous_agru(i-1);
         peak_day = i-1;  % Día del pico
         b=0;
    end
end

Nous_set=zeros(total_setmanes,1);
for k=1:total_setmanes
    Nous_set(k)=Nous_agru(k*7);
end

%error  quadràtic mig fins valor màxim d'INFECTATS
[~,pos]=max(Inf);
suma = 0;
for i=1:total_setmanes
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/total_setmanes);

Nous_agru2=Nous_agru(7:end);


%grafica dels casos experimentals vs model
figure
%temps2=(1:7:7*length(Inf));
%plot(temps2,Inf,'-or');
plot(tt,Inf,'-or');
hold on
plot(ttt,Nous_agru2,'-b');
yyaxis right
plot(ttt,S);
ax = gca;
ax.XTick = tt;
ax.XTickLabelRotation = 45;
ax.XAxis.TickLabelFormat = 'dd-MMM-yyyy';
yline( 0.00523280211295327*Imax,'--' )
yline( 0.454333572583868*Imax,'--' )
legend('Experimentals','Model')
xlabel('Temps (dies)');
ylabel('Casos/10^5 hab');
title('experimentals vs Model Itàlia(14-15)');
hold off
disp(Error)
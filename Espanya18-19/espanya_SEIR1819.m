function []=espanya_SEIR1819(Inf,Nous_agru)
espanya1819_matriu;
Inf=esp1819.productegrip105HabILI;
Inf(1)=[];
%N=10^5;
deltat=1;
t0=1;
tfin=length(Inf)*7;
temps=t0:deltat:tfin;

llindar1=145906.225417144;   %% avalulem en segona iteració // reajustar per Itàlia 0.0348
llindar2=53098.9768017571;   %% avalulem en segona iteració // reajustar per Itàlia 0.1979
beta=0.25;
gamma=0.14286;
Npassos=length(temps);
Imax=max(Inf);
S=zeros(Npassos,1);
%S0=f*N;
S(1)=861.558368757782;
E=zeros(Npassos,1);
I=zeros(Npassos,1);
R=zeros(Npassos,1);
Nous=zeros(Npassos,1);
alpha1=zeros(Npassos,1);
I(1)=0.00318196391271291;
E(1)=0.00400059435828042;
%Total(1)=S(1)+E(1)+I(1)+R(1);
ztot=zeros(168,1);
for i=2:Npassos
    if I(i-1)<[llindar1*Imax]
        alpha=0.000393841869280294;   
    elseif I(i-1)>[llindar1*Imax] && I(i-1)<[llindar2*Imax]
        alpha=177688.452943750;   
    elseif I(i-1)>llindar2*Imax
        alpha=177498.490880930;
    end
    alpha1(i)=alpha;
    S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
    E(i)=E(i-1)+(alpha*S(i-1)*I(i-1)-beta*E(i-1))*deltat;
    I(i)=I(i-1)+(beta*E(i-1)-gamma*I(i-1))*deltat;
    R(i)=R(i-1)+(gamma*I(i-1))*deltat;
    Nous(i)=beta*E(i-1);
    %Total(i)=S(i)+E(i)+I(i)+R(i);

end

%agrupació dels casos nous per setmanes
Nous_agru=zeros(length(Inf)*7,1);
a=0;
 for j=1:Npassos
     a=a+1;
     if j<7
         Nous_agru(a)=Nous(j);
     else
    Nous_agru(a)=Nous(j)+Nous(j-1)+Nous(j-2)+Nous(j-3)+Nous(j-4)+Nous(j-5)+Nous(j-6);
     end
 end

%error  quadràtic mig
suma = 0;
Nous_set=zeros(length(Inf),1);
for i=1:length(Inf)
    Nous_set(i)=Nous_agru(i*7);
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/length(Inf));


%grafic SEIR
figure
plot(temps,S); 
hold on 
plot(temps,E); 
plot(temps,I); 
plot(temps,R);
%plot(temps,Total); 
plot(temps,Nous_agru); 
%plot(temps,Inf);
legend('Susceptibles','Latents','Infectats','Recuperats','Nous'); 
xlabel('Temps(dies)'); 
ylabel('Casos/10^5 hab'); 
title('Gràfica SEIR'); 
hold off

%grafica dels casos experimentals vs model
figure
temps2=(7:7:7*length(Inf));
plot(temps2,Inf,'-or');
hold on
plot(temps,Nous_agru,'-b');
%yline( llindar1*Imax,'--' )
%yline( llindar2*Imax,'--' )
legend('Experimentals','Model')
xlabel('Temps (dies)');
ylabel('Casos/10^5 hab');
title('experimentals vs Model');
hold off
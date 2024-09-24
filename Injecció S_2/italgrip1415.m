function [Error,Nous_agru,Inf,difnous,Nous_agru2,peak_day,peak_value]=italgrip1415(inject_t,inject_q)
italia1415_matriu;
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

    S_inj=0;
    if i > peak_day && b==0
        for j = 1:length(inject_t)
            if inject_q(j) > 0 && i==round(inject_t(j))
                S_inj=inject_q(j);              
            end
            break
        end
    end


        %{
        if i==77 || i==82 || i==87 || i==92
        S(i)=220+S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
        a=0;
        c=i;
        elseif i==107 || i==113 
        S(i)=350+S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
        else 
        S(i)=S(i-1)-alpha*S(i-1)*I(i-1)*deltat;
        end
        %}
    S(i)=S(i-1)+S_inj-alpha*S(i-1)*I(i-1)*deltat;
    E(i)=E(i-1)+(alpha*S(i-1)*I(i-1)-beta*E(i-1))*deltat;
    I(i)=I(i-1)+(beta*E(i-1)-gamma*I(i-1))*deltat;
    R(i)=R(i-1)+(gamma*I(i-1))*deltat;
    Nous(i)=beta*E(i-1);

%agrupació dels casos nous per setmanes
     if i<7
     Nous_agru(i)=sum(Nous(1:i));
     else
     Nous_agru(i)=sum(Nous(i-6:i));              
     end 

    if i >= threshold_day && Nous_agru(i-1) > Nous_agru(i) && b==1
         peak_value = Nous_agru(i-1);
         peak_day = i-1;  % Día del pico
         b=0;
    end

difnous(i)=Nous_agru(i)-Nous_agru(i-1);
end

Nous_set=zeros(total_setmanes,1);
for k=1:total_setmanes
    Nous_set(k)=Nous_agru(k*7);
end
Nous_agru2=Nous_agru(7:end);

%error  quadràtic mig fins valor màxim d'INFECTATS
[~,pos]=max(Inf);
suma = 0;
for i=1:pos
    suma = suma + (Inf(i)-Nous_set(i))^2;
end
Error = sqrt(suma/pos);



Ts = 9.7656e-4;
f = 1/Ts;
k = 300;
x = generateCharacter(1/Ts);
actual_data = x;
x_temp =2*x - 1;
x = awgn(x_temp,10);
data = generateMultiple(x,k);

%%%%%%%%%%%%%%%%%%%%%%QPSK modulate%%%%%%%%%%%%%%%%%%%%%%%%
%s_p_data=reshape(data_NZR,2,length(data)/2);
s_p_data = reshape(x,2,length(x)/2);
y=[];
y_in=[];
y_qd=[];
t= Ts/k:Ts/k:Ts;
for(i=1:length(x)/2)
    y1=s_p_data(1,i)*cos(2*pi*(4/Ts)*t); % inphase component
    y2=s_p_data(2,i)*sin(2*pi*(4/Ts)*t) ;% Quadrature component
    y_in=[y_in y1]; % inphase signal vector
    y_qd=[y_qd y2]; %quadrature signal vector
    y=[y y1+y2]; % modulated signal vector
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%Plotting the final waveform%%%%%%%%%%%%%

%tt = Ts/k: Ts/k: Ts * (length(x)/2);
%plot(tt,y,LineWidth=2)
%xlim([0,0.005])
%Tx_Sig = y;
Tx_Sig = awgn(y,10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%QPSK Demodulation%%%%%%%%%%%%%%%%%%%%%%
Rx_Sig = Tx_Sig;
x_coordinate =[];
y_coordinate = [];
Rx_Data = [];
for(i= 1:length(x)/2)
    Z_in = Rx_Sig((i - 1)*length(t) + 1:i*length(t)).*cos(2*pi*(4/Ts)*t);
    Z_in_ing = (trapz(t,Z_in))*(Ts);
    x_coordinate = [x_coordinate, Z_in_ing];
    if(Z_in_ing > 0)
        Rx_in_Data = 1;
    else
        Rx_in_Data = 0;
    end

    Z_qd = Rx_Sig((i-1)*length(t) + 1: i*length(t)).*sin(2*pi*(4/Ts)*t);
    Z_qd_intg = (trapz(t,Z_qd))*(Ts);
    y_coordinate = [y_coordinate, Z_qd_intg];
    if(Z_qd_intg > 0)
        Rx_qd_data= 1;
    else
        Rx_qd_data = 0;
    end
    Rx_Data=[Rx_Data  Rx_in_Data  Rx_qd_data]; % Received Data vector
end


x = (x + 1)/2;
if(isequal(actual_data,Rx_Data))
    disp('Arrays are equal')
else
    disp('Not equal')
    index = findAnomaly(actual_data,Rx_Data)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tt = Ts/k:Ts/k:Ts*(length(x)/2);

plot(tt,y)
grid on
xlim([0,0.001])

scatter(x_coordinate,y_coordinate)
%plots to view the errors
%subplot(2,1,1)
%stem(actual_data);
%xlim([0,100])

%subplot(2,1,2)
%stem(Rx_Data);
%xlim([0,100])


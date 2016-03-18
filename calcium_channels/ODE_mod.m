%------%                   
% ODEs %  
%------%


function dxdt=ODE_Conv(t,y,cellCaPara);

%assign from parameters file
F       =cellCaPara(1);
Kr      =cellCaPara(2);
B       =cellCaPara(3);
Cb      =cellCaPara(4);
Cci     =cellCaPara(5);
Sc      =cellCaPara(6);
Datp    =cellCaPara(7);
Vd      =cellCaPara(8);
Rd      =cellCaPara(9);
L       =cellCaPara(10);
Gca     =cellCaPara(11);
Vca1    =cellCaPara(12);
Vca2    =cellCaPara(13);
Vca3    =cellCaPara(14);
Rca     =cellCaPara(15);
Gnaca   =cellCaPara(16);
Cnaca   =cellCaPara(17);
Vnaca   =cellCaPara(18);
Fnak    =cellCaPara(19);
Gci     =cellCaPara(20);
Vci     =cellCaPara(21);
Gk      =cellCaPara(22);
Vk      =cellCaPara(23);
Cw      =cellCaPara(24);
Rk      =cellCaPara(25);
iPLC    =cellCaPara(26);
k       =cellCaPara(27);
gamma   =cellCaPara(28);
lambda  =cellCaPara(29);
beta    =cellCaPara(30);
Esac    =cellCaPara(31);
Kca     =cellCaPara(32);
Cc     =cellCaPara(33);


%variables in DE
x(12)        = y(1);%cytosol Ca2+
x(13)        = y(2);%membrane V
x(14)        = y(3);%sarco Ca2+
x(15)        = y(4);%recovery var
x(16)        = y(5);%IP3

%functions
x(1)= F*((x(16)^2)/(Kr^2+x(16)^2));    %flux IP3
x(2)= (B*x(12)^2)/(Cb^2+x(12)^2);   %flux SERCA
x(3)=Cci*(x(14)^2*x(12)^4)/((Sc^2+x(14)^2)*(Cc^4+x(12))^4);    %flux CICR
x(4)= Datp*x(12)*(1+(x(13)-Vd)/Rd);    %flux Extrustion
x(5)= L*x(14);   %flux leak
x(6)= Gca*(x(13)-Vca1)/(1+ exp(-(x(13)-Vca2)/Rca));   %flux VOCC
x(7)= Gnaca*(x(12)/(x(12)+Cnaca))*(x(13)-Vnaca);   %flux NACA
x(8)= Fnak;   %flux NAK
x(9)= Gci*(x(13)-Vci);   %flux CI
x(10)= Gk*x(15)*(x(13)-Vk);   %flux K
x(11)= ((x(12)+Cw)^2)/((x(12)+Cw).^2+beta*exp(-((x(13)-Vca3)/Rk)));


%iniatilize DE derivatives
dxdt         = zeros(5,1);

% System ODE's

% dxdt(1)= F*((x(16)^2)/(Kr^2+x(16)^2));    %flux IP3
% dxdt(2)= (B*x(12)^2)/(Cb^2+x(12)^2);   %flux SERCA
% dxdt(3)=Cci*(x(14)^2*x(12)^4)/((Sc^2+x(14)^2)*(Cc^4+x(12))^4);    %flux CICR
% dxdt(4)= Datp*x(12)*(1+(x(13)-Vd)/Rd);    %flux Extrustion
% dxdt(5)= L*x(14);   %flux leak
% dxdt(6)= Gca*(x(13)-Vcal)/(1+ exp(-(x(13)-Vca2)/Rca));   %flux VOCC
% dxdt(7)= Gnaca*(x(12)/(x(12)+Cnaca))*(x(13)-Vnaca);   %flux NACA
% dxdt(8)= Fnak;   %flux NAK
% dxdt(9)= Gci*(x(13)-Vci);   %flux CI
% dxdt(10)= Gk*x(15)*(x(13)-Vk);   %flux K
% dxdt(11)= ((x(12)+Cw)^2)/((x(12)+Cw)^2+beta*exp(-((x(13)-Vca3)/Rk)));
% %(x(12)+Cw)^2/((x(12)+Cw)^2+beta*exp(-((x(13)-Vca3)/Rk)));  %activation rate constant
dxdt(1)= x(1)-x(6)+x(3)+x(5)-x(2)+x(7)-x(4);  %calcium concentration in cytosol WRT time
dxdt(2)= gamma*(-x(8)-x(9)-2*x(6)-x(7)-x(10));   %cell membrane potential WRT time
dxdt(3)= x(2)-x(3)-x(5);   %calcium concentration in SR WRT time
dxdt(4)= lambda*(x(11)-x(15));   %open-state probability of calcium-activated potassium channels WRT time
dxdt(5)= iPLC-k*x(16)+Esac*(x(12)).^2/(Kca^2+x(12).^2);   %IP3 concentration WRT time

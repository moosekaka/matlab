
%------%                   
% ODEs %  

% System ODE's

dx(1)= (F*x(1)^2)/(Kr^2+x(1)^2);    %flux IP3
dx(2)= (B*x(12)^2)/(Cb^2+x(12)^2);   %flux SERCA
dx(3)= (x(14)^2*x(12)^4)/((Sc^2+x(14)^2)*(Cc^4+x(12)));    %flux CICR
dx(4)= Datp*x(12)*(1+(x(13)-Vd)/Rd);    %flux Extrustion
dx(5)= L*x(14);   %flux leak
dx(6)= Gca*(x(13)-Vcal)/(1+ exp(-(x(13)-Vca2)/Rca));   %flux VOCC
dx(7)= Gnaca*(x(12)/(x(12)+Cnaca))*(x(13)-Vnaca);   %flux NACA
dx(8)= Fnak;   %flux NAK
dx(9)= Gci*(x(13)-Vci);   %flux CI
dx(10)= Gk*x(15)*(x(13)-Vk);   %flux K
dx(11)= (x(12)+Cw)^2/((x(12)+Cw)^2+beta*exp(-((x(13)-Vca3)/Rk)));  %activation rate constant
dx(12)= dx(1)-dx(6)+dx(3)+dx(5)-dx(2)+dx(7)-dx(4);  %calcium concentration in cytosol WRT time
dx(13)= gamma*(-dx(8)-dx(9)-2*dx(6)-dx(7)-dx(10));   %cell membrane potential WRT time
dx(14)= dx(2)-dx(3)-dx(5);   %calcium concentration in SR WRT time
dx(15)= lambda*(dx(11)-x(15));   %open-state probability of calcium-activated potassium channels WRT time
dx(16)= iPLC-k*x(1)+Esac*(x(12))^2/(Kca^2+x(12)^2);   %IP3 concentration WRT time

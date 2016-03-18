
%---------------------------------------%
% Parameter values & initial conditions %
%---------------------------------------%

%-------------------------------------------------------------------------%
%------------------------Parameters---------------------------------------%

F = .23*10^(-6);
Kr = 1*10^(-6);
B = 2.025*10^(-6);
Cb = 1*10^(-6);
Cci = 55*10^(-6);
Sc = 2*10^(-6);
Datp = 0.24;
Vd = -100*10^(-3);
Rd = 250*10^(-3);
L = 0.025;
Gca = .00129*10^-3;
Vca1 = 100*10^(-3);
Vca2 = -24*10^(-3);
Vca3 = -27*10^(-3);
Rca = 8.5*10^(-3);
Gnaca = 0.00316*10^(-3);
Cnaca = .5*10^(-6);
Vnaca = -40*10^(-3);
Fnak = 0.0432*10^(-6);
Gci = 0.00134*10^(-3);
Vci = -25*10^(-3);
Gk = 0.00446*10^(-3);
Vk = -94*10^(-3);
Cw = 0;
Rk = 12*10^(-3);
iPLC = 0.078*10^(-6);
k = .1;
gamma = 1970000;
lambda = 45;
beta = .13*10^(-12);
Esac = .01*10^(-6);
Kca = .3*10^(-6);
Cc=0.9*10^(-6);

ye=zeros(5,1); 
%parameters into a into a list

cellCaPara = [F,Kr,B,Cb,Cci,Sc,Datp,Vd,Rd,L,Gca,Vca1,Vca2,...
Vca3,Rca,Gnaca,Cnaca,Vnaca,Fnak,Gci,Vci,Gk,Vk,Cw,Rk,iPLC,k,gamma,...
lambda,beta,Esac,Kca,Cc];

% %inital conditions

ye(1) = 0.22*10^-6;
ye(2) = -.44*10^-3;
ye(3) = 0.9*10^-6;
ye(4) = .08;
ye(5) = .83*10^-6;
% 
% %array of initial conditions
% cellCaInicond = [Ca[0], S[0], W[0],IP3[0],V[0]]

% --- String array of parameters for plotting
%pString=['kv     ';'tv     ';'kp     ';'ka     ';'ki     ';'ka1a   ';'kd1a   ';'kc1a   ';'kc2a   ';'kt1a   ';'kt2a   ';'c4a    ';'c5a    ';'ki1    ';'ke1    ';'ke2a   ';'ki3a   ';'ke3a   ';... % 1 - 18
%'h      ';'k      ';'c1a    ';'c2a    ';'c3a    ';'c1     ';'c2     ';'c3     ';'c4     ';'kbA20  ';'Cc'];  % 19 - 28














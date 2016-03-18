%------%                   
% ODEs %  
%------%


function dydt=nfkbmodel(t,y,p,TR);


kv      =p(1);
tv      =p(2);
kp      =p(3);
ka      =p(4);
ki      =p(5);
ka1a    =p(6);
kd1a    =p(7);
kc1a    =p(8);
kc2a    =p(9);
kt1a    =p(10);
kt2a    =p(11);
c4a     =p(12);
c5a     =p(13);
ki1     =p(14);
ke1     =p(15);
ke2a    =p(16);
ki3a    =p(17);
ke3a    =p(18);
h       =p(19);
k       =p(20);
c1a     =p(21);
c2a     =p(22);
c3a     =p(23);
c1      =p(24);
c2      =p(25);
c3      =p(26);
c4      =p(27);
kbA20   =p(28);

% This needs to match output in simulation file
NFkB         = y(1);
IkBa         = y(2); 
IkBaNFkB     = y(3);  
nNFkB        = y(4); 
nIkBa        = y(5);  
nIkBaNFkB    = y(6); 
tIkBa        = y(7);
IKKn         = y(8); 
IKK          = y(9);
IKKIkBa      = y(10);  
IKKIkBaNFkB  = y(11);
IKKi         = y(12);
tA20         = y(13);
A20          = y(14);
pIkBa        = y(15);
pIkBaNFkB    = y(16);
dydt         = zeros(16,1);

% ---
% Note that A20 inhibition is still dependent on TNFa presence (i.e. TR=1)      
% ----
% Included TRA20 to allow for kbA20 independence of TR 
% i.e. TRA20 = TR (is final model used) TRA20=1 gives A20 TNFa independence
TRA20 = TR;

% System ODE's - No IKK complexes %
dydt(1)=kd1a*IkBaNFkB - ka1a*IkBa*NFkB - ki1*NFkB + c5a*IkBaNFkB + ke1*nNFkB + kt2a*pIkBaNFkB; % Free Cytoplasmic NFkB        %   - ka1a*IKKIkBa*NFkB + kd1a*IKKIkBaNFkB
dydt(2)=kd1a*IkBaNFkB - ka1a*IkBa*NFkB - ki3a*IkBa + ke3a*nIkBa - c4a*IkBa + c2a*tIkBa      - kc1a*IKK*IkBa; % Free Cytoplasmic IkBa                 % - ka2*IKK*IkBa + kd2*IKKIkBa
dydt(3)=ka1a*IkBa*NFkB - kd1a*IkBaNFkB + ke2a*nIkBaNFkB - c5a*IkBaNFkB                     - kc2a*IKK*IkBaNFkB; % Cytoplasmic NFkB-IkBa             %  - ka3*IKK*IkBaNFkB + kd3*IKKIkBaNFkB
dydt(4)=kd1a*nIkBaNFkB - ka1a*nIkBa*nNFkB + kv*ki1*NFkB - kv*ke1*nNFkB;             % Free Nuclear NFkB     + kdegcn*nIkBaNFkB
dydt(5)=kd1a*nIkBaNFkB - ka1a*nIkBa*nNFkB + kv*ki3a*IkBa - kv*ke3a*nIkBa - c4a*nIkBa;   % Free Nuclear IkBa
dydt(6)=ka1a*nIkBa*nNFkB - kd1a*nIkBaNFkB - kv*ke2a*nIkBaNFkB;          % Nuclear NFkB-IkBa      - kdegcn*nIkBaNFkB
dydt(7)=c1a*(nNFkB^h/(nNFkB^h + k^h)) - c3a*tIkBa;  % tIkBa - IkBa transript        + kctria
dydt(8)=kp*IKKi*(kbA20/(kbA20+A20*TRA20)) - TR*ka*IKKn;  % IKKn
dydt(9)=TR*ka*IKKn - ki*IKK;  % IKK - Free active IKK          - ka2*IKK*IkBa + kd2*IKKIkBa - ka3*IKK*IkBaNFkB + kd3*IKKIkBaNFkB + kc1a*IKKIkBa + kc2a*IKKIkBaNFkB;
dydt(10)=0;   % IKKIkBa - IkB bound active IKK
dydt(11)=0;   % IKKIkBaNFkB  trimeric IkBa-NFKB bound active IKK
dydt(12)=ki*IKK - kp*IKKi*(kbA20/(kbA20+A20*TRA20));    % IKKi - Inactive IKK
dydt(13)=c1*(nNFkB^h/(nNFkB^h + k^h)) - c3*tA20;      %  tA20 - A20 transript       + kctra
dydt(14)=c2*tA20 - c4*A20;  % A20
dydt(15)=kc1a*IKK*IkBa - kt1a*pIkBa;  % pIkBa - Phosphorylated IkBa
dydt(16)=kc2a*IKK*IkBaNFkB - kt2a*pIkBaNFkB; % pIkBaNFkB - NFkB bound phosphoryated IkBa

% Terms commented to right of equations used for representation of IKK complexes

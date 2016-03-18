%-----------------%                   
% Simulation File %  
%-----------------%

parameters; 


for condition=1:5

% --- Initialise variables & simulation parameters 
T = [];
Y = [];
freq=0;
simChartOut=0;

%%% --- ASSIGN TIME PARAMETERS --- %
te = 4000*60;                 % equilibration duration
tend = 600*60;                 % length of simulation from introducing TNF
numStim = 1;                   % for all conditions =1, for multiple pulses state num inputs required

switch condition
    case 1
        ton=tend;
        freq=0;
        numStim = 1;
    case 2
        ton=45*60;
        freq=tend;
        numStim = 1;
    case 3
        ton=5*60;
        freq=60*60;
    case 4
        ton=5*60;
        freq=100*60;
    case 5
        ton=5*60;
        freq=200*60;
end


% ----- Run simulation ----- %
options = odeset('AbsTol',1e-12,'RelTol',1e-9);%

%* 1. set equilibrium state *%
TR =0;
numSteps = (te/60)+1;
tspan = linspace(0,te,numSteps);
[TE,YE]=ode15s(@nfkbmodel,tspan,ye,options,p,TR); 

%% For equilibration stage plot
%    [ncNFkB,totIkBa,totpIkBa,totIKKa,A20,tIkBa,tA20,IKKn,totnNFkB]= processSim(TE,YE,p,1);

% initialise next stage
T = 0;
Y = YE(end,:);
count = 0;

% If TNFa condition run following simulations
if condition>0
    while numStim>0
        
        % Initial time/state conditions
        t0 = T(end);
        y0 = Y(end,:);

        % assign time parameters
        tmax = (t0+ton);
        if (tend<tmax)||(numStim == 0)
            tmax = tend;
        end
        if t0==tmax
            break;
        end

        %* add TNF and run simulation *%
        TR = 1;
        numSteps = round(((tmax-t0)/60)+1); % change to 60sec steps for multipulse
        tspan = linspace(t0,tmax,numSteps);
        [T1,Y1]=ode15s(@nfkbmodel,tspan,y0,[],p,TR);
        
        % Append new simulation output to previous output
        if count==0
            T = T1;
            Y = Y1;
        else
            T = [T(1:(end-1));T1];
            Y = [Y(1:(end-1),:);Y1];     
        end

        % decrease counter for number of inputs
        numStim = numStim-1;
        
        % simulate wash stage if pulse condition selected
        if condition > 1
            % Initial time/state conditions
            t0 = T(end);
            y0 = Y(end,:);

            % assign time parameters
            tmax = t0+(freq-ton);
            if (tend<tmax)||(numStim == 0)
                tmax = tend;
            end
            if t0==tmax
                break;
            end
        
            %* wash TNF and run remaining simulation *%
            TR =0;
            numSteps = round(((tmax-t0)/60)+1);
            tspan = linspace(t0,tmax,numSteps);
            [T2,Y2]=ode15s(@nfkbmodel,tspan,y0,[],p,TR);

            % Append new simulation output to previous output
            T = [T(1:(end-1));T2];
            Y = [Y(1:(end-1),:);Y2];

        else % condition = 1, continuous stimulation
            T = T1;
            Y = Y1;
        end % end stim (& wash) stage
        % increase counter for number of inputs
        count = count + 1;
    end % end for numStim >0
else % equilibration result
    T = TE;
    Y = YE;
    Per = [];
    pulseAmp = [];
end

% --- process (& plotsim - optional)
T = T/60;    % adjust time to mins
[ncNFkB,totIkBa,totpIkBa,totIKKa,A20,tIkBa,tA20,IKKn,totnNFkB]= processSim(T,Y,p,freq,simChartOut);

end
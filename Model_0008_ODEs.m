function ODE = Model_0008_ODEs(t,y)

% Switch individual variables on or off
T4SW      =  1;
T4iSW     =  1;
T4ilSW    =  1;
T8SW      =  1;
T8iSW     =  0;
TMSW      =  0;
DSW       =  0;
DiSW      =  0;
MSW       =  1;
MiSW      =  1;
VSW       =  1;

% declare global variables for parameters. Using globals is much faster.
global sT4 kT4 artkT4 dT4 kT4Mi rT4 CT4 kT8T4i pT4i artpT4i lT4i dT4i dT4iX dT4iT8 pT4il aT4il lraT4il dT4il dT4ilT8 sT8 kT8 artkT8 dT8 dT8M rT8 rT8T4i CT8 CT8T4i dT8i pT8i artpT8i sTM kTM rTM CTM dTM sD kD dD dDX rD CD pDi dDi dDiX sM kM dM dMX rM CM pMi dMi dMiT8 dMiT4 aVT4i dV dVMMi mmV

% initialize ODE as a columnvector
ODE = zeros(size(y)); 

% For readability: Assign y values to readable variable names like T4
% y and ODE vectors must contain vars in same sequence!

T4      =  y(1) * T4SW;
T4i     =  y(2) * T4iSW;
T4il    =  y(3) * T4ilSW;
T8      =  y(4) * T8SW;
T8i     =  y(5) * T8iSW;
TM      =  y(6) * TMSW;
D       =  y(7) * DSW;
Di      =  y(8) * DiSW;
M       =  y(9) * MSW;
Mi      = y(10) * MiSW;
V       = y(11) * VSW;
T4ix    = y(12);

% Define ODEs.
% ddt prefix denotes d/dt, e.g. ddtT4 = d/dt T4

ddtT4    = sT4 + rT4*V*T4 / (CT4 + V) - artkT4*kT4*T4*V - artkT4*kT4Mi*T4*Mi - dT4*T4;
ddtT4i   = artkT4*kT4*T4*V + artkT4*kT4Mi*T4*Mi - dT4iT8*T8*T4i - lT4i*T4i  - dT4i*T4i + lraT4il*aT4il*T4il;
ddtT4il  = lT4i*T4i - dT4ilT8*T8*T4il - lraT4il*aT4il*T4il - dT4il*T4il;
ddtT8    = sT8 + rT8*V*T8 / (CT8 + V) + rT8T4i*T4i*T8 / (CT8T4i + T4i) - artkT8*kT8*T8*V - kT8T4i*T8*T4i - dT8M*T8*M - dT8*T8;
ddtM     = sM + rM*V*M / (CM + V) - kM*M*V - dM*M;
ddtMi    = kM*M*V - dMiT8*Mi*T8 - dMiT4*Mi*T4 - dMi*Mi;
ddtV     = artpT4i*pT4i*T4i + artpT8i*pT8i*T8i + pT4il*T4il + pDi*Di + pMi*Mi + aVT4i*T8*T4i - dV*V;

% Currently unused
ddtT8i   = 0; % artkT8*kT8*T8*V + kT8T4i*T8*T4i - dT8i*T8i;
ddtTM    = 0; %  sTM + rTM*V*TM / (CTM + V) - kTM*TM*V - dTM*TM;
ddtD     = 0; %  sD + rD*V*D / (CD + V) - kD*D*V - dD*D;
ddtDi    = 0; %  kD*D*V - dDi*Di;
ddtT4ix  = 0; %  dT4i*T4i + dT4iT8*T8*T4i - dT4iX*T4i;

% Assign values from internal variables ddt... to output of function
ODE(1)   = ddtT4      * T4SW;
ODE(2)   = ddtT4i     * T4iSW;
ODE(3)   = ddtT4il    * T4ilSW;
ODE(4)   = ddtT8      * T8SW;
ODE(5)   = ddtT8i     * T8iSW;
ODE(6)   = ddtTM      * TMSW;
ODE(7)   = ddtD       * DSW;
ODE(8)   = ddtDi      * DiSW;
ODE(9)   = ddtM       * MSW;
ODE(10)  = ddtMi      * MiSW;
ODE(11)  = ddtV       * VSW;
ODE(12)  = ddtT4ix;
end
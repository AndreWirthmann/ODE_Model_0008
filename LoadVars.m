global ParameterFileName Parameters SweepDef ModelName FigLogPath

ModelName = 'Model-0008'; % Is specific to ODE function and Parameters file. Use filename instead. Make sure its used throughout

% Define OutputPath

%FigLogPath = 'm:\FigLog\'; % Static path.

FigLogSubDir = 'Output'; % Subdir in present working dir.
FigLogPath = [pwd() '\' FigLogSubDir];
if ~isdir(FigLogPath) %If it doesnt exist, make it.
    mkdir(FigLogPath);
end

options = odeset('AbsTol',1e-9); %,'Stats','on');

Parameters = readtable(ParameterFileName,'Sheet', 'Pars');
SweepDef = readtable(ParameterFileName,'Sheet', 'Sweep');

% Modify Parameters
BaseName = B.Properties.VariableNames{BaseNo};
Base = B(:,BaseNo);
Parameters(1:34,2) = Base;
Parameters(1:34,3) = Base;
Parameters(1:34,4) = Base;
Parameters(1:34,5) = Base;
Parameters(1:34,6) = Base;
Parameters(1:2,[2,5:6]) = {1};
Parameters(23,[2:3,5:6]) = {1};
SweepDef(1:34,2) = Base;
SweepDef(1:34,3:4) = LH(:,3:4);

ParNames = Parameters.Name;
Parameters(:,1) = [];
Parameters = array2table(table2array(Parameters)');
Parameters.Properties.VariableNames = ParNames;
return
global ParameterFileName Parameters ModelName FigLogPath
global MV DV P run

% Create global individual variables for each parameter to speed up solver
for VarNo = 1:width(Parameters)
    eval(['global ',Parameters.Properties.VariableNames{VarNo},';']);
end

InitialCondVars = {'T4_0','T4i_0','T4il_0','T8_0','T8i_0','TM_0','D_0','Di_0','M_0','Mi_0','V_0','T4ix_0'};

clear Result;
Result = struct;

for run = 1:ThisNumberOfRuns
    disp(['Column ' num2str(BaseNo),'   Base: ',BaseName, '  Step ', num2str(run),' of ', num2str(ThisNumberOfRuns), '  Sweep ' , num2str(SweepNo), ' of ', num2str(NumberOfSweeps)]);
    
    MV = table;

    % Copy pars into stages for this run
    NewPar(1:length(ThisSweepStage)) = ThisSweepVector(run);
    Parameters(ThisSweepStage,ThisSweepParName) = table(NewPar');
    clear NewPar

    % Solve each Stage
    for Stage = 1:NumberOfStages      
        
        % Set global parameters for this stage
        for VarNo = 1:width(Parameters)
            eval([Parameters.Properties.VariableNames{VarNo},' = ',char(string(Parameters{Stage,VarNo})),';']);
        end
        
        % Generate time interval tspan for stage
        tStart = Parameters.tDays(Stage);
        tEnd = Parameters.tDays(Stage+1);
        tSteps = (tEnd - tStart) * tStepsPerDay;
        tSpan = linspace(tStart,tEnd,tSteps);
        
        % Get initial values to pass to solver
        if InitVars == 1 % Set initial values from parameters or take from last stage?
            y0 = Parameters{Stage,InitialCondVars};
        else % take from last Stage
            y0 = y(end,:);
        end
        
        % Call solver
        [t,y] = ode15s( @(t,y) Model_0008_ODEs(t,y), tSpan, y0, options);
        
        % Store results and append for each stage
        Va = table;
        Va.t     = t;
        Va.T4    = y(:,1);
        Va.T4i   = y(:,2);
        Va.T4il  = y(:,3);
        Va.T8    = y(:,4);
        Va.T8i   = y(:,5);
        Va.TM    = y(:,6);
        Va.D     = y(:,7);
        Va.Di    = y(:,8);
        Va.M     = y(:,9);
        Va.Mi    = y(:,10);
        Va.V     = y(:,11);
        Va.T4ix  = y(:,12);
        
        MV = [MV ; Va];
        clear Va;
                
    end
    
    Result(run).run = run;
    Result(run).MV = MV;
    Result(run).P = Parameters;
    
end
return
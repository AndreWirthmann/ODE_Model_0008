global Parameters ParametersBase SweepDef ModelName FigLogPath
global P 

MainFileName = [ModelName ' ' MyTS() ' ' BaseName];

% Save Parameters and SweepDef
writetable(Parameters,[FigLogPath '\' MainFileName ' Base.xlsx']);
writetable(SweepDef,[FigLogPath '\' MainFileName ' SweepDef.xlsx']);

ParametersBase = Parameters;
NumberOfStages = height(Parameters) - 1;  % last row is only for tEnd, not a real Stage
NumberOfVars = height(SweepDef);

% Count sweeps
SW = struct;
SweepNo = 0;
for VarNo = 1:NumberOfVars
    if SweepDef.Sweep{VarNo}=='Y'        
        SweepNo = SweepNo + 1;
        SW(SweepNo).SweepNo = SweepNo;        
        SW(SweepNo).SweepVarName = SweepDef.Name{VarNo};
        
        SW(SweepNo).Base = SweepDef.Base(VarNo);
        
        SW(SweepNo).SweepStage = SweepDef.SweepStage{VarNo};
        SW(SweepNo).SweepLow = SweepDef.SweepLow(VarNo);
        SW(SweepNo).SweepHigh = SweepDef.SweepHigh(VarNo);
        
        SW(SweepNo).NumberOfRuns = SweepDef.SweepSteps(VarNo);
        SW(SweepNo).SweepVector = linspace(SweepDef.SweepLow(VarNo),SweepDef.SweepHigh(VarNo),SweepDef.SweepSteps(VarNo));        
    end
end
NumberOfSweeps = SweepNo;

% Run sweeps and save to disc
for SweepNo = 1:NumberOfSweeps
SW(SweepNo).SweepName = [MainFileName ' ' SW(SweepNo).SweepVarName ' [' num2str(SW(SweepNo).SweepLow,'%+0.2e') ' ' num2str(SW(SweepNo).SweepHigh,'%+0.2e') ']'];

    ThisNumberOfRuns = SW(SweepNo).NumberOfRuns;
    ThisSweepParName = SW(SweepNo).SweepVarName;
    ThisSweepName = SW(SweepNo).SweepName;
    ThisSweepStage = eval(SW(SweepNo).SweepStage);
    ThisSweepVector = [SW(SweepNo).SweepVector];
   
    % Initialize to Base
    Parameters = ParametersBase;
    
    % Solve the model
    Model_0008b;
    
    % Calculate derived metrics
    CalcDaysToRebound;
    
    % Store results in memory
    SW(SweepNo).Result = Result;
    SW(SweepNo).M = M;    
end

% Save results to disk
save([FigLogPath '\' MainFileName],'SW');

% Plot1
P = ParametersBase;  % improve data structure
NumberOfSweeps = size(SW,2);
FigName = 'F2';
[num,txt,raw] = xlsread('Figures.xlsx',FigName);
[NLines,NRows] = size(txt);

FigNote = [];
FigNote2 = [];
SweepVarNames = [];
PlotCount = 0;
m = [];
for n = 1:NumberOfSweeps
    
    PlotCount = PlotCount + 1;
    m = [m n];
    SweepVarNames = [SweepVarNames  SW(n).SweepVarName ' '];    
    
    if PlotCount == 4       
        FigNote = [MainFileName ' DTR ' SweepVarNames];
        Fig;
        PlotCount = 0;
        m = [];
        FigNote = [];
        SweepVarNames = [];
    end    
    
    if n == NumberOfSweeps
        if PlotCount < 4
            m = [m n];
            m = [m n];
            m = [m n];
            m = [m n];     
            FigNote = [MainFileName ' DTR ' SweepVarNames];
            Fig;  % Saving to disc is called by Fig
        end
    end
end

% Plot2
P = ParametersBase;    
FigName = 'F1b';
FigNote = [];
[num,txt,raw] = xlsread('Figures.xlsx',FigName);
[NLines,NRows] = size(txt);
for SweepNo = 1:NumberOfSweeps
    clear C Ct CT5 CT4i CT4il CT8 CM CMi CV
    for step = 1:SW(SweepNo).NumberOfRuns        
        try
            C(:,:,step) = table2array(SW(SweepNo).Result(step).MV(:,:));
        catch % In case array too small because ODE solver didn't find solution
            warning('Subscripted assignment dimension mismatch...');
        end        
    end
    Ct = C(:,1,1);    
    CT4 = squeeze(C(:,2,:));
    CT4i = squeeze(C(:,3,:));
    CT4il = squeeze(C(:,4,:));
    CT8 = squeeze(C(:,5,:));
    CM = squeeze(C(:,10,:));
    CMi = squeeze(C(:,11,:));
    CV = squeeze(C(:,12,:));

    FigNote = SW(SweepNo).SweepName;
    Fig; % Saving to disc is called by Fig
end
return
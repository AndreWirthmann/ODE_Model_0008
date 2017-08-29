clear M;
clear DTR_V;
clear DTR_T4_200;
clear DTR_T4_300;
clear DTR_T4_500;

NoOfRuns = size(Result,2);
Z = zeros(NoOfRuns,1);
M = table;
M.ThisSweepVector = ThisSweepVector';
M.Properties.VariableNames{1} = ThisSweepParName;
M.DTR_V = Z;
M.DTR_T4_200 = Z;
M.DTR_T4_300 = Z;
M.DTR_T4_500 = Z;

for n=1:NoOfRuns
    M.DTR_V(n) = DaysToRebound(Result(n).MV.t,Result(n).MV.V,50,1180,0);
    M.DTR_T4_200(n) = DaysAbove(Result(n).MV.t,Result(n).MV.T4,200,1180,0);
    M.DTR_T4_300(n) = DaysAbove(Result(n).MV.t,Result(n).MV.T4,300,1180,0);
    M.DTR_T4_500(n) = DaysAbove(Result(n).MV.t,Result(n).MV.T4,500,1180,0);
end
return;
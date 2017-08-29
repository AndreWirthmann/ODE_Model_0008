Init;

for BaseNo = 3:10000 % These correspond to columns in ParameterFileName

    % Read file again for each column, thus can add columns at runtime.
    B = readtable(ParameterFileName,'Sheet', 'B');
    LH = readtable(ParameterFileName,'Sheet', 'LH');
    
    clearvars -except  B LH BaseNo ParameterFileName
    try
        LoadVars;
    catch
        break;
    end

    Main;
end
disp('Done');
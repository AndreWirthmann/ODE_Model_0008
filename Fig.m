global P MV DV run
for Line = 11:NLines
    for Row = 2:NRows
        Cmd = txt{1,Row};
        Arg = txt{Line,Row};
        Pre = txt{2,Row};
        Post = [txt{3:8,Row}];
        CmdArg = [Cmd Pre Arg Post];
        if ~isempty(Arg)
            % disp(['L:R ', num2str(Line), ':', num2str(Row),'  ', CmdArg]);
            eval(CmdArg);
        end            
    end
end
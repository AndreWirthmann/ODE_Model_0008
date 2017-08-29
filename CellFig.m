function CellFig(CellCmd)
global MV DV P;
NLines = size(CellCmd,1);
for Line = 1:NLines
    Cmd = [CellCmd{Line,:}];
    disp([char(10) 'Line ', num2str(Line), ' of ', num2str(NLines), ': ', Cmd]);
    eval(Cmd);
end
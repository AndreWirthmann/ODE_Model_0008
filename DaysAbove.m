function DA = DaysAbove(Myt,Myy,yLim,MytStart,dtBlind)
% Returns time at which Myy < yLim
% measured after MytStart in units of Myt
% dtBlind: "blind" interval after MytStart in units of Myt.
% No evaluation within this blind interval.

% set values before MytStart+dtBlind to something larger than yLim
Myy(Myt<MytStart+dtBlind) = yLim + 10;

% find index of Myy for first Myy < yLim
tIdx = find(Myy < yLim,1);

% get t for that index
tDA = Myt(tIdx);

% return difference with MytStart. dtBlind is counted.
DA = tDA - MytStart;

if isempty(DA)
    clear DA;
    DA = 0;
end
end
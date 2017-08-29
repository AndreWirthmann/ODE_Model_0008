function DTR = DaysToRebound(t,y,yLim,tStart,dtBlind)
% Returns time at which y > yLim
% This time is given by t and measured after tStart
% dtBlind: "blind" interval after tStart in units of t.
% No evaluation within this blind interval.

% set values before tStart+dtBlind to 0, i.e. smaller than yLim
y(t<tStart+dtBlind) = 0;

% find index of y for first y > yLim
tReboundIdx = find(y > yLim,1);

% get t for that index
tRebound = t(tReboundIdx);

% return difference with tStart. dtBlind is counted.
DTR = tRebound - tStart;

if isempty(DTR)
    clear DTR;
    DTR = 0;
end
end
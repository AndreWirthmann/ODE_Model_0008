function Par2Fig(P,ParNames,Stage,xPos,yPos)
% Appends parameter name value pairs to currently active figure
% P is table with all parameter values for each Stage
% ParNames lists parameters to be added
% xPos, yPos: normalized coords of text

% Get and format the Parameter name value pairs
TextCell = [ParNames; table2cell(P(Stage,ParNames))];
SubPlotTxt = sprintf('%s %+0.2e\n',string(TextCell));

% Add them to figure as text object
t = text;
t.String = SubPlotTxt;
t.Units = 'normalized';
t.Position = [xPos yPos];
t.FontName = 'FixedWidth';
% t.FontWeight = 'bold';
t.HorizontalAlignment = 'right';
return
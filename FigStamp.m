function FigStamp(FigStampTxt)

% Add timestamp to figure
StampText = text;
StampText.String = FigStampTxt;
StampText.Units = 'normalized';
StampText.Position = [.98 .10];
StampText.FontName = 'FixedWidth';
% StampText.FontWeight = 'bold';
StampText.HorizontalAlignment = 'right';

end
function FigSave2(FileName)
global FigLogPath
FullPath = [FigLogPath '\' FileName '.jpg'];
print(FullPath,'-djpeg','-r300') % This writes to disc.
end
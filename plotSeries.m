function [fig,p,f,t_p] = plotSeries(t,y)
%PLOTSERIES Plot time-series of audio data related to collisions
%
%  plotSeries(t,y);
%  fig = plotSeries(t,y);
%  [fig,pxx,f] = plotSeries(t,y);
%
% Inputs
%  t - Relative time of each sample within the record of data `y`
%  y - Amplitude values presumably returned by `writeCollisionSounds`
%
% Output
%  fig - If this is not requested, the figure is automatically saved and
%           deleted. Otherwise, this is returned as the figure handle of
%           the generated figure object.
%
%  pxx - Frequency power content (should have values for
%  f   - Frequency bins
%
%  The top panel is the time-series, while the bottom is the frequency
%  content of the top time-series.
%
% See also: Contents, main.m, writeCollisionSounds, pspectrum

if iscell(y)
   n = numel(y);
   if nargout > 0
      fig = gobjects(n,1);
      p = cell(n,1);
      f = cell(n,1);
      t_p = cell(n,1);
      for ii = 1:n
         [fig(ii),p{ii},f{ii},t_p{ii}] = plotSeries(t{ii},y{ii});
      end
   else
      for ii = 1:n
         plotSeries(t{ii},y{ii});
      end
   end
   return;
end

if size(get(groot,'MonitorPositions'),1) > 1
   pos = [1.0984  0.11481  0.69688  0.57685];
else
   pos = [0.14948 0.2463   0.69688  0.57685];
end

s = getSmoothedRate(y,t);

fig = figure('Name','Collision Series Time-Amplitude and Frequency Content',...
   'Color','w','Units','Normalized','Position',pos,...
   'NumberTitle','off');

ax = subplot(2,1,1);
set(ax,'Parent',fig,'FontName','Arial','FontSize',13,...
   'XColor','k','YColor','k','LineWidth',1.5,...
   'NextPlot','add','XLim',[t(1), t(end)],'YLim',[-1 1]);
line(ax,t,y,'LineWidth',1.5,'Color','k',...
   'DisplayName','(Noisy) Collision Impulses');
line(ax,t,s,'LineWidth',1.5,'Color','b',...
   'DisplayName','Normalized Collision Rate');
ylabel(ax,'Normalized Amplitude','FontName','Arial','FontSize',18,'Color','k');
title(ax,'Collision Time (top) and Frequency (bottom) Content',...
   'FontName','Arial','Color','k','FontSize',18,'FontWeight','bold');
legend(ax,'Location','southeast',...
   'FontName','Arial','TextColor','black','FontSize',13,...
   'Color','white','EdgeColor','black','LineWidth',2);

ax = subplot(2,1,2);
colormap(ax,'turbo');
set(ax,'Parent',fig,'FontName','Arial','FontSize',13,...
   'XColor','k','YColor','k','LineWidth',1.5,...
   'NextPlot','add','XLim',[t(1), t(end)]);
[p,f,t_p] = pspectrum(y,t,'spectrogram',...
   'FrequencyLimits',[0 200],...
   'TimeResolution',0.2);
imagesc(ax,t,f,p);
xlabel(ax,'Time (sec)','FontName','Arial','FontSize',18,'Color','k');
ylabel(ax,'Frequency (Hz)','FontName','Arial','FontSize',18,'Color','k');
cb = colorbar(ax,'northoutside');
set(cb.Label,'String','Power (dB)','FontName','Arial','Color','k','FontWeight','bold');

tickValues = [0.00005, 0.0005, 0.00075 0.00105];
tickMarks = mag2db(tickValues);
tickLabels = strsplit(num2str(round(tickMarks,0)),' ');
set(cb,'AxisLocation','out','TickDir','in','Color',[0 0 0],...
   'FontWeight','bold','FontName','Arial',...
   'Ticks',tickValues,...
   'TickLabels',tickLabels);
if nargout > 0
   return;
end

io.optSaveFig(fig,'figures/Time-Frequency-Content',...
      sprintf('Series__%d-samples',numel(t)));

end
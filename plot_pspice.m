% load data
% assuming traces have already been loaded
load('complete_both_delay.mat');
traces = PSpiceData_1.Analysis.Sweep.Analog_Traces;

% find the data with Name 'Time'
timeData = [];
for i = 1:length(traces)
    if strcmp(traces(i).Name, 'Time')
        timeData = traces(i).Data;
        break;
    end
end

% check if timeData was found
if isempty(timeData)
    error('Time data not found');
end

% initialize figure
figure;
hold on;

% plot data for other traces
for i = 1:length(traces)
    if ~strcmp(traces(i).Name, 'Time')
        plot(timeData, traces(i).Data, 'LineWidth', 3, 'DisplayName', traces(i).Name);
    end
end

% set legend and axis labels
legend;
xlabel('Time');
ylabel('Value');
title('HAND PDN Voltage Diagram');
grid on;
hold off;

% PLOTTEMPS  A Matlab program to read and plot global temperature data from NASA.

% trim text lines from start of the file
data = load('647_Global_Temperature_Data_File.txt');

year = data(:,1);
temp = data(:,2);

figure(1)
plot(year,temp,'ko-')
xlabel('year','fontsize',24.0)
ylabel('temperature anomaly (C)','fontsize',24.0)
title('global temperature relative to 1951-1980 average','fontsize',12.0)

recent = 28;
year_recent = year(end-recent:end);
temp_recent = temp(end-recent:end);

figure(2)
plot(year_recent,temp_recent,'ko-')
xlabel('year','fontsize',24.0)
ylabel('temperature anomaly (C)','fontsize',24.0)
axis([1990 2020 0.0 1.0])
grid on
print -dpdf recenttemps.pdf


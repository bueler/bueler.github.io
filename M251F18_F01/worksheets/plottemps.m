% PLOTTEMPS  A Matlab program to read and plot global temperature data from NASA.

data = load('647_Global_Temperature_Data_File.txt');

year = data(:,1);
temp = data(:,2);

figure(1)
plot(year,temp,'o-')
xlabel('year','fontsize',24.0)
ylabel('temperature anomaly','fontsize',24.0)
title('global temperature relative to 1951-1980 average','fontsize',30.0)

year_recent = year(end-27:end);
temp_recent = temp(end-27:end);

figure(2)
plot(year_recent,temp_recent,'o-')
xlabel('year','fontsize',24.0)
ylabel('temperature anomaly','fontsize',24.0)


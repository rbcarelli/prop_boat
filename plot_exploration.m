clc
close all
% t_end = 1;

filename = strcat('C:\Users\rbcar\Documents\MIT\~Thesis\Data\Cal Data\','3','.lvm');
file = dlmread(filename);
time=file(:,1);
force=smoothdata(file(:,2),'movmean',200);


% t = t_end-1:0.01:t_end;
% % y = sin(2*pi*t);
% t_end = t_end + 0.1;
figure(1)
plot(time, force)
% xlim([0 4])
pause(0.5)
[x,z] = ginput;
[garbage, idx1] = min(abs(time-x(1)));
[garbage, idx2] = min(abs(time-x(2)));
time_short = time(idx1:idx2);
valuable_data = force(idx1:idx2);
subplot(2,1,1)
plot(time, force)
subplot(2,1,2)
plot(time_short, valuable_data)

mean_val = sum(valuable_data)/length(valuable_data)




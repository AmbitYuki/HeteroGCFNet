%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID30\';
all_files  = dir(fullfile(filepath,'*.json'));
l_file = length(all_files);

for ii = 1:l_file
    by_file(ii,1) = all_files(ii).bytes;
    name_file1(ii,1)= str2num(all_files(ii).name(1:end-25));
    ID30_data = jsonread(strcat(filepath,all_files(ii).name));
    ID30_breath(ii) = ID30_data.breath;
    ID30_heart_rate(ii) = ID30_data.heart_rate;
    ID30_totalMotion(ii) = ID30_data.totalMotion;
    ID30_opticalpower(:,ii) = ID30_data.opticalpower;
end
writematrix(ID30_breath,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID30breath.txt',WriteMode='overwrite');
writematrix(ID30_heart_rate,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID30heart.txt',WriteMode='overwrite');
writematrix(ID30_totalMotion,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID30motion.txt',WriteMode='overwrite');
writematrix(ID30_opticalpower,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID30power.txt',WriteMode='overwrite');
% ID30_data = jsonread(strcat(filepath,all_files(1).name));



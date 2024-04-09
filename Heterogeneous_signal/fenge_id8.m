%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID8\';
all_files  = dir(fullfile(filepath,'*.json'));
l_file = length(all_files);

for ii = 1:l_file
    by_file(ii,1) = all_files(ii).bytes;
    name_file1(ii,1)= str2num(all_files(ii).name(1:end-25));
    ID8_data = jsonread(strcat(filepath,all_files(ii).name));
    ID8_breath(ii) = ID8_data.breath;
    ID8_heart_rate(ii) = ID8_data.heart_rate;
    ID8_totalMotion(ii) = ID8_data.totalMotion;
    ID8_opticalpower(:,ii) = ID8_data.opticalpower;
end
writematrix(ID8_breath,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID8breath.txt',WriteMode='overwrite');
writematrix(ID8_heart_rate,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID8heart.txt',WriteMode='overwrite');
writematrix(ID8_totalMotion,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID8motion.txt',WriteMode='overwrite');
writematrix(ID8_opticalpower,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID8power.txt',WriteMode='overwrite');
% ID8_data = jsonread(strcat(filepath,all_files(1).name));



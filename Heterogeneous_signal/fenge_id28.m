%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID28\';
all_files  = dir(fullfile(filepath,'*.json'));
l_file = length(all_files);

for ii = 1:l_file
    by_file(ii,1) = all_files(ii).bytes;
    name_file1(ii,1)= str2num(all_files(ii).name(1:end-25));
    ID28_data = jsonread(strcat(filepath,all_files(ii).name));
    ID28_breath(ii) = ID28_data.breath;
    ID28_heart_rate(ii) = ID28_data.heart_rate;
    ID28_totalMotion(ii) = ID28_data.totalMotion;
    ID28_opticalpower(:,ii) = ID28_data.opticalpower;
end
writematrix(ID28_breath,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID28breath.txt',WriteMode='overwrite');
writematrix(ID28_heart_rate,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID28heart.txt',WriteMode='overwrite');
writematrix(ID28_totalMotion,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID28motion.txt',WriteMode='overwrite');
writematrix(ID28_opticalpower,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID28power.txt',WriteMode='overwrite');
% ID28_data = jsonread(strcat(filepath,all_files(1).name));



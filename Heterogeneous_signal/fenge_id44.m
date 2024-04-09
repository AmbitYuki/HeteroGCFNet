%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID44\';
all_files  = dir(fullfile(filepath,'*.json'));
l_file = length(all_files);

for ii = 1:l_file
    by_file(ii,1) = all_files(ii).bytes;
    name_file1(ii,1)= str2num(all_files(ii).name(1:end-25));
    ID44_data = jsonread(strcat(filepath,all_files(ii).name));
    ID44_breath(ii) = ID44_data.breath;
    ID44_heart_rate(ii) = ID44_data.heart_rate;
    ID44_totalMotion(ii) = ID44_data.totalMotion;
    ID44_opticalpower(:,ii) = ID44_data.opticalpower;
end
writematrix(ID44_breath,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID44breath.txt',WriteMode='overwrite');
writematrix(ID44_heart_rate,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID44heart.txt',WriteMode='overwrite');
writematrix(ID44_totalMotion,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID44motion.txt',WriteMode='overwrite');
writematrix(ID44_opticalpower,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID44power.txt',WriteMode='overwrite');
% ID44_data = jsonread(strcat(filepath,all_files(1).name));



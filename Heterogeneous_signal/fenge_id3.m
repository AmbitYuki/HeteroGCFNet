%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID3\';
all_files  = dir(fullfile(filepath,'*.json'));
l_file = length(all_files);

for ii = 1:l_file
    by_file(ii,1) = all_files(ii).bytes;
    name_file1(ii,1)= str2num(all_files(ii).name(1:end-25));
    ID3_data = jsonread(strcat(filepath,all_files(ii).name));
    ID3_breath(ii) = ID3_data.breath;
    ID3_heart_rate(ii) = ID3_data.heart_rate;
    ID3_totalMotion(ii) = ID3_data.totalMotion;
    ID3_opticalpower(:,ii) = ID3_data.opticalpower;
end
writematrix(ID3_breath,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID3breath.txt',WriteMode='overwrite');
writematrix(ID3_heart_rate,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID3heart.txt',WriteMode='overwrite');
writematrix(ID3_totalMotion,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID3motion.txt',WriteMode='overwrite');
writematrix(ID3_opticalpower,'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\ID3power.txt',WriteMode='overwrite');
% ID3_data = jsonread(strcat(filepath,all_files(1).name));



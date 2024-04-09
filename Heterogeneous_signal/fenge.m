%% 分割数据
clc;
clear all
fielepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\train\';
all_files  = dir(fullfile(fielepath,'*.json'));
l_file = length(all_files);
% by_file= all_files(:,4);

for ii = 1:l_file
    by_file(ii,1) = all_files(ii).bytes;
    name_file1(ii,1)= str2num(all_files(ii).name(1:end-25));
end
ID_member = tabulate(name_file1);
ID_member1 = [ ID_member(3,:); ID_member(8,:);ID_member(28,:);ID_member(30,:);ID_member(44,:)];
[num  kind] = hist(name_file1,[3 8 28 30 44]);

name_28 = all_files(1:num(3));
name_30 = all_files(num(3)+1:(num(3) + num(4)));
name_3 = all_files(num(3)+num(4)+1:(num(3) + num(4)+num(1)));
name_44 = all_files((num(3)+ num(4)+num(1)+1):(num(3) + num(4)+num(1)+num(5)));
name_8 = all_files((num(3) + num(4)+num(1)+num(5)+1):sum(num));

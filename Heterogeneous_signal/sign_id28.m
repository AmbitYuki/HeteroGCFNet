%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\';
ID28_breath = readmatrix(strcat(filepath,'ID28breath.txt'));
ID28_heart_rate = readmatrix(strcat(filepath,'ID28heart.txt'));
ID28_totalMotion = readmatrix(strcat(filepath,'ID28motion.txt'));
ID28_opticalpower = readmatrix(strcat(filepath,'ID28power.txt'));

figure(1)
plot(ID28_breath,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID28志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID28b = smoothdata(ID28_breath);
figure(2)
plot(ID28b,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID28志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');

figure(3)
plot(ID28_heart_rate,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID28志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID28h = smoothdata(ID28_heart_rate);
figure(4)
plot(ID28h,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID28志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


figure(5)
plot(ID28_totalMotion,'-',LineWidth=2);
xlabel('采样点');
ylabel('体动');
title('ID28志愿者体动')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID28t = smoothdata(ID28_totalMotion);
% figure(6)
% plot(ID28t,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('体动');
% title('ID28志愿者体动')
% box on
% set(gca,'fontsize',16,'fontweight','bold');
% 
% ID28o = ID28_opticalpower(:,);
figure(7)
subplot(2,1,1)
plot(ID28_opticalpower(:,10),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID28志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');

subplot(2,1,2)
plot(ID28_opticalpower(:,5000),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID28志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID28h = smoothdata(ID28_heart_rate);
% figure(8)
% plot(ID28h,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('心跳频率');
% title('ID28志愿者心跳频率')
% box on
% set(gca,'fontsize',16,'fontweight','bold');



%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\';
ID30_breath = readmatrix(strcat(filepath,'ID30breath.txt'));
ID30_heart_rate = readmatrix(strcat(filepath,'ID30heart.txt'));
ID30_totalMotion = readmatrix(strcat(filepath,'ID30motion.txt'));
ID30_opticalpower = readmatrix(strcat(filepath,'ID30power.txt'));

figure(1)
plot(ID30_breath,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID30志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID30b = smoothdata(ID30_breath);
figure(2)
plot(ID30b,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID30志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');

figure(3)
plot(ID30_heart_rate,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID30志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID30h = smoothdata(ID30_heart_rate);
figure(4)
plot(ID30h,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID30志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


figure(5)
plot(ID30_totalMotion,'-',LineWidth=2);
xlabel('采样点');
ylabel('体动');
title('ID30志愿者体动')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID30t = smoothdata(ID30_totalMotion);
% figure(6)
% plot(ID30t,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('体动');
% title('ID30志愿者体动')
% box on
% set(gca,'fontsize',16,'fontweight','bold');
% 
% ID30o = ID30_opticalpower(:,);
figure(7)
subplot(2,1,1)
plot(ID30_opticalpower(:,10),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID30志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');

subplot(2,1,2)
plot(ID30_opticalpower(:,5000),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID30志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID30h = smoothdata(ID30_heart_rate);
% figure(8)
% plot(ID30h,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('心跳频率');
% title('ID30志愿者心跳频率')
% box on
% set(gca,'fontsize',16,'fontweight','bold');



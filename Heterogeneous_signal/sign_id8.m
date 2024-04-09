%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\';
ID8_breath = readmatrix(strcat(filepath,'ID8breath.txt'));
ID8_heart_rate = readmatrix(strcat(filepath,'ID8heart.txt'));
ID8_totalMotion = readmatrix(strcat(filepath,'ID8motion.txt'));
ID8_opticalpower = readmatrix(strcat(filepath,'ID8power.txt'));

figure(1)
plot(ID8_breath,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID8志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID8b = smoothdata(ID8_breath);
figure(2)
plot(ID8b,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID8志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');

figure(3)
plot(ID8_heart_rate,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID8志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID8h = smoothdata(ID8_heart_rate);
figure(4)
plot(ID8h,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID8志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


figure(5)
plot(ID8_totalMotion,'-',LineWidth=2);
xlabel('采样点');
ylabel('体动');
title('ID8志愿者体动')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID8t = smoothdata(ID8_totalMotion);
% figure(6)
% plot(ID8t,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('体动');
% title('ID8志愿者体动')
% box on
% set(gca,'fontsize',16,'fontweight','bold');
% 
% ID8o = ID8_opticalpower(:,);
figure(7)
subplot(2,1,1)
plot(ID8_opticalpower(:,10),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID8志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');

subplot(2,1,2)
plot(ID8_opticalpower(:,5000),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID8志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID8h = smoothdata(ID8_heart_rate);
% figure(8)
% plot(ID8h,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('心跳频率');
% title('ID8志愿者心跳频率')
% box on
% set(gca,'fontsize',16,'fontweight','bold');



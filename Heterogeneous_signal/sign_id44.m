%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\';
ID44_breath = readmatrix(strcat(filepath,'ID44breath.txt'));
ID44_heart_rate = readmatrix(strcat(filepath,'ID44heart.txt'));
ID44_totalMotion = readmatrix(strcat(filepath,'ID44motion.txt'));
ID44_opticalpower = readmatrix(strcat(filepath,'ID44power.txt'));

figure(1)
plot(ID44_breath,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID44志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID44b = smoothdata(ID44_breath);
figure(2)
plot(ID44b,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID44志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');

figure(3)
plot(ID44_heart_rate,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID44志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID44h = smoothdata(ID44_heart_rate);
figure(4)
plot(ID44h,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID44志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


figure(5)
plot(ID44_totalMotion,'-',LineWidth=2);
xlabel('采样点');
ylabel('体动');
title('ID44志愿者体动')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID44t = smoothdata(ID44_totalMotion);
% figure(6)
% plot(ID44t,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('体动');
% title('ID44志愿者体动')
% box on
% set(gca,'fontsize',16,'fontweight','bold');
% 
% ID44o = ID44_opticalpower(:,);
figure(7)
subplot(2,1,1)
plot(ID44_opticalpower(:,10),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID44志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');

subplot(2,1,2)
plot(ID44_opticalpower(:,5000),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID44志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID44h = smoothdata(ID44_heart_rate);
% figure(8)
% plot(ID44h,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('心跳频率');
% title('ID44志愿者心跳频率')
% box on
% set(gca,'fontsize',16,'fontweight','bold');



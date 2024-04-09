%% 分割数据
clc;
clear all
filepath = 'I:\my_items\2023_06_06数学建模校赛\B题\B题\vital-signal-data\';
ID3_breath = readmatrix(strcat(filepath,'ID3breath.txt'));
ID3_heart_rate = readmatrix(strcat(filepath,'ID3heart.txt'));
ID3_totalMotion = readmatrix(strcat(filepath,'ID3motion.txt'));
ID3_opticalpower = readmatrix(strcat(filepath,'ID3power.txt'));

figure(1)
plot(ID3_breath,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID3志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID3b = smoothdata(ID3_breath);
figure(2)
plot(ID3b,'-',LineWidth=2);
xlabel('采样点');
ylabel('呼吸频率');
title('ID3志愿者呼吸频率')
box on
set(gca,'fontsize',16,'fontweight','bold');

figure(3)
plot(ID3_heart_rate,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID3志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


ID3h = smoothdata(ID3_heart_rate);
figure(4)
plot(ID3h,'-',LineWidth=2);
xlabel('采样点');
ylabel('心跳频率');
title('ID3志愿者心跳频率')
box on
set(gca,'fontsize',16,'fontweight','bold');


figure(5)
plot(ID3_totalMotion,'-',LineWidth=2);
xlabel('采样点');
ylabel('体动');
title('ID3志愿者体动')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID3t = smoothdata(ID3_totalMotion);
% figure(6)
% plot(ID3t,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('体动');
% title('ID3志愿者体动')
% box on
% set(gca,'fontsize',16,'fontweight','bold');
% 
% ID3o = ID3_opticalpower(:,);
figure(7)
subplot(2,1,1)
plot(ID3_opticalpower(:,10),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID3志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');

subplot(2,1,2)
plot(ID3_opticalpower(:,5000),'-',LineWidth=2);
xlabel('采样点');
ylabel('电子信号');
title('ID3志愿者电子信号')
box on
set(gca,'fontsize',16,'fontweight','bold');


% ID3h = smoothdata(ID3_heart_rate);
% figure(8)
% plot(ID3h,'-',LineWidth=2);
% xlabel('采样点');
% ylabel('心跳频率');
% title('ID3志愿者心跳频率')
% box on
% set(gca,'fontsize',16,'fontweight','bold');



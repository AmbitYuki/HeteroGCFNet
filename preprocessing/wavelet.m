function [Frec0,Fcoe]=wavelet_features(b,DAT)
% function [Frec_mean,Frec_std,Frec_ratio_delta,Frec_ratio_spindle,Frec_eng,Fcoe_mean,Fcoe_std,Fcoe_ratio_delta,Fcoe_ratio_spindle]=wavelet_rec_eng(b,dat)

% point{1}=1:6;%slow wave
% point{2}=1:14;%delta
% point{3}=15:28;%theta
% point{4}=29:47;%alpha
% point{5}=43:50;%sp
% point{6}=48:128;%lb
% 
% point1{1}=2:4;%slow wave
% point1{2}=5:8;%delta
% point1{3}=9:16;%theta
% point1{4}=17:25;%alpha
% point1{5}=26:35;%sp
% point1{6}=36:128;%lb

point2{1}=1:2;%slow wave
point2{2}=3:4;%delta
point2{3}=5:8;%theta
point2{4}=9:11;%alpha
point2{5}=12:16;%sp
point2{6}=17:128;%lb

Frec_00=zeros(size(DAT,1),size(DAT,2));
Fcoe_00=zeros(size(DAT,1),38);
for i=1:size(DAT,1)
    dat=DAT(i,:);
    wpt=wpdec(dat,b,'db5','shannon');
    node=get(wpt,'tn');
    nodes=wpfrqord(node);
    e=wenergy(wpt);
    e=e(nodes);
    Pw=e./sum(e);
    pe0=-sum(Pw.*log(Pw));
    % Node=node(nodes);
    for k=1:2^b
        F0=wprcoef(wpt,[b,k-1]);
        F1=wpcoef(wpt,[b,k-1]);
        Frec_00(k,:)=F0;
        Fcoe_00(k,:)=F1;
        E(k)=norm(F0,2).^2;
    end
    Frec_0=Frec_00(nodes,:);
    Fcoe_0=Fcoe_00(nodes,:);
    
%     [Frec00,mean1,med,std1,eng1,pe,ratio_sw,ratio_al,ratio_sp,ratio_be,E]=wptfea(Frec_0,Fcoe_0,e,point1);
%     Fcoe1.mean(i,:)=mean1;
%     Fcoe1.std(i,:)=std1;
%     Fcoe1.median(i,:)=med;
%     Fcoe1.eng(i,:)=eng1;
%     Fcoe1.pe_sh(i,:)=pe;
%     Fcoe1.pe_eng(i,:)=pe0;
%     Fcoe1.tatio_sw(i,:)=ratio_sw;
%     Fcoe1.ratio_al(i,:)=ratio_al;
%     Fcoe1.ratio_sp(i,:)=ratio_sp;
%     Fcoe1.ratio_be(i,:)=ratio_be;
%     Fcoe1.eng1(i,:)=E;
%     
%     Frec10.slow(i,:)=Frec00(1,:);
%     Frec10.delta(i,:)=Frec00(2,:);
%     Frec10.theta(i,:)=Frec00(3,:);
%     Frec10.spindle(i,:)=Frec00(4,:);
%     Frec10.alpha(i,:)=Frec00(5,:);
%     Frec10.beta(i,:)=Frec00(6,:);
%     clear Frec00 mean1 med std1 eng1 pe ratio_sw ratio_al ratio_sp ratio_be E

    [Frec00,mean1,med,std1,eng1,pe,ratio_sw,ratio_al,ratio_sp,ratio_be,E]=wptfea(Frec_0,Fcoe_0,e,point2);
    Fcoe.mean(i,:)=mean1;
    Fcoe.std(i,:)=std1;
    Fcoe.median(i,:)=med;
    Fcoe.eng(i,:)=eng1;
    Fcoe.pe_sh(i,:)=pe;
    Fcoe.pe_eng(i,:)=pe0;
    Fcoe.tatio_sw(i,:)=ratio_sw;
    Fcoe.ratio_al(i,:)=ratio_al;
    Fcoe.ratio_sp(i,:)=ratio_sp;
    Fcoe.ratio_be(i,:)=ratio_be;
    Fcoe.eng1(i,:)=E;
    
    Frec0.slow(i,:)=Frec00(1,:);
    Frec0.delta(i,:)=Frec00(2,:);
    Frec0.theta(i,:)=Frec00(3,:);
    Frec0.spindle(i,:)=Frec00(4,:);
    Frec0.alpha(i,:)=Frec00(5,:);
    Frec0.beta(i,:)=Frec00(6,:);
    clear Frec00 mean1 med std1 eng1 pe ratio_sw ratio_al ratio_sp ratio_be E
    % point{6}=48:76;%lb
    % point{7}=77:109;%hb
    % point{8}=110:128;%ga

%     clear Frec00 mean1 med std1 eng1 pe ratio_sw ratio_al ratio_sp ratio_be E


    clear wpt
end       
end

function [Frec00,mean1,med,std1,eng1,pe,ratio_sw,ratio_al,ratio_sp,ratio_be,E]=wptfea(Frec_0,Fcoe_0,e,point)
    for j=1:length(point)
        Frec00(j,:)=sum(Frec_0(point{j},:));
        Fcoe0(j,:)=sum(Fcoe_0(point{j},:));
        E(j)=sum(e(point{j}));
    end
    
    [a,~]=size(Fcoe0);

    mean1=mean(Fcoe0')';
    med=median(Fcoe0')';
    std1=std(Fcoe0')';
    %     pe_per1(j) = PermutationEntropy(Fcoe0(j,:) , a/8, 4, a/2);
    eng1 = sum(sqrt(Fcoe0.^2)')';

%     for j=1:a
%         mean1(j)=mean(Fcoe0(j,:));
%         med(j)=median(Fcoe0(j,:));
%         std1(j)=std(Fcoe0(j,:));
%         %     pe_per1(j) = PermutationEntropy(Fcoe0(j,:) , a/8, 4, a/2);
%         eng1(j) = sum(sqrt(Fcoe0(j,:).^2));
%     end
    pe1=abs(mean1)./sum(abs(mean1));
%     for j=1:a
%         pe1(j)=abs(mean1(j))/sum(abs(mean1));
%     end
    pe=-sum(pe1.*log(pe1));
    
    ratio_sw=ratio(1,mean1);
    ratio_al=ratio(4,mean1);
    ratio_sp=ratio(5,mean1);
    ratio_be=ratio(6,mean1);
    %%%
end

function ra=ratio(n,means)
m=setdiff(1:length(means),n);
for i=1:length(m)
    ra(i)=means(n)/means(m(i));
end
ra(i+1)=means(n)/sum(means);
end
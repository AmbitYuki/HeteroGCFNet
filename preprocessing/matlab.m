resamplerate=125;
fx00=0.3;%EEG EOG
fx1=35;
fx2=35;
fx01=10;%EMG下
fx3=resamplerate/2-2;%EMG上
hd=100;
n=50;

n=dir(objDir1);
%     fx11=2*fx1/hd;
%     fx22=2*fx2/hd;
%     fx33=2*fx3/hd;
%     fx44=2*fx4/hd;
%     window1=hamming(n+1);
%     b1=fir1(n,[fx11 fx22],window1);
%     b2=fir1(n,[fx11 fx33],window1);
%     b3=fir1(n,[fx11 fx44],window1);
[BT_eeg_B,BT_eeg_A]=filterdesign(fx00,fx1,resamplerate);
[BT_eog_B,BT_eog_A]=filterdesign(fx00,fx2,resamplerate);
[BT_emg_B,BT_emg_A]=filterdesign(fx01,fx3,resamplerate);

%%%stft参数
windows=hamming(128);
nooverlap=38;
nfft=128;

for ii=1:length(n)-2
    na0=n(ii+2).name;
    path=[objDir1,'\',na0,'\polysomnography\edfs'];
    path1=[objDir2,'\',na0,'\label'];
    % %     bgfile1 = [objDir,num2str(p(ii)),'\start_time.mat'];
    % %     load(bgfile1);
    N1=dir(objDir1);
    N2=dir(objDir2);
    for sub=1:length(N1)-2
        na=N1(sub+2).name;
        nb=N2(sub+2).name;
        bgfile1=[objDir1,'\',na];
        bgfile2=[objDir2,'\',nb];
        
        [head,data]=edfread(bgfile1);
        switch na0
            case 'ccshs'
                res1={'A2'};
                res2={'A1'};
                EEG1={'C3'};
                EEG1t={'C3A2'};
                EEG2={'C4'};
                EEG2t={'C4A1'};
                EOG1={'LOC'};
                EOG1t={'LOCA1','LOCA2'};
                EOG2={'ROC'};
                EOG2t={'ROCA1','ROCA2'};
                EMG1={'EMG1'};
                EMGt1={'EMG1-EMG2'};
                EMG2={'EMG2'};
                EMGt2={'EMG1-EMG2'};
                [eeg,eog,emg,sample]=labelpos(data,head,res1,res2,EEG1,EEG1t,EEG2,EEG2t,EOG1,EOG1t,EOG2,EOG2t,EMG1,EMGt1,EMG2,EMGt2);
            case 'cfs'
                res1={'M2'};
                res2={'M1'};
                EEG1={'C3'};
                EEG1t={'C3M2'};
                EEG2={'C4'};
                EEG2t={'C4M1'};
                EOG1={'LOC'};
                EOG1t={'LOCM1','LOCM2'};
                EOG2={'ROC'};
                EOG2t={'ROCM1','ROCM2'};
                EMG1={'EMG1'};
                EMGt1={'EMG1-EMG2'};
                EMG2={'EMG2'};
                EMGt2={'EMG1-EMG2'};
                [eeg,eog,emg,sample]=labelpos(data,head,res1,res2,EEG1,EEG1t,EEG2,EEG2t,EOG1,EOG1t,EOG2,EOG2t,EMG1,EMGt1,EMG2,EMGt2);
            case 'sof'
                res1={'A2'};
                res2={'A1'};
                EEG1={'C3'};
                EEG1t={'C3A2'};
                EEG2={'C4'};
                EEG2t={'C4A1'};
                EOG1={'LOC'};
                EOG1t={'LOCA1','LOCA2'};
                EOG2={'ROC'};
                EOG2t={'ROCA1','ROCA2'};
                EMG1={'LChin' 'EMGL'};
                EMGt1={'LChin-RChin' 'EMGL-EMGR'};
                EMG2={'RChin' 'EMGR'};
                EMGt2={'LChin-RChin' 'EMGL-EMGR'};
                [eeg,eog,emg,sample]=labelpos(data,head,res1,res2,EEG1,EEG1t,EEG2,EEG2t,EOG1,EOG1t,EOG2,EOG2t,EMG1,EMGt1,EMG2,EMGt2);
        end
        clear data
        load(bgfile2);
        %     if ii==1 || ii==3
        ll=length(label);%ll=length(label)-1;
        epochtime=30*resamplerate;
        %     else
        %         ll=floor((length(label))*2/3);%ll=floor((length(label))*2/3);
        %         epochtime=30*resamplerate;
        %     end
        
        %     lab=importdata(bgFile1);
        %     mark1=find(lab{2}==',',1);
        %     mark2=find(lab{end}==',',1);
        %     aa1=lab{2}(2:mark1-1);
        %     aa2=lab{end}(2:mark2-1);
        %     bb1=str2num(aa1);
        %     bb2=str2num(aa2);
        %     bb1=ceil(bb1*256);
        %     bb2=ceil(bb2*256);
        %     %%%
        
        [data_EEG,ratee]=getno0data(eeg,[1 2],sample(1),ll);
        [data_EOG,rateo]=getno0data(eog,[1 2],sample(3),ll);
        [data_EMG,ratem]=getno0data(emg,1,sample(5),ll);
        sample(1)=ratee;sample(3)=rateo;sample(5)=ratem;
        %     data_EEG=getno0data(data1,n1,sample(1));
        %     data_EOG=getno0data(data1,n3,sample(2));
        %     data_EMG=getno0data(data1,n2,sample(3));
%         if length(position1)==7
%             data_EMG=(data_EMG(1,:)+data_EMG(2,:))-data_EMG(3,:);
%         end
%         data_EEG=data_EEG(:,first_point(sub)*sample(1)/256:end);
%         data_EOG=data_EOG(:,first_point(sub)*sample(3)/256:end);
%         data_EMG=data_EMG(:,first_point(sub)*sample(5)/256:end);
        
%         unit=20;
%         l=length(data_EEG)/resamplerate/unit;
%         if l<ll
%             ll=l;
%             label=label(1:l);
%         end
        data_EEG=resample(data_EEG',resamplerate,sample(1));
        data_EOG=resample(data_EOG',resamplerate,sample(3));
        data_EMG=resample(data_EMG,resamplerate,sample(5));
        data_EEG=data_EEG';
        data_EOG=data_EOG';
        %     for iii=1:4
        %         if sum(ismember(0,data_EEG(iii,:)))==0
        %            dat(iii,:)=resample(data_EEG(iii,:),resamplerate,sample(iii));
        %         else
        %            x=find(data_EEG(iii,:)==0, 1 );
        %            data0=data_EEG(iii,1:x-1);
        %            dat(iii,:)=resample(data0,resamplerate,sample(iii));
        %         end
        %         clear data0
        %     end
        %     data_EMG=resample(data_EMG,resamplerate,sample(5));
        clear data1
        
        for jj=1:ll
            dat01=data_EEG(1,(jj-1)*epochtime+1:jj*epochtime);
            dat011=data_EEG(2,(jj-1)*epochtime+1:jj*epochtime);
            dat02=data_EOG(1,(jj-1)*epochtime+1:jj*epochtime);
            dat021=data_EOG(2,(jj-1)*epochtime+1:jj*epochtime);
            dat03=data_EMG((jj-1)*epochtime+1:jj*epochtime);
            
            % %         phy1=mean(label.physicalMax(position1(1:2)));
            % %         phy2=mean(label.physicalMax(position1(3:4)));
            % %         if length(position1)==6
            % %             phy3=mean(label.physicalMax(position1(5:6)));
            % %         else
            % %             phy3=label.physicalMax(position1(5));
            % %         end
            % %            if mean(abs(dat01))<0.5*phy1 & mean(abs(dat02))<0.5*phy2 & mean(abs(dat03))<0.5*phy3
            DAT(jj,1:epochtime) = filtfilt( BT_eeg_B , BT_eeg_A , dat01' );
            DAT(jj,epochtime+1:epochtime*2) = filtfilt( BT_eeg_B , BT_eeg_A , dat011' );
            DAT(jj,epochtime*2+1:epochtime*3) = filtfilt( BT_eog_B , BT_eog_A , dat02' );
            DAT(jj,epochtime*3+1:epochtime*4) = filtfilt( BT_eog_B , BT_eog_A , dat021' );
            DAT(jj,epochtime*4+1:epochtime*5) = filtfilt( BT_emg_B , BT_emg_A , dat03' );
            
            %                DAT(jj,1:3000)= filter(b1,1,dat01);
            %                DAT(jj,3001:6000)= filter(b1,1,dat011);
            %                DAT(jj,6001:9000) = filter(b2,1,dat02);
            %                DAT(jj,9001:12000) = filter(b2,1,dat021);
            %                DAT(jj,12001:15000) = filter(b3,1,dat03);
            % %                clear dat01
            % %                clear dat011
            % %                clear dat02
            % %                claer dat021
            % %                clear dat03
            % %            else
            % %                DAT(jj,:)=zeros(15000,1);
            % %            end
            %                for iii=1:5
            %                    s=spectrogram(DAT(jj,3000*(ii-1)+1:ii*3000),windows,nooverlap,nfft);
            %                    s=s(1:32,:);
            %                    S{iii}=s;
            %                end
            %     SS{jj}=S;
        end
        savename=[outputDir,'\',na0,'\data\',nb];
%         savename1=[outputDir1,num2str(p(ii)),'\',nb];
        %     savename1=[outputDir1,num2str(sub),'\',na];
        clear dat
        clear data1_EMG
        clear data1_EEG
        save(savename,'DAT');
%         save(savename1,'label')
        %     save(savename1,'SS');
        clear DAT position1
        clear mark1
        clear mark2
        clear aa1
        clear aa2
        clear SS
        clear S ll
    end
end

runtime=toc
function [BT_SW_B,BT_SW_A]=filterdesign(fx1,fx2,samplingrate)
SW = [fx1 fx2] / samplingrate * 2;
[BT_SW_B,BT_SW_A] = butter( 4 , SW , 'bandpass' ); 
end
function [dat,rate]=getno0data(data1,n,sam,len)
for i=1:length(n)
    mark=sam*len*30;
%     if data1(n(i),mark+1)==0
        dat(i,:)=data1(n(i),1:mark);
%     else
%         dat(i,:)=data1(n(i),1:mark);
%     end
end
%     mark=find(data1(n(i),:)==0);
%     if ~isempty(mark)
%         bb=min(mark);
%         dat1(i,:)=data1(n(i),1:bb-1);
%     else
%         dat1(i,:)=data1(n(i),:);
%     end
% end
if ceil(length(dat)/sam/30)~=len
    rate=floor(length(dat1)/len);
else
    rate=sam;
end
end

function [p,lp]=findlabelpos(head,h,h1)

f=strcmp(head.label,h);
p=find(f==1);
lp=length(p);

if lp>1
    a=strcmp(head.label,h1);
else
    a=strcmp(head.label,h);
end
% for i=1:length(a)
%     if ~isempty(a{i})
%         h(i)=a{i};
%     else
%         h(i)=0;
%     end
% end
p=find(a==1);
% lp=length(p);
% if lp>1
%     f=strcmp(heead.label,h1);
% end
% p=find(f==1);
end
function [eeg,eog,emg,sample]=labelpos(data,head,res1,res2,EEG1,EEG1t,EEG2,EEG2t,EOG1,EOG1t,EOG2,EOG2t,EMG1,EMGt1,EMG2,EMGt2)
for i=1:length(EEG1)
    [e01,le1]=findlabelpos(head,EEG1{i},EEG1t{i});
    [e02,le2]=findlabelpos(head,EEG2{i},EEG2t{i});
    if ~isempty(e01) && ~isempty(e02)
        e1=e01;
        e2=e02;
    end
end
for i=1:length(EOG1)
    [o01,lo1]=findlabelpos(head,EOG1{i},EOG1t{i});
    [o02,lo2]=findlabelpos(head,EOG2{i},EOG2t{i});
    if ~isempty(o01) && ~isempty(o02)
        o1=o01;
        o2=o02;
    end
end

[r1,lr1]=findlabelpos(head,res1{i},res1{i});
[r2,lr2]=findlabelpos(head,res2{i},res2{i});

for i=1:length(EMG1)
    [m01,lm1]=findlabelpos(head,EMG1{i},EMGt1{i});
    [m02,lm2]=findlabelpos(head,EMG2{i},EMGt2{i});
    if ~isempty(m01) && ~isempty(m02)
        m1=m01;
        m2=m02;
    end
end


if le1>1 || le2>1
    eeg(1,:)=data(e1,:);
    eeg(2,:)=data(e2,:);
else
    eeg(1,:)=data(e1,:)-data(r1,:);
    eeg(2,:)=data(e2,:)-data(r2,:);
end
if lo1>1 || lo2>1
    eog(1,:)=data(o1,:);
    eog(2,:)=data(o2,:);
else
    eog(1,:)=data(o1,:)-data(r1,:);
    eog(2,:)=data(o2,:)-data(r1,:);
end
if ~isempty(m1) && ~isempty(m2)
    m=max([m1,m2]);
    emg=data(m1,:)-data(m2,:);
else
    m=[m1,m2];
    m0=~isempty(m);
    m=m(m0==1);
    emg=data(m,:);
end
sample(1)=head.samples(e1);
sample(2)=head.samples(e2);
sample(3)=head.samples(o1);
sample(4)=head.samples(o2);
sample(5)=head.samples(m);
end
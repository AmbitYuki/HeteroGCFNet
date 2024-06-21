function [trainacc,traintime,xx,yy,par,con0,train_y0,tn] = multi_scale_bls4(train_x,train_y,test_x,test_y,s,C,h,f,f0,par,pare,mode,N1,N2,fe,fe1,con0,nfp,leng)
% Learning Process of the proposed broad learning system
%Input: 
%---train_x,test_x : the training data and learning data 
%---train_y,test_y : the label 
%---We: the randomly generated coefficients of feature nodes
%---wh:the randomly generated coefficients of enhancement nodes
%----s: the shrinkage parameter for enhancement nodes
%----C: the regularization parameter for sparse regualarization
%----N11: the number of feature nodes  per window
%----N2: the number of windows of feature nodes
%----st: the features that didn't changes  the st should be a array with the number of each kind of features in the position 
%%%%%%%%%%%%%%feature nodes%%%%%%%%%%%%%%
[beta11,ps,beta10,ps0,wh,l2,wh1,l21,beta2]=parmodi(par);
clear par pare
b=size(train_x,2);
len1=b-(size(beta11,1)-1);
con = ~isempty(beta2) && len1>0;
if mode==1
    con1 = con;
    con2 = ~con1;
    con0=[con1 con2];
else
   con1=con0(1);
   con2=con0(2);
end

tn=0;
train_y0=train_y;
[f,f0]=gefposi(fe,f,nfp,f0);
del=max(f{end-nfp-length(fe)});
% if con1
%     f1=gefposi(fe1,f1,[]);
% end
if mode==1
    [feas,feas11,beta10,ps0,beta11,ps,hn]=gainfn(train_x,N1,N2,f,f0,train_y,beta11,ps,beta10,ps0,del,con2);
    [T2,wh,l2,wh1,l21,feas]=gainen(feas,feas11,s,N1,h,wh,l2,wh1,l21,hn);
    clear train_x feas11
    [T3,beta]=calpinv(feas,T2,C);
    clear train_x feas T2
    [trainacc,traintime,beta2,xx,yy,train_y,tn]=training(T3,beta,train_y);
    clear train_x feas T2 T3
else
    %%%%%%%%%%%%%%%%%%%%%%Testing Process%%%%%%%%%%%%%%%%%%%
    xx=[];yy=[];trainacc=0;traintime=0;
    h1=length(leng)-1;
    for ii=1:h1
        test_x1=test_x(leng(ii)+1:leng(ii+1),:);
        test_y1=test_y(leng(ii)+1:leng(ii+1),:);
        [y11,y12,~,~,~,~,~]=gainfn(test_x1,N1,N2,f,f0,train_y,beta11,ps,beta10,ps0,del,0);
        [TT2,wh,~,~,~,y11]=gainen(y11,y12,s,N1,h,wh,l2,wh1,l21,0);
        TT3=[y11 TT2] ;
            
        [testacc,testtime,x,y]=testing_process(TT3,test_y1,beta2);
        trainacc=trainacc+testacc*size(test_x1,1)/size(test_x,1);
        traintime=traintime+testtime;
        xx=[xx;x];
        yy=[yy;y];
    end
    traintime=traintime/h1;
    disp(['testing accuracy is : ', num2str(trainacc* 100) , ' %'] );
end
[par]=parextract(beta11,ps,beta10,ps0,wh,l2,wh1,l21,beta2);

end

function [beta11,ps,beta10,ps0,wh,l2,wh1,l21,beta2]=parmodi(par)
if ~isempty(par)
%     beta=par.main_beta;
    beta2=par.main_beta2;
    beta11=par.fea_beta;
    ps=par.fea_ps;
    beta10=par.fea1_beta;
    ps0=par.fea1_ps;
    wh=par.en_wh;
    l2=par.en_l2;
    wh1=par.en1_wh;
    l21=par.en1_l2;
else
%     beta=[];
    beta2=[];
    beta11=[];
    ps=[];
    beta10=[];
    ps0=[];
    wh=[];
    l2=[];
    wh1=[];
    l21=[];
end

end

function [par]=parextract(beta11,ps,beta10,ps0,wh,l2,wh1,l21,beta2)
% par.main_beta=beta;
par.main_beta2=beta2;
par.fea_beta=beta11;
par.fea_ps=ps;
par.fea1_beta=beta10;
par.fea1_ps=ps0;
par.en_wh=wh;
par.en_l2=l2;
par.en1_wh=wh1;
par.en1_l2=l21;
end

function [feas,feas11,beta10,ps0,beta11,ps,h1]=gainfn(train_x,N1,N2,f,f0,train_y,beta11,ps,beta10,ps0,del,b)
h1 = b || size(train_x,2)-size(beta11,1)+1>0; 
if isempty(ps) || isempty(beta11)
    [feas11,beta10,ps0]=feature_node(train_x,N2,f,f0,train_y);
    [feas,beta11,ps]=feature_node(train_x,N1,{1:size(train_x,2)},f0,train_y);
elseif h1  %feature enhance
    [feas,beta11,ps]=feature_node1(train_x,N1,beta11,{1:size(train_x,2)},del);
    [feas11,beta10,ps0]=feature_node1(train_x,N2,beta10,f,del);
else
    feas=t_fnodes(train_x,N1,beta11,ps,{1:size(train_x,2)});
    feas11=t_fnodes(train_x,N2,beta10,ps0,f);
end
% feas=[feas feas11];
end

function [T2,wh,l2,wh1,l21,feas]=gainen(feas,feas11,s,N1,h,wh,l2,wh1,l21,b)
if isempty(wh) || b
    [wh,l2,T2]=tr_en(feas,s,N1,h);
    feas=[feas feas11];
    [wh1,l21,T21]=tr_en(feas,s,N1,h);
else
    T2=te_en(feas,N1,wh,l2,h);
    feas=[feas feas11];
    T21=te_en(feas,N1,wh1,l21,h);
end
T2=[T2 T21];
end

function [Y,beta,ps]=feature_node(train_x,N1,f,f0,train_y)
tic
train_yy = result(train_y);
f1=length(f);
N2=sum(N1)*f1;
H1 = [train_x .1 * ones(size(train_x,1),1)];Y=zeros(size(train_x,1),N2);
l01=1;l02=0;m1=1;m2=0;
% mm=ones(1,length(train_x));

for i=1:length(N1)
%     if i>1
%         s=randperm(f1);
%        f=f(s); 
%     end
    le=N1(i);l02=l02+le;
    l11=1;l21=0;
    for j=1:f1
        l21=l21+length(f{j})+1;
%         mm=ones(f(j)+1,1);
%         hh=randperm(f(j)+1);
%         mm(hh(1:floor(length(hh)/10)))=1;
        mm=ones(size(train_x,1),1);
        hh=[];
        for kk=1:5
            h=find(train_yy==kk);
            h1=randperm(length(h));
            h1=h1(1:floor(length(h1)/5));
            hh=[hh h1];
        end
%         if length(mm)>150000
%             mm(hh)=0;
%         else
            mm(hh)=1;% sample drop out
%         end
        
        if f1~=1
            H1 = [train_x(:,f{j}) .1 * ones(size(train_x,1),1)];
        end
        if ismember(j,f0) %|| j>63
            we=2*rand(size(H1,2),le);
        else
            we=2*rand(size(H1,2),le)-1;
        end
        We{j}=we;
%         A1 = H1 * (we .* mm);%A1 = mapminmax(A1);
%         %%%%%
        if f1==1
            A1=H1.*mm*we;
        elseif j==1 || mod(j,5)==0
            A1=H1.*mm*we;
        else
            A1=H1.*mm*we+A1*we(1);%recurrte BLS（use the output of last kind of input） just work to local feature node
        end
%         A1=zscore(A1')';
        beta1  =  sparse_bls(A1,H1,1e-3,20)';
        beta11(l11:l21,:)=beta1;
        T1 = H1 * beta1;
%         fprintf(1,'Feature nodes in window %f: Max Val of Output %f Min Val %f\n',i,max(T1(:)),min(T1(:)));
        
        [T1,ps1]  =  mapminmax(T1',0,1);T1 = T1';
        ps0(j)=ps1;
        y(:,(j-1)*N1(i)+1:j*N1(i))=T1;
        l11=l11+length(f{j})+1;
    end
    
    m2=m2+N1(i)*f1;
    Y(:,m1:m2)=y;
    WE{i}=We;
    beta(:,l01:l02)=beta11;
    ps((i-1)*f1+1:i*f1)=ps0;
    l01=l01+le;m1=m1+N1(i)*f1;
    clear We beta11 ps0 y
end
end

% function [y1,beta10,ps0]=feature_node1(train_x,f)
% l1=1;l2=0;
% for i=1:length(f)
%     le=f(i);
%     l2=l2+le;
%     ww=2*rand(le,1)-1;
%     Ww{i}=ww;
%     y0=train_x(:,l1:l2);
%     y=y0*ww;
%     y=zscore(y')';
%     
%     beta1  =  sparse_bls(y,y0,1e-3,20)';
%     beta10(:,l1:l2)=beta1';
%     T1 = y0 * beta1;
%     [T1,ps1]  =  mapminmax(T1',0,1);T1 = T1';
%     ps0(i)=ps1;
%     y1(:,i)=T1;
%     
%     l1=l1+le;
% end
% end

function [wh,l2,T2]=enhance_node(y,s,N1)
H2 = [y .1 * ones(size(y,1),1)];
N2 = size(y,2);
T2 = zeros(size(y,1),sum(N1));
l01=1;l02=0;
for i=1:length(N1)
    le=N1(i);l02=l02+le;
    wh0=orth(2*rand(N2+1,N1(i))-1);
    T20=H2 * wh0;
    l20 = max(max(T20));
    l20 = s/l20;
    T20 = tansig(T20 * l20);
    T2(:,l01:l02)=T20;
    wh(:,l01:l02)=wh0;
    l2(i)=l20;
    l01=l01+le;
end
clear N
end

function [T3,beta]=calpinv(y,T2,C)
T3=[y T2];
clear y T2
beta = (T3'  *  T3+eye(size(T3',1)) * (C)) \ ( T3');
end


function [TrainingAccuracy,Training_time,beta2,xx,yy,train_y,tn]=training(T3,beta,train_y)
tic
train_yy = result(train_y);
beta2 = beta*train_y;
xx = T3 * beta2;
yy = result(xx);
ac=length(find(yy == train_yy))/size(train_yy,1);
TrainingAccuracy = ac;
tn=length(ac);
Training_time = toc;
disp('Training has been finished!');
disp(['The Total Training Time is : ', num2str(Training_time), ' seconds' ]);
disp(['Training Accuracy is : ', num2str(TrainingAccuracy * 100), ' %' ]);
end

function [Y,beta1s,ps]=feature_node1(test_x,N1,beta,f,del)
tic
f1=length(f);
N2=sum(N1)*f1;
H1 = [test_x .1 * ones(size(test_x,1),1)];Y=zeros(size(test_x,1),N2);
l01=1;l02=0;m1=1;m2=0;
for i=1:length(f)
    
end
% mm=ones(1,length(train_x));
for i=1:length(N1)

    le=N1(i);l02=l02+le;
    l11=1;l21=0;
    beta11=beta(:,l01:l02);
    for j=1:f1

        l21=l21+length(f{j})+1;
%         mm=ones(f(j)+1,1);
%         hh=randperm(f(j)+1);
%         mm(hh(1:floor(length(hh)/10)))=1;
        
        if f1~=1
            H1 = [test_x(:,f{j}) .1 * ones(size(test_x,1),1)];
        end
        
        if f1~=1
            if isempty(find(f{j}>del, 1))%trained features
                beta1=beta11(l11:l21,:);
            else%new features
                we=2*rand(size(H1,2),le)-1;
                We{j}=we;
                A1 = H1 * we ;%A1 = mapminmax(A1);
                A1=zscore(A1')';
                beta1  =  sparse_bls(A1,H1,1e-3,20)';
            end
        else
            we=2*rand(size(H1,2),le);
            We{j}=we;
            A1 = H1 * we ;%A1 = mapminmax(A1);
            A1=zscore(A1')';
            beta1  =  sparse_bls(A1,H1,1e-3,20)';
            beta1(1:del,:) = beta11(1:del,:);%the trained parameter change the new parameter
        end
        T1 = H1 * beta1;
        beta11(l11:l21,:)=beta1;
        [T1,ps1]  =  mapminmax(T1',0,1);T1 = T1';
        ps0(j)=ps1;
        y(:,(j-1)*N1(i)+1:j*N1(i))=T1;
        l11=l11+length(f{j})+1;
    end
    
    m2=m2+N1(i)*f1;
    Y(:,m1:m2)=y;
    ps((i-1)*f1+1:i*f1)=ps0;
    beta1s(:,l01:l02)=beta11;
    l01=l01+le;m1=m1+N1(i)*f1;
    clear We beta11 ps0 y
end
end


function Y=t_fnodes(test_x,N1,beta,ps,f)
tic
f1=length(f);
N2=sum(N1)*f1;
H1 = [test_x .1 * ones(size(test_x,1),1)];Y=zeros(size(test_x,1),N2);
l01=1;l02=0;m1=1;m2=0;
% mm=ones(1,length(train_x));

for i=1:length(N1)

    le=N1(i);l02=l02+le;
    l11=1;l21=0;
    beta11=beta(:,l01:l02);
    ps0=ps((i-1)*f1+1:i*f1);
    for j=1:f1

        l21=l21+length(f{j})+1;
%         mm=ones(f(j)+1,1);
%         hh=randperm(f(j)+1);
%         mm(hh(1:floor(length(hh)/10)))=1;
        
        if f1~=1
            H1 = [test_x(:,f{j}) .1 * ones(size(test_x,1),1)];
        end

%         we=2*rand(size(H1,2),le)-1;
%         We{j}=we;
%         A1 = H1 * (we .* mm);%A1 = mapminmax(A1);
%         A1=zscore(A1')';
%         beta1  =  sparse_bls(A1,H1,1e-3,20)';
        beta1=beta11(l11:l21,:);
        T1 = H1 * beta1;
%         fprintf(1,'Feature nodes in window %f: Max Val of Output %f Min Val %f\n',i,max(T1(:)),min(T1(:)));
        
%         [T1,ps1]  =  mapminmax(T1',0,1);T1 = T1';
        ps1=ps0(j);
        T1  =  mapminmax('apply',T1',ps1)';
        y(:,(j-1)*N1(i)+1:j*N1(i))=T1;
        l11=l11+length(f{j})+1;
    end
    
    m2=m2+N1(i)*f1;
    Y(:,m1:m2)=y;
    l01=l01+le;m1=m1+N1(i)*f1;
    clear We beta11 ps0 y
end



% f1=length(f);
% N2=length(N1)*f1;
% l01=1;l02=0;
% % test_x = zscore(test_x')';
% if f1==1
%     HH1 = [test_x .1 * ones(size(test_x,1),1)];
% end
% %clear test_x;
% yy1=zeros(size(test_x,1),N2);
% for i=1:length(N1)
%     for j=1:length(f)
%         le=N1(i);l02=l02+le;
%         beta1=beta11(:,l01:l02);ps1=ps(i);
%         TT1 = HH1 * beta1;
%         TT1  =  mapminmax('apply',TT1',ps1)';
%         
%         clear beta1; clear ps1;
%         %yy1=[yy1 TT1];
%         yy1(:,l01:l02)=TT1;
%         l01=l01+le;
%     end
% end
% clear TT1;clear HH1;
end

function TT2=t_enodes(yy1,N1,wh,l2)
HH2 = [yy1 .1 * ones(size(yy1,1),1)];
l01=1;l02=0;
% HH2=gpuArray(HH2);
% wh=gpuArray(wh);
% l2=gpuArray(l2);
% N1=gpuArray(N1);
for i=1:length(N1)
    le=N1(i);l02=l02+le;
    TT20 = HH2 * wh(:,l01:l02) * l2(i);
    TT20 = tansig(TT20);
    TT2(:,l01:l02)=TT20;
    l01=l01+le;
end
% TT2=gather(TT2);
end

function [TestingAccuracy,Testing_time,x,y]=testing_process(TT3,test_y,beta) 
x = TT3 * beta;
y = result(x);
test_yy = result(test_y);
TestingAccuracy = length(find(y == test_yy))/size(test_yy,1);
clear TT3;
Testing_time = toc;
% disp('Testing has been finished!');
% disp(['The Total Testing Time is : ', num2str(Testing_time), ' seconds' ]);
% disp(['Testing Accuracy is : ', num2str(TestingAccuracy * 100), ' %' ]);
end

function [x,beta1,ps]=orix(x,ps,beta1)
H1 = [x .1 * ones(size(x,1),1)];
if isempty(beta1)
    beta1  =  sparse_bls(H1,H1,1e-3,20)';
    T=H1*beta1;
    [T,ps] = mapminmax(T');T=T';
else
    T=H1*beta1;
    T  =  mapminmax('apply',T',ps)';
end
end

function [wh,l2,T2]=tr_en(feas,s,N1,h)
T2=[];
for i=1:h
    [wh1,l21,T21]=enhance_node(feas,s,N1);
    wh(:,:,i)=wh1;
    l2(:,i)=l21;
    T2=[T2 T21];
end
% wh=single(wh);
end
function TT2=te_en(y11,N1,wh,l2,h)

TT2=[];
for i=1:h
    wh1=squeeze(wh(:,:,i));
    l21=l2(:,i);
    TT21=t_enodes(y11,N1,wh1,l21);
    TT2=[TT2 TT21];
end
end
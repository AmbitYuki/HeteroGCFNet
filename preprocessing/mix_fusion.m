function [data1]=fixdata(data,h0,s,mark)
m=size(data,2);
l1=1;l2=0;data1=[];
% if sum(s)~=0
for i=1:length(h0)
    le=h0(i);
    l2=le;
    dat=data(l1:l2,:);
    data1=[data1;dat];
    if s(i)~=0
        dat1=repmat(data(h0(i),:),[s(i),1]);
        if m~=1
            dat1(:,mark)=dat1(:,mark).*(randn(s(i),length(mark))/10+1);
            dat1(:,end)=1;
        end
    else
        dat1=[];
    end
    data1=[data1;dat1];
    l1=1+le;
end
data1=[data1;data(l2+1:end,:)];
% else
% data1=data;
% end
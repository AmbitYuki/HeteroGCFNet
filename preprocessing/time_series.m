function timefeatures=time_features(DAT,type)
switch type
    case 'EEG'
        window=size(DAT,2)/6;
        overlap=0;
        max_n=8192;
    case 'EOG'
        window=size(DAT,2)/6;
        overlap=0;
        max_n=8192;
    case 'EMG'
        window=size(DAT,2)/6;
        overlap=0;
        max_n=8192;
end

[t,s]=size(DAT);
if s>=window*2
    timepiece=(s-overlap)/(window-overlap);
else
    timepiece=1;
end
% zc=zeros(t,1);pe1=zeros(t,1);
for i=1:timepiece    
    dat=DAT(:,(i-1)*window-(i-1)*overlap+1:i*window-(i-1)*overlap);
    means=mean(dat')';
    stds=std(dat')';
    Eng=sqrt(sum(dat'.^2))';
    sk=skewness(dat')';
    ku=kurtosis(dat')';
    med = median(dat')';
    lrssv=log10(sqrt(sum((diff(dat').^2))))';
    pw=abs(dat)'./sum(abs(dat)');
    pe = -sum(pw.*log(pw))';
    z0=dat>0;
    z=diff(z0')';
    for j=1:t
        zc(j,:)=length(union(find(z(j,:)==1),find(z(j,:)==-1)))/window;
        pe10 = PermutationEntropy( dat(j,:) , floor(window/8), 4, floor(window/2));
        pe1(j,:)=mean(pe10')'; 
    end
    
    
    timefeatures.means(:,i)=means;
    timefeatures.stds(:,i)=stds;
    timefeatures.ku(:,i)=ku;
    timefeatures.sk(:,i)=sk;
    timefeatures.Eng(:,i)=Eng;
    timefeatures.Pe(:,i)=pe;
    timefeatures.Z(:,i)=zc;
    timefeatures.median(:,i)=med;
    timefeatures.Pe1(:,i)=pe1;
    timefeatures.LRSSV(:,i)=lrssv;
end
function [C31,C41,EOG1,EMG1]=feature_enhance(C3,C4,EOG,EMG)
[C3_1,C3_en]=coess(C3(:,1:62));
[C4_1,C4_en]=coess(C4(:,1:62));
C3_2=tfss(C3(:,63:end),'EEG2');
C4_2=tfss(C4(:,63:end),'EEG2');

[C3_1]=deleteoutliners(C3_1,0.1);
[C3_2]=deleteoutliners(C3_2,0.1);
[C4_1]=deleteoutliners(C4_1,0.1);
[C4_2]=deleteoutliners(C4_2,0.1);

C3_1=zscore(C3_1);
C4_1=zscore(C4_1);
C3_2=zscore(C3_2);
C4_2=zscore(C4_2);
C31=[C3_1 C3_en C3_2];
C41=[C4_1 C4_en C4_2];
% C31=noz(C31);
% C41=noz(C41);

EMG1=tfss(EMG,'EMG');
EOG1_1=tfss(EOG(:,1:54),'EOG');%1:16
EOG1_2=tfss(EOG(:,55:108),'EOG');%17:32
[EMG1]=deleteoutliners(EMG1,0.1);
[EOG1_1]=deleteoutliners(EOG1_1,0.1);
[EOG1_2]=deleteoutliners(EOG1_2,0.1);
EMG1=zscore(EMG1);
EOG1_1=zscore(EOG1_1);
EOG1_2=zscore(EOG1_2);
% EOG1=(EOG1_1+EOG1_2)/2;
EOG1=[EOG1_1 EOG1_2];
% EOG1=noz(EOG1);
% C31=mapminmax(C31);
% C41=mapminmax(C41);
% EMG1=mapminmax(EMG1);
% EOG1=mapminmax(EOG1);
end

function [d1,entr]=coess(d)
n=6;
for i=1:4%8
    l0=2*(i>4);
    mi(:,i)=mean(d(:,(i-1)*n+1+l0:i*n+l0)')';
    si(:,i)=std(d(:,(i-1)*n+1+l0:i*n+l0)')';
%     sk(:,i)=skewness(d(:,(i-1)*n+1+l0:i*n+l0)')'; 
%     ku(:,i)=kurtosis(d(:,(i-1)*n+1+l0:i*n+l0)')';
    if i==3
        for j=1:n-3
            en(:,j)=d(:,(i-1)*n+1+l0+(j-1)).*log( abs((d(:,(i-1)*n+1+l0+(j-1))))  )  .* (d(:,(i-1)*n+1+l0+(j-1))./abs(d(:,(i-1)*n+1+l0+(j-1))));
            for k=1:n-1
                nn=setdiff(1:n,k);
                en10(:,k)=d(:,(i-1)*n+1+l0+(j-1)).*log( abs(d(:,(i-1)*n+1+l0+(j-1)) ./ d(:,(i-1)*n+1+l0+nn(k))) ) .* (d(:,(i-1)*n+1+l0+(j-1))./abs(d(:,(i-1)*n+1+l0+(j-1))));%kl…¢∂»
                
            end
            en1(:,(j-1)*k+1:j*k)=en10;%mapminmax(en10);%(en10'./max(en10'))';
        end
%         en=mapminmax(en);
%         en1=mapminmax(en1);
        entr=[en en1];
        entr=zscore(entr);
    end
end
% d1=[mi si sk ku];
d1=[mi si];
end


function d1=tfss(d,h)
switch h
    case 'EEG'
        n=6;
    case 'EEG2'
        n=6;
    case 'EOG'
        n=6;%2;
    case 'EMG'
        n=6;%5;
end
for i=1:8
    mi(:,i)=mean(d(:,(i-1)*n+1:i*n)')';
    si(:,i)=std(d(:,(i-1)*n+1:i*n)')';
%     sk(:,i)=skewness(d(:,(i-1)*n+1:i*n)')';
%     ku(:,i)=kurtosis(d(:,(i-1)*n+1:i*n)')';
end
% d1=[mi si sk ku];
d1=[mi si];
end

function C3=noz(C3)
l=find(sum(C3)==0);
m=setdiff(1:size(C3,2),l);
C3=C3(:,m);
end
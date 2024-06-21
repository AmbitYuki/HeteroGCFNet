function [C3,C4,EMG,EOG,label,len]=generate_data1(name)
load(name)
if size(label,1)<size(label,2)
   label=label'; 
end
mark=find(label~=5);
label=label(mark);
len=length(mark);

% if i==2
%     l=0.1;
% else
%     l=1;
% end
C3=eegmat(C3coe,C3tfs);
C4=eegmat(C4coe,C4tfs);
% F4=eegmat(F4coe,F4tfs);
% O2=eegmat(O2coe,O2tfs);
EMG=tfsmat1(EMGtfs);
EOGL=tfsmat1(EOGLtfs);
EOGR=tfsmat1(EOGRtfs);

C3=C3(mark,:);
C4=C4(mark,:);
% F4=F4(mark,:);
% O2=O2(mark,:);
EMG=EMG(mark,:);
% EMG=deleteoutliner(EMG,10,'EMG');
EOGL=EOGL(mark,:);
% EOGL=deleteoutliner(EOGL,10,'EOG');
EOGR=EOGR(mark,:);
% EOGR=deleteoutliner(EOGR,10,'EOG');
EOGcoff=EOGcoff(mark,:);
% EOGcoff=deleteoutliner(EOGcoff,10,'EOGcoff');
EOG=[EOGL EOGR EOGcoff];
end
% if copy 1 3 4  fea=fea*10  eng=eng*100

function C3=eegmat(C3coe,C3tfs)
C31=coemat(C3coe);
% C31=deleteoutliner(C31,10,'EEGcoe');
C32=tfsmat(C3tfs);
% C32=deleteoutliner(C32,10,'EEGtfs');
C3=[C31 C32];
end
function C31=coemat(C3coe)
C31=[C3coe.mean C3coe.std C3coe.median C3coe.eng C3coe.pe_sh C3coe.pe_eng abs(C3coe.tatio_sw) abs(C3coe.ratio_al) abs(C3coe.ratio_sp) abs(C3coe.ratio_be)];
% C31=[C3coe.mean C3coe.std C3coe.median C3coe.eng C3coe.pe_sh C3coe.pe_eng C3coe.tatio_sw C3coe.ratio_al C3coe.ratio_sp C3coe.ratio_be];
end
function C32=tfsmat(C3tfs)
C32mean=[]; C32std=[];  C32ku=[]; C32sk=[]; C32eng=[]; C32pe=[]; C32zc=[]; C32median=[]; C32fra=[];C32lrssv=[];
for i=1:6
    C32mean=[C32mean sum(C3tfs{i}.means')'];
    C32std=[C32std sum(C3tfs{i}.stds')'];
    C32ku=[C32ku sum(C3tfs{i}.ku')'];
    C32sk=[C32sk sum(C3tfs{i}.sk')'];
    C32eng=[C32eng mean(C3tfs{i}.Eng')'];
    C32pe=[C32pe sum(C3tfs{i}.Pe')'];
    C32zc=[C32zc mean(C3tfs{i}.Z')'];
    C32median=[C32median sum(C3tfs{i}.median')'];
    C32lrssv=[C32lrssv sum(C3tfs{i}.LRSSV')'];
%     C32fra=[C32fra C3tfs{i}.Fra];
end
% C32=[C32mean C32std  C32ku C32sk C32eng C32pe C32zc C32median C32fra];
C32=[C32mean C32std  C32ku C32sk C32eng C32pe C32zc C32median C32lrssv];
end
function C32=tfsmat1(C3tfs)
    C32mean=C3tfs.means;
    C32std=C3tfs.stds;
    C32ku=C3tfs.ku;
    C32sk=C3tfs.sk;
    C32eng=C3tfs.Eng;
    C32pe=C3tfs.Pe;
    C32zc=C3tfs.Z;
    C32median=C3tfs.median;
    C32lrssv=C3tfs.LRSSV;
%     C32fra=C3tfs.Fra;
%     C32=[C32mean C32std  C32ku C32sk C32eng C32pe C32zc C32median C32fra];
      C32=[C32mean C32std  C32ku C32sk C32eng C32pe C32zc C32median C32lrssv];
end
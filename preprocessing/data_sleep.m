function [leng,lengo]=sleepEDFleng(leng)
if length(leng)==39
    [leng,lengo]=len20(leng);
elseif length(leng)==153
    leng0=leng(1:39);
    leng1=leng(40:end);
    [leng0,lengo1]=len20(leng0);
    [leng1,lengo2]=len78(leng1);
    leng=[leng0 leng1];
    lengo=[lengo1 lengo2];
else
    for i=1:22
        leng1(i)=leng((i-1)*2+1)+leng(i*2) ;
        lengo{i}=[leng((i-1)*2+1) leng(i*2)];
    end
    leng=leng1;
end

end

function [leng,le]=len20(leng1)

    for i=1:13
        leng01(i)=leng1((i-1)*2+1)+leng1(i*2);
        le{i}=[leng1((i-1)*2+1) leng1(i*2)];
    end
    for i=1:6
        leng02(i)=leng1((i-1)*2+1+27)+leng1(i*2+27);
        le{i+14}=[leng1((i-1)*2+1+27) leng1(i*2+27)];
    end
    leng=[leng01 leng1(27) leng02];
    le{14}=leng1(27);
end
function [leng,le]=len78(leng1)
    for i=1:16
        leng01(i)=leng1((i-1)*2+1)+leng1(i*2);
        le{i}=[leng1((i-1)*2+1) leng1(i*2)];
    end
    for i=1:14
        leng02(i)=leng1((i-1)*2+1+33)+leng1(i*2+33);
        le{i+17}=[leng1((i-1)*2+1+33) leng1(i*2+33)];
    end
    for i=1:26
        leng03(i)=leng1((i-1)*2+1+62)+leng1(i*2+62);
        le{i+32}=[leng1((i-1)*2+1+62) leng1(i*2+62)];
    end
    leng=[leng01 leng1(33) leng02 leng1(62) leng03];
    le{17}=leng1(33);
    le{32}=leng1(62);
end
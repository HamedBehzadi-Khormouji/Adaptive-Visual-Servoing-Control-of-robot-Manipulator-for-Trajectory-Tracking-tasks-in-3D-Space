function [points] = getPoints(BW)
[r,c]=size(BW);
points=[];
index=1;
for i=1:c
    for j=1:r
        if BW(j,i)==1
            points(index,1)=j;
            points(index,2)=i;
            index=index+1;
            break;
        end
    end
end
end
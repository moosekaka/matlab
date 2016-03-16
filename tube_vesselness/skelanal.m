%clear all
[a,b]=kmean(test);
b=bwmorph(b,'spur',10);

%find vessel networks
c=bwconncomp(b);
d=regionprops(c);

%created cell array for each vessel network
for i=1:c.NumObjects
x{i}=cat(1,c.PixelIdxList{i});
end
%length of each vessel network
for i=1:26
l(i)=length(x{i});
end

[l1,l2]=sort(l);
%specify minimum length of vessels in pixels
l3=l2(l1>15);
e=b;e(:)=0;
for i=1:length(l3)
    e(x{l3(i)})=1;
end
temp=b;temp(:)=0;
%vessel network ID
vessel=cell(1,length(l3));

%perform quantification on the processed vessel networks
for i=1:length(l3)
    temp(:)=0;
    temp(x{l3(i)})=1;
    vessel{i}=temp;
    numbranch(i)=sum(sum(bwmorph(vessel{i},'branchpoints')));
    vesslength(i)=sum(sum(vessel{i}));
    avgvess(i)=vesslength(i)/numbranch(i);
end

    
    
    
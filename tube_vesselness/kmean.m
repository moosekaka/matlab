function [Label,z]=kmean(data) 
IDX = kmeans(double(data(:)),2); % seek '2' classes.
Label = reshape(IDX,size(data));
figure; imagesc(Label);  axis off; axis image;
title('Distribution of the 2 classes');
colormap(gray); colorbar;

Label=(Label-1);
%se=strel('square',7);
%z=imopen(Label,se);
figure
z=bwmorph(Label,'skel',Inf);
imshow(z);
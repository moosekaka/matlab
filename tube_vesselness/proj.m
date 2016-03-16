clear all
close all
I=imread('pic3');
I=double(I);
tic
sigma=11;
%I2=im2bw(I,0);
I2=double(I);
h=fspecial('gaussian',15*sigma,sigma);
I2=imfilter(I2,h,'symmetric','conv');
figure;imagesc(I2);colormap(gray);
%imwrite(I2,'pic2','tif');
%figure;hist(I2(:),100)

hess=cell(640);

%Construct the Hessian matrix
for i=2:639
    for j=2:639
        temp=I2(i,j);
        ixx=I2(i+1,j)-2*temp+I2(i-1,j);
        iyy=I2(i,j+1)-2*temp+I2(i,j-1);
        ixy=(I2(i+1,j+1)+I2(i-1,j-1)-I2(i+1,j-1)-I2(i-1,j+1))/4;
        hess{i,j}=(sigma*sigma).*[ixx,ixy;ixy,iyy];
    end
end

eigenvals=cell(640);
eigenvec=cell(640);
for i=2:639
    for j=2:639
        [eigenvec{i,j},eigenvals{i,j}]=eig(hess{i,j});
        eigenvals{i,j}=diag(eigenvals{i,j});
    end
end

tubes=zeros(640);
a=0;b=0;temp=0;
%test eigenvalues to select pixels that are likely in a tubefor i=2:639
for i=2:639
    for j=2:639
        %order the eigenvals by absolute value
        [a,b]=sort(abs(eigenvals{i,j}));
        %var to 'remember' the original sign of the eigenvals
        temp=eigenvals{i,j};
        %the larger (by absolute val) eigenval must <<0,otherwise intensity
        %is changing from dark to bright (which is opp to a tube with
        %bright pixels and dark backgroun
        if temp(b(2))>=0
            tubes(i,j)=0;
        else
            %blobness measure
            %test(i,j)=exp(-abs((a(1)/a(2))));
            %simple measure
            tubes(i,j)=a(2);
        end
    end
end
toc
figure;imagesc(tubes);colormap(gray);

[bw,skeleton]=kmean(tubes);



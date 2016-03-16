%%FIND GRADIENT IMAGE FOR INPUT, THRESHOLD, AND FIND OBJECT OUTLINES

%For the image 'input', this calculates the gradient image 'Imag', sets a
%threshold to make a binary image, fills in the interior of continuous 
%boundaries, and filters out spots less than 10 pixels in diameter.

%adjustable variable
% Imag-threshold after calculating image gradient

hx=fspecial('Prewitt');
hy=hx';

Ix=imfilter(inputimage,hx,'replicate');
Iy=imfilter(inputimage,hy,'replicate');
Ixy=immultiply(Ix,Ix)+immultiply(Iy,Iy);
Imag=sqrt(Ixy);

[Imaghist,x]=imhist(Imag);

%Imagthres is thresholded gradient image at some value
beta=input('enter image threshold :');
ds=input('enter strel disk size :');
Imagthresh=Imag>beta;
Ifill=imfill(Imagthresh,'holes');
se=strel('disk',ds);
Ierode=imerode(Ifill,se);
Idilate=imdilate(Ierode,se);
Iper=bwperim(Idilate);

% figure,imshow(Idilate);hold on
figure,h=imshow(inputimage,[]);hold on
set(h,'AlphaData',0.4)
clear hx hy Ifill Ierode Ixy Imagthresh;
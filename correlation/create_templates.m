%CREATE TEMPLATES AND TEMPLATES2
clc;
close all;
clear all;
 FDetect = vision.CascadeObjectDetector;
 image=[];
z=0;
for i=1:305; % we have 16 images we have in or folder
    images ='C:\matlab\pixort\correlation\emotion';
    jpgfiles=dir(fullfile(images,'\*.jpg*'));

    im1=jpgfiles(i).name;
   I=imread(fullfile(images,im1));
% BB = step(FDetect,I);
% tf = isempty(BB);
%  [L M]=size(BB);
%  if(L==1)
% if(tf==0)
%     x=imcrop(I,BB);
x=imresize(I,[60 60]);

%%
dim=ndims(x);

if(dim==3)
    x=rgb2gray(x);
end
 y = rgb2lab( repmat(x, [1 1 3]));
 cform = makecform('srgb2lab');
lab = applycform(y,cform); 
 

% figure('name','Input Image & L*a*b Color space Result');
% subplot(121);imshow(I,[]);title('Input RGB image');
% subplot(122);imshow(lab);title('L*a*b color space result');

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);

a = ll;
[m,n] = size(a);  
for i = 2:m-1
    for j = 2:n-1
        b = a(i-1:i+1,j-1:j+1);
        B(i-1:i+1,j-1:j+1) = LBP(b);
    end
end
figure,imshow(B); impixelinfo;
title('Local Binary Patterns');
B=uint8(B);
 image=[image B];
 z=z+1

end

 
temp=[];
for x=1:z
    temp=[temp 60];
% templates=mat2cell(character,42,[24 24 24 24 24 24 24 ...
%     24 24 24 24 24 24 24 ...
%     24 24 24 24 24 24 24 ...
%     24 24 24 24 24 24 24 ...
%     24 24 24 24 24 24 24 ...
%     24 24 24 24 24 24 24 ...
%     24 24 24 24 24]);
end
 templates2=mat2cell(image,60,temp);
save ('templates2','templates2')


clear all
clc
close all
%Detect objects using Viola-Jones Algorithm

%To detect Face
FDetect = vision.CascadeObjectDetector;
j=0;
% ShapeI=vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 0]);
%Read the input image
% I = imread('img4.jpg');
for i=1:160; % we have 16 images we have in or folder
    images ='C:\matlab\pixort\correlation\new';
    jpgfiles=dir(fullfile(images,'\*.jpg*'));

    im1=jpgfiles(i).name;
    I=imread(fullfile(images,im1));



%Returns Bounding Box values based on number of objects
BB = step(FDetect,I);
% face=step(ShapeI,I,int32(BB));%  face=imcrop(I,BB);
figure(1),imshow(I);
tf = isempty(BB) %check if face is detected
if(tf==0)
% figure(1),imshow(face);
% impixelinfo; hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','b');
    
end
for i = 1:size(BB,1)
%     rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','b');
    face=imresize(imcrop(I,BB(i,:)),[60 60]);
    figure;imshow(face,[]);
    imwrite(face,['C:\matlab\pixort\correlation\faces  ' int2str(j), '.jpg']);
    j=j+1;
end
end
title('Face Detection');
end
% hold off;
% figure(2),imshow(face);
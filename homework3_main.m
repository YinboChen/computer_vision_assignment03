%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSCI 5722 Computer Vision
% Name: Yinbo Chen
% Professor: Ioana Fleming
% Assignment: HW3 
% Purpose: For better understanding of corner detection 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;
threshold =0.6*10^10;
w =5;
suppression = true;
% with or without non-maximun 

syn_img = zeros(600,600);
syn_img(201:400,201:400)= ones(200,200);
syn_img = im2uint8(syn_img);
syn_cords = [201,201;400,201;201,400;400,400];
% true position of the white square
% synthetic image 600*600 with 200*200 white square in the center
% imshow(syn_img);
% testing format of syn_img
dict = 0;
% this parameter is related to Part B
% dict is a var which controls to input different images 
% 1 = normal picture without translation, scaling and rotation.
% 2 = a rotated 
% 3 = translated
% 4 = scaled
% 0 = using synthetic image
intens_G = 0;
% this parameter is related to Part D
% dict is a var which controls to add different amounts of Gaussian noise 
% 0 = no noise
% 1 = 25/256 
% 2 = 50/256
% 3 = 150/256

if dict == 1
    img = imread('test.jpg');
elseif dict == 2
    img = imread('test_45.jpg');
elseif dict == 3
    img = imread('test_trans.jpg');
elseif dict == 4
    img = imread('test_scale.jpg');
elseif dict == 0
    if intens_G == 0
        img = syn_img;
        name = 'Gaussian standard deviation of the noise is 0';
    elseif intens_G ==1
        img = imnoise(syn_img,'Gaussian',0,25/256);
        name = 'Gaussian standard deviation of the noise is 25/256';
    elseif intens_G ==2
        img = imnoise(syn_img,'Gaussian',0,50/256);
        name = 'Gaussian standard deviation of the noise is 50/256';
    elseif intens_G ==3
        img = imnoise(syn_img,'Gaussian',0,100/256);
        name = 'Gaussian standard deviation of the noise is 100/256';
%         perform 3 images with increaseing amounts of Gaussian noise
% part D
    end
end

% imshow(syn_img);

adding_par = 0;
% this parameter is related to Part C
% adding_par is a var which prepares a brightness change to the orginal image
% adding_par = 0 without a brightness change
% 1 = adding a constant positive offset(100)to all pixels
% 2 = adding a constant negative offset(-100)to all pixels
% 3 = multiplying a constant positive offset(10)to all pixels
% 4 = multiplying a constant negative offset(0.5)to all pixels
if adding_par == 0
    img = img;
elseif adding_par == 1
    img = img +100;
elseif adding_par == 2
    img = img +(-100);
elseif adding_par == 3
    img = img * 10;
elseif adding_par == 4
    img = img * 0.5;
end

[corner_coords,descriptors] = harris(img,w, threshold,suppression);
 corner_coords
% descriptors

% AB= sqrt((x-x1)^2+(y-y1)^2)
number = size(corner_coords,1)
% the number of keypoints
for i = 1 : number
  AB_1 = sqrt((corner_coords(i,1)-syn_cords(1,1))^2+(corner_coords(i,2)-syn_cords(1,2))^2);
  AB_2 = sqrt((corner_coords(i,1)-syn_cords(2,1))^2+(corner_coords(i,2)-syn_cords(2,2))^2);
  AB_3 = sqrt((corner_coords(i,1)-syn_cords(3,1))^2+(corner_coords(i,2)-syn_cords(3,2))^2);
  AB_4 = sqrt((corner_coords(i,1)-syn_cords(4,1))^2+(corner_coords(i,2)-syn_cords(4,2))^2);
  M = [AB_1,AB_2,AB_3,AB_4];
%   define the true position according to min distance
  AB(i,:)= round(min(M));
  
end
% AB
RMS_g = round((sum(AB))/number)

x = 1:number;
y = AB(x);
figure,plot(x,y),title(name)
xlabel('Number of keypoints')
ylabel('Distance')



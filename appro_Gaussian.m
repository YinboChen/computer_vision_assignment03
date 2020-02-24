img_orig = imread('Square0.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSCI 5722 Computer Vision
% Name: Yinbo Chen
% Professor: Ioana Fleming
% Assignment: HW3 
% Purpose: using averaging filter approximates Gaussian smoothing 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w = 4;
% set a box's radius
if size(img_orig,3)>1
    img = rgb2gray(img_orig);
else
    img = img_orig;
end

%   imshow(img);
img = uint8(img);
img_G = img;
% imshow(img);
a = (-w:w).';
% set up a box grid for -w to w by step 1, and transpose to N*1 vector
R_number = size(a,1);

b = ones(1,R_number)*(1/R_number)
% built a array with number of elements equal to box grid

M = sqrt(a.^2)*b;
M = M.* (1/sum(sum(M)));
% set a filter matrix and normalize

for i = 1 : 4
%     repeat n time to approximate Gaussian smoothing 
 img = conv2(img, M, 'same');
 if i == 1
     img1 = img;
 elseif i ==2
     img2 = img;
 elseif i ==3
     img3 = img;
 elseif i ==4
     img4 = img;
 end
end

compare_G = imgaussfilt(img_G,w);

% imshow(uint8(img));
subplot(1,3,1),imshow(rgb2gray(img_orig)),title('The original image')
subplot(1,3,2),imshow(uint8(img)),title('The approximated Gaussian smoothing')
subplot(1,3,3),imshow(compare_G),title('Gaussian smooting');
figure,
subplot(2,2,1),imshow(uint8(img1)),title('The 1st time')
subplot(2,2,2),imshow(uint8(img2)),title('The 2nd time')
subplot(2,2,3),imshow(uint8(img3)),title('The 3rd time')
subplot(2,2,4),imshow(uint8(img4)),title('The 4th time');



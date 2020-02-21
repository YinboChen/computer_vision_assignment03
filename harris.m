function[corner_coords,descriptors] = harris(I,w, threshold,suppression)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSCI 5722 Computer Vision
% Name: Yinbo Chen
% Professor: Ioana Fleming
% Assignment: HW3 
% Purpose: For better understanding of corner detection 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.compute matrix M 
% compute image gradients Ix Iy for all pixels
% compute squares of derivatives Ix^2,Iy^2,Ix*Iy
% compute m by convolving with Gaussian g
% img = imread('test.jpg');
threshold =13*10^7;
w =9;
suppression = false;

img = imread('Square0.jpg');
img = rgb2gray(img);
% imshow(img)
R = size(img,1);
C = size(img,2);

fx = [-1,0,1;-1,0,1;-1,0,1];
%prewitt filter
% fx = [-1,0,1;-2,0,2;-1,0,1];
% sobel filter
Ix = filter2(fx,img);
% applying corner detector in the horizontal direction
fy = [-1,-1,-1;0,0,0;1,1,1];
% prewitt filter
% fy = [-1,-2,-1;0,0,0;1,2,1];
% sobel filter
Iy = filter2(fy,img);
% applying corner detector in the vertical direction

Ix_2 = Ix.^2;
Iy_2 = Iy.^2;
Ix_y = Ix.*Iy;
% set up squares of derivatives (Ix^2,Iy^2,Ix*Iy)

% w = 2*ceil(2*sigma)+1;
sigma = ceil((w-1)/2)/2;
% testing sigma =5;
% compute sigma via input value w
h = fspecial('gaussian',w,sigma);
% set up gaussian window
Ix_2 = filter2(h,Ix_2);
Iy_2 = filter2(h,Iy_2);
Ix_y = filter2(h,Ix_y);
% test = filter2(h,img);
% imshow(uint8(test));
% applying gaussian filter on computed value
k= 0.05;
% k:constant (0.04 to 0.06)

count = 1;
% save corners' coords to count*2 matrix
for i =1 : R
    for j = 1:C
        M = [Ix_2(i,j),Ix_y(i,j);Ix_y(i,j),Iy_2(i,j)];
%         compute matrix m
        RM(i,j) = det(M)-k*(trace(M))^2;
%         compute R
        
    end
end
     
if suppression == true
%     using suppression to only keep one pixel which around by a bunch of
%     points
 for i = 2:R-1
     for j = 2:C-1
           if RM(i,j)>0 && RM(i,j)> threshold && RM(i,j) > RM(i-1,j-1) && RM(i,j) > RM(i-1,j) && RM(i,j) > RM(i-1,j+1) && RM(i,j) > RM(i,j-1) && RM(i,j) > RM(i,j+1) && RM(i,j) > RM(i+1,j-1) && RM(i,j) > RM(i+1,j) && RM(i,j) > RM(i+1,j+1)
                 corner_coords(count,:) = [j,i];
                 descriptors(count,:)=[img(i-1,j-1),img(i-1,j),img(i-1,j+1),img(i,j-1),img(i,j),img(i,j+1),img(i+1,j-1),img(i+1,j),img(i+1,j+1)];
%             format is [x,y]inverse
                count = count +1;
                
           end
     end
 end
elseif suppression == false
 for m = 1:R
     for n = 1:C
           if RM(m,n)>0 && RM(m,n)>threshold 
                 corner_coords(count,:) = [n,m];
%             format is [x,y]inverse
                count = count +1;
           end
     end
 end
              
end
            

figure,imshow(img);
hold on
plot(corner_coords(:,1),corner_coords(:,2),'r*');

end
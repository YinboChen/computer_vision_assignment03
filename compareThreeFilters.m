function[output]= compareThreeFilters(inImg,m,n,theta)
inImg = imread('peppers.png');

I = rgb2gray(inImg);
% conv to gray

I_added = imnoise(I, 'salt & pepper');
% use imnoise func adds 'salt and peper' noises on I(image)
H = ones(3)/9;
% set up a filter kernel 3*3 with(1/9)for mean filter
I_median = medfilt2(I_added,[3,3]);
% median filter:  a 3 by 3 median filter
I_mean = filter2(H,I_added);
% mean filter: I_mean2 = conv2(I_added,H,'same');2nd way to setup a meanfilter
% a 3*3 mean filter
I_gaussuan_1 =  imgaussfilt(I_added,1/3);
I_gaussuan_2 =  imgaussfilt(I_added,1);
I_gaussuan_3 =  imgaussfilt(I_added,1.5);


figure,imshow(uint8(I_mean)),title('mean filter');
% figure,imshow(uint8(I_mean2)),title('mean2 filter');
figure,imshow(I_median),title('median filter');
figure,imshow(I_gaussuan_1),title('Gaussian filter with 1/3 pixel');
figure,imshow(I_gaussuan_2),title('Gaussian filter with 1 pixel');
figure,imshow(I_gaussuan_3),title('Gaussian filter with 1.5 pixel');
figure,subplot(2,3,1),imshow(uint8(I_mean)),title('mean filter')
subplot(2,3,2),imshow(I_median),title('median filter');
subplot(2,3,3),imshow(I_gaussuan_1),title('Gaussian filter with 1/3 pixel');
subplot(2,3,4),imshow(I_gaussuan_2),title('Gaussian filter with 1 pixel');
subplot(2,3,5),imshow(I_gaussuan_3),title('Gaussian filter with 1.5 pixel');
subplot(2,3,6),imshow(I_added),title('Original grayimage with salt & pepper');

% Above is part A 

I_added_G = imnoise(I, 'gaussian',0,1/256);
% figure,imshow(I_added_G);
I_median_G = medfilt2(I_added_G,[3,3]);
I_mean_G = filter2(H,I_added_G);
I_gaussuan_1_G =  imgaussfilt(I_added_G,1/3);
I_gaussuan_2_G =  imgaussfilt(I_added_G,1);
I_gaussuan_3_G =  imgaussfilt(I_added_G,1.5);

figure,imshow(uint8(I_mean_G)),title('mean filter_G');
% figure,imshow(uint8(I_mean2)),title('mean2 filter');
figure,imshow(I_median_G),title('median filter_G');
figure,imshow(I_gaussuan_1_G),title('Gaussian filter_G with 1/3 pixel');
figure,imshow(I_gaussuan_2_G),title('Gaussian filter_G with 1 pixel');
figure,imshow(I_gaussuan_3_G),title('Gaussian filter_G with 1.5 pixel');
figure,subplot(2,3,1),imshow(uint8(I_mean_G)),title('mean filter_G')
subplot(2,3,2),imshow(I_median_G),title('median filter_G');
subplot(2,3,3),imshow(I_gaussuan_1_G),title('Gaussian filter_G with 1/3 pixel');
subplot(2,3,4),imshow(I_gaussuan_2_G),title('Gaussian filter_G with 1 pixel');
subplot(2,3,5),imshow(I_gaussuan_3_G),title('Gaussian filter_G with 1.5 pixel');
subplot(2,3,6),imshow(I_added_G),title('Original grayimage with gaussian white noise');


end
function[output]= compareThreeFilters(inImg,m,n,theta)
inImg = imread('peppers.png');

I = rgb2gray(inImg);
% conv to gray

I_added = imnoise(I, 'salt & pepper');
% use imnoise func adds 'salt and peper' noises on I(image)
H = ones(3)/9;
% set up a filter kernel 3*3 with(1/9)for mean filter
I_median = medfilt2(I_added,[3,3]);
% a 3 by 3 median filter
I_mean = filter2(H,I_added);
% I_mean2 = conv2(I_added,H,'same');2nd way to setup a meanfilter
% a 3*3 mean filter

figure,imshow(uint8(I_mean)),title('mean filter');
% figure,imshow(uint8(I_mean2)),title('mean2 filter');
figure,imshow(I_median),title('median filter');

end
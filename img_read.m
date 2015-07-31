function P = img_read(img_sz,img)
%IMG_READ loads phantom image from image data set
%

sz = num2str(img_sz);
img = num2str(img);
if img_sz == 512
    name = strcat('phantom_',img,'.png');
else
    name = strcat('phantom_',img,'_',sz,'x',sz,'.png');
end
P = imread(name);
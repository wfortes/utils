function P = img_read(i,j)

sz = num2str(j);
img = num2str(i);
if j==512
    name = strcat('phantom_',img,'.png');
else
    name = strcat('phantom_',img,'_',sz,'x',sz,'.png');
end
P = imread(name);
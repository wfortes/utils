function P = dart_img_read(i,j)

img_index = num2str(i);
N_proj = num2str(j);
    
if j<=9
    name = strcat('phantom_',img_index,'_noiseless_0',N_proj,'_segm.png');
else
    name = strcat('phantom_',img_index,'_noiseless_',N_proj,'_segm.png');
end
P = imread(name);
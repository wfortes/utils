function im_smooth = smooth(im_org)

r = 1;
w = 2 * r + 1;
amount = 0.05;

% Set Kernel
K = ones(w) * amount / (w.^2-1); % edges
K(r+1,r+1) = 1 - amount; % center

% output window
im_smooth = zeros(size(im_org,1) + w-1, size(im_org,2) + w - 1);

% blur convolution
for s = -r:r 
    for t = -r:r 
        im_smooth(1+r+s:end-r+s, 1+r+t:end-r+t) = im_smooth(1+r+s:end-r+s, 1+r+t:end-r+t) + K(r+1+s, r+1+t) * im_org;
    end
end

% shrink output window
im_smooth = im_smooth(1+r:end-r, 1+r:end-r);
            
end
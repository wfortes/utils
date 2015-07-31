function [vec1,vec2]=mkdirvecs(maxi)
%MKDIRVECS creates a sequence of directions on the plane
% The vector VEC1 contains the first components of all directions
% The vector VEC2 contains the second components of all directions
% The direction vectors [VEC1(i) VEC2(i)] are built such that
%       the absolute value of each component is smaller or equal to MAXI
%       VEC1(i) is non-negative
%       VEC1(i) and VEC2(i) are coprimes
%
% MAXI >= 1
%
% List of number of directions for MAXI ranging from 1 to 20:
% 4 8 16 24 40 48 72 88 112 128 168 184 232 256 288 320 384 408 480 512
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

if maxi >= 1
    vec1 = [1 0];% 1 1];
    vec2 = [0 1];% -1 1];
    k=2;
else
    error('maxi can not be smaller than 1')
end

for i = 1:maxi
    for l = 1:i
            if gcd(max(i,l),min(i,l))==1
            k = k+1;
            vec1(k)=l; vec2(k)=i;
            k = k+1;
            vec1(k)=l; vec2(k)=-i;
            end
    end
    for j = 1:i
        if i==1 && j==1
            break
        end
        if gcd(max(i,j),min(i,j))==1
            k = k+1;
            vec1(k)=i; vec2(k)=j;
            k = k+1;
            vec1(k)=i; vec2(k)=-j;
        end
    end
end
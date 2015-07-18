function [a,b]=mkdirvecs(maxi)

% The vector a contains the first component of all vector directions and
%the vector b all the second ones
% The direction vectors are build in a way that
%       the absolute value of each component is smaller or equal to maxi
%       a is non-negative and a and b are coprimes
% maxi >= 1

if maxi >= 1
    a = [1 0];% 1 1];
    b = [0 1];% -1 1];
    k=2;
else
    error('maxi can not be smaller than 1')
end
% for i = 1:maxi
%     for j = 1:maxi
%         if gcd(max(i,j),min(i,j))==1
%             k = k+1;
%             a(k)=i; b(k)=j;
%             k = k+1;
%             a(k)=i; b(k)=-j;
%         end
%     end
% end

% List of #dir from 1 to 20
% 4 8 16 24 40 48 72 88 112 128 168 184 232 256 288 320 384 408 480 512

for i = 1:maxi
    for l = 1:i
            if gcd(max(i,l),min(i,l))==1
            k = k+1;
            a(k)=l; b(k)=i;
            k = k+1;
            a(k)=l; b(k)=-i;
            end
    end
    for j = 1:i
        if i==1 && j==1
            break
        end
        if gcd(max(i,j),min(i,j))==1
            k = k+1;
            a(k)=i; b(k)=j;
            k = k+1;
            a(k)=i; b(k)=-j;
        end
    end
end
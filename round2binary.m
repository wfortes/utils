function [r b ordb Ix d] = round2binary(R)

% round to the nearest binary vector
% r is the binary vector
% b is a vector of increment for switching an entry of r
% ordb is b ordered by crescent values
% Ix is the index of b ordered as ordb
% d=R-r

r=min(max(round(R),0),1);
b = abs(2*R-1);
d=R-r;
[ordb,Ix] = sort(b);

% old version
% % ra = round(R);
% for i=1:size(R,1)
% %      d(i,1) = min(abs(R(i)),abs(R(i)-1)); % d=abs(R-r);
%     b(i,1) = abs(2*R(i)-1);
%     if abs(R(i))>abs(R(i)-1)
%         r(i,1)=1;
%     else
%         r(i,1)=0;
%     end
% end
% d=R-r;
% [ordb,Ix] = sort(b);
function [r, b, ordb, Ix] = round2binary(vector)
%ROUND2BINARY rounds each entry of VECTOR to its nearest binary value
%   R is the binary vector closest to VECTOR in the l2 norm
%   B is a vector of increments for switching an entry of VECTOR
%   ORDB is sorted B in ascending order
%   IX is the index of B ordered as ORDB
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

r = min(max(round(vector),0),1);
b = abs(2*vector-1);
[ordb,Ix] = sort(b);
function [V V1 V2 wpix wpix2] = variability(npix,sqradius,s,ordb,parameter,Ix,normPbyQ,r,lim)

% Compute an upper bound for the maximum number of different pixels between
% two binary solutions and its fraction with respect to npix

% 3 versions available: the 3rd is lower

% upper bound error and number of wrong pixels
wpix = 4*sqradius;

% 1st version
V = wpix/npix;

% 2nd version
V1 = 2*s;

% upper bound error and number of wrong pixels
wpix2 = bnwpixr(ordb,2*parameter,Ix,normPbyQ,r,lim);

% 3rd version and most accurate
V2 = wpix2/npix;
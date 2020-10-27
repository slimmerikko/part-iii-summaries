% Copyright 2018 Matthias J. Ehrhardt, Lukas F. Lang
%
% This file is part of IP18.
%
%    IP18 is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    IP18 is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with IP18. If not, see <http://www.gnu.org/licenses/>.
%
% This script takes the image 'trees.tif' and 'kernel.png' and creates a
% blurry image by convolving the two.
clear;
close all;
clc;

% Load the image.
u = imread('trees.tif');
[m, n] = size(u);

% Plot the image with colorbar.
figure(1);
colormap gray;
subplot(2, 2, 1);
imagesc(u);
title('Original image u.');
axis image;
colorbar;

% Load and create normalised convolution kernel.
filename = fullfile('data', 'kernel.png');
k = sum(255 - double(imread(filename)), 3);
k = k ./ sum(abs(k(:)));

% Plot kernel.
subplot(2, 2, 2);
imagesc(k);
title('Kernel k.');
axis image;
colorbar;

% Create zero-padded version of kernel.
kk = zeros([m, n]);
kk(1:size(k, 1), 1:size(k, 2)) = k;

% Compute Fourier transforms of kernel and image.
Fk = fft2(kk);
Ff = fft2(u);

% Compute convolved image.
f = ifft2(Ff .* Fk);

% Show data and kernel in Fourier domain.
subplot(2, 2, 3);
imagesc(f);
title('Data f.');
axis image;
colorbar;
subplot(2, 2, 4);
imagesc(ifftshift(abs(Fk)));
title('Kernel in Fourier domain (abs).');
axis image;
colorbar;

% Save the data and the figure.
mkdir('results');
save(fullfile('results', 'ex5b_data.mat'), 'k', 'u', 'f', 'Fk');
saveas(gcf, fullfile('results', 'ex5b_data.png')); 

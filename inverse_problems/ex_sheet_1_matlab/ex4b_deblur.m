data = load('results/ex5b_data.mat');
colormap gray;
u_org = data.u;
% u_org_noise = imnoise(u_org, 'gaussian');

% Restore data from array
Fk = data.Fk;
f = data.f;
[m, n] = size(f);
r = normrnd(0, 0.1, m, n);

% Add noise to f (REMOVE THIS IF TRUE RECONSTRUCTION IS DESIRED)
f = f + r;

% Compute inverse Fourier transform
Ff = fft2(f);
% prod = Ff ./ Fk;
prod = Ff .* conj(Fk) ./ (abs(Fk) .^ 2);
u_inv =  ifft2(prod);

% Show image
figure(1)
subplot(2, 1, 1)
imagesc(u_org)

subplot(2, 1, 2)
imagesc(u_inv)

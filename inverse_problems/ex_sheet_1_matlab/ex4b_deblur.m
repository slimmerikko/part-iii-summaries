data = load('results/ex5b_data.mat');
Fk = data.Fk;
f = data.f;
Ff = fft2(f);
u =  (2 * pi)^(-1) * ifft2(Ff ./ Fk);
imshow(u)
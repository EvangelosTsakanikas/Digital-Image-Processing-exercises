M = size(degraded, 1);
N = size(degraded, 2);

degraded_DFT = fft2(degraded);

D_center = [M/2 N/2];
Do = 150;
H = zeros(M,N);
for i=1:M
    for j=1:N
        D = (i - D_center(1)).^2 + ((j - D_center(2)).^2);
        H(i,j) = exp(double(-D) / double(2*(Do^2)));
    end
end

degraded_filtered_DFT = degraded_DFT .* H;
degraded_filtered = ifft2(degraded_filtered_DFT);

MSE = immse(brain0030slice150, uint8(degraded_filtered))

imshow(real(uint8(degraded_filtered)), []);
title('Gaussian Do = 150');
xlabel(MSE);
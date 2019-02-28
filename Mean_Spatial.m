window_M = 5;
window_N = 5;

M = size(degraded, 1);
N = size(degraded, 2);

M_zero_pad = M+4;
N_zero_pad = N+4;

degraded_zero_padded = zeros(M_zero_pad, N_zero_pad);
degraded_zero_padded(3:M_zero_pad-2, 3:N_zero_pad-2) = degraded;

degraded_filtered = zeros(M,N);

for i=1:M
    for j=1:N
        window = zeros(window_M*window_N,1);
        counter = 1;
        for x=1:window_M
            for y=1:window_N
                window(counter) = degraded_zero_padded(i + x-1, j + y-1);
                counter = counter + 1;
            end
        end 
        degraded_filtered(i,j) = mean(window);
    end
end    

MSE = immse(brain0030slice150, uint8(degraded_filtered))

imshow(uint8(degraded_filtered), []);
title('Mean');
xlabel(MSE);
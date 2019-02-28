window_M = 3;
window_N = 3;

M = size(degraded, 1);
N = size(degraded, 2);

M_zero_pad = M+2;
N_zero_pad = N+2;

degraded_zero_padded = zeros(M_zero_pad, N_zero_pad);
degraded_zero_padded(2:M_zero_pad-1, 2:N_zero_pad-1) = degraded;

degraded_filtered = zeros(M,N);

Q = -3;
S1 = 0;
S2 = 0;
for i=1:M
    for j=1:N        
        for x=1:window_M
            for y=1:window_N
                S1 = S1 + (degraded_zero_padded(i + x-1, j + y-1))^(Q+1);
                S2 = S2 + (degraded_zero_padded(i + x-1, j + y-1))^Q;
            end
        end        
        degraded_filtered(i,j) = double(S1)/double(S2);
        S1 = 0;
        S2 = 0;
    end
end

MSE = immse(brain0030slice150, uint8(degraded_filtered))

imshow(uint8(degraded_filtered), []);
title('Contraharmonic Q = -3');
xlabel(MSE);
function [H,w] = myfreqz(h,n)

if (~exist('n','var'))
    n = 512;
end

H = zeros(1,n);
w = 0;
for j = 1:n
    for k = 0:length(h)-1
        if(w == pi/2 || w == pi)
            e = exp(-1i*sym(w)*k);
        else
            e = exp(-1i*w*k);
        end
        H(j) = H(j) + h(k+1)*e;
    end
    w = j*(pi/n);
end


function w = myconv(u,v)
w = zeros(1,length(u)+length(v)-1);
for i = 1:length(u)
    for k = 1:length(v)
      w(i+k-1) = w(i+k-1) + v(k)*u(i);
    end
end

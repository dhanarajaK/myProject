function [ D ] = deviation( m, n )

x = 1:m;
y = 1:n;

for i = 1:length(x)
    for j = 1:length(y)
        D(i,j) = max(x(i)/m - y(j)/n, y(j)/n - x(i)/m);
    end
end

end



function f = poissonSolve(fx, fy)

[rows, cols] = size(fx);

fx(:,end) = 0;
fy(end,:) = 0;

fx = padarray(fx, [1 1], 0, 'both');
fy = padarray(fy, [1 1], 0, 'both');

fxx = zeros(size(fx)); 
fyy = zeros(size(fx)); 

j = 1:(rows + 1);
k = 1:(cols + 1);

fyy(j + 1, k) = fy(j + 1, k) - fy(j, k);
fxx(j, k + 1) = fx(j, k + 1) - fx(j, k);
rhs = fxx + fyy;
rhs = rhs(2:(end - 1), 2:(end - 1));

fcos = dct2(rhs);

[x, y] = meshgrid(0:(cols - 1), 0:(rows - 1));
denom = 2*(cos(pi*x/cols) + cos(pi*y/rows) - 2);

fcos(2:end) = fcos(2:end)./denom(2:end);

f = idct2(fcos);

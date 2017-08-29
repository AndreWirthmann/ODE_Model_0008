function y = MyPosRandn(StdDev,Mean,n)
% Returns n positive random numbers
% drawn from normally distributed random numbers
% with StdDev and Mean
% Will fail to return n numbers if too many are negative
% 'Index exceeds matrix dimensions' caused by y = y(1:n);

% generate n*3 norm distr numbers
y = StdDev.*randn(n*3,1) + Mean;

% remove the negative ones
y(y<0) = [];

% return only the first n
y = y(1:n);
end
% phogDistances.m
%  curPhog: column vector
%  otherPhogs: matrix with # cols == # other phogs

function distanceVector = ...
    phogDistances(curPhog,otherPhogs,expchi2Avg,varargin)

% Get input.
parser = inputParser;
parser.FunctionName = 'phogDistances';
parser.addRequired('curPhog');
parser.addRequired('otherPhogs');
parser.addRequired('expchi2Avg',@(x)x>0);
parser.parse(curPhog,otherPhogs,expchi2Avg,varargin{:});
curPhog = parser.Results.curPhog;
otherPhogs = parser.Results.otherPhogs;
expchi2Avg = parser.Results.expchi2Avg;

% Compute distances.
distanceVector = zeros(1,size(otherPhogs,2));
for col = 1:size(otherPhogs,2)
    distanceVector(col) = ...
        1 - exp(-chi2Dist(curPhog,otherPhogs(:,col)) / expchi2Avg);
end
assert(all(all(distanceVector>=0)));
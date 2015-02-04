% chi2Dist.m

function dist = chi2Dist(vector1,vector2,varargin)

% Get input.
parser = inputParser;
parser.FunctionName = 'chi2Dist';
parser.addRequired('vector1');
parser.addRequired('vector2');
parser.parse(vector1,vector2,varargin{:});
vector1 = parser.Results.vector1;
vector2 = parser.Results.vector2;

% Check that vector1 and vector2 are probability distributions.
assert(all(vector1>=0),'vector1 must be nonnegative.');
assert(all(vector2>=0),'vector2 must be nonnegative.');
vector1 = vector1 / sum(vector1);
vector2 = vector2 / sum(vector2);

% Because we can't divide by 0, we should only include terms in the
% chi-square sum for which vector1+vector2 at a particular index is > 0.
positiveIndicies = find(vector1+vector2);
positiveVector1 = vector1(positiveIndicies);
positiveVector2 = vector2(positiveIndicies);
dist = .5 * sum((positiveVector1 - positiveVector2).^2 ./ (positiveVector1 + positiveVector2));
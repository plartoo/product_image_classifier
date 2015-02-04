% chi2TestConfusionMatrices.m
% Compute p-value of chi2 test for independence. See, e.g.,
% http://homepage.mac.com/samchops/B733177502/C1517039664/E20060507073109/index.html
% for the formula.

function pVal = chi2TestConfusionMatrices(confusionMatrix,varargin)

% Get input.
parser = inputParser;
parser.FunctionName = 'chi2TestConfusionMatrices';
parser.addRequired('confusionMatrix');
parser.parse(confusionMatrix,varargin{:});
confusionMatrix = parser.Results.confusionMatrix;

% Check input.
nCategories = size(confusionMatrix,1);
assert(nCategories==size(confusionMatrix,2));

% How many images were in each class?
classSizes = sum(confusionMatrix);
expectedNumEachCell = repmat(classSizes / nCategories,nCategories,1);

% Compute test statistic.

testStatistic = ...
    sum(sum((confusionMatrix - expectedNumEachCell) .^ 2 ./ expectedNumEachCell));
df = (nCategories-1)^2;
pVal = 1-chi2cdf(testStatistic,df);
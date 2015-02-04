% sigmasRandom.m
%  Produce a nSigmas x 1 vector of random sigma values such that their inverses
% are uniformly distributed.

function randSigmas = sigmasRandom(nSigmas,min,max,sigmaPdf)

% Get input.
parser = inputParser;
parser.FunctionName = 'sigmasRandom';
parser.addRequired('nSigmas', @(x)x>0);
parser.addRequired('min', @(x)x>0);
parser.addRequired('max', @(x)x>0);
parser.addRequired('sigmaPdf');
parser.parse(nSigmas,min,max,sigmaPdf);
nSigmas = parser.Results.nSigmas;
min = parser.Results.min;
max = parser.Results.max;
assert(max > min);
sigmaPdf = parser.Results.sigmaPdf;

% Make cdf.
min = round(min);
max = round(max);
support = min:max;
rawPdf = arrayfun(sigmaPdf,support);
pdf = rawPdf / sum(rawPdf);
cdf = [0 cumsum(pdf)];

% Return result.
randSigmas = zeros(nSigmas,1);
for i = 1:nSigmas
   position = find(cdf<rand,1,'last');
   randSigmas(i,1) = support(position) + rand; % avoid having all integers
end
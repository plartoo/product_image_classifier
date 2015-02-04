% signatureDistances.m
%  curSignature: column vector (already converted to double)
%  otherSignatures: matrix with # cols == # other signatures (already
%    converted to double)

function distanceVector = ...
    signatureDistances(curSignature,otherSignatures,varargin)

% Set constants.
DEFAULT = 2*pi+3.2342; % some random value

% Get input.
parser = inputParser;
parser.FunctionName = 'signatureDistances';
parser.addRequired('curSignature');
parser.addRequired('otherSignatures');
parser.addParamValue('metric', 'cosine', @(x)any(strcmpi(x,{'L1','cosine','expchi2'})));
parser.addParamValue('expchi2Avg', DEFAULT, @(x)x>0);
parser.parse(curSignature,otherSignatures,varargin{:});
curSignature = parser.Results.curSignature;
otherSignatures = parser.Results.otherSignatures;
metric = parser.Results.metric;
expchi2Avg = parser.Results.expchi2Avg;

% Choose metric.
switch metric
    case 'cosine'
        u = otherSignatures;
        v = repmat(curSignature,1,size(otherSignatures,2));
        cosines = sum(u .* v) ./ sqrt(sum(u .* u) .* sum(v .* v));
        assert(all(cosines>=0));
        assert(all(cosines<=1));
        distanceVector = 1 - cosines;
    case 'L1'
        u = otherSignatures;
        v = repmat(curSignature,1,size(otherSignatures,2));
        distanceVector = sum(abs(u-v));
        % The "double" command turns int8s to doubles.
    case 'expchi2'
        assert(expchi2Avg~=DEFAULT,'need to provide expchi2Avg!');
        distanceVector = zeros(1,size(otherSignatures,2));
        for col = 1:size(otherSignatures,2)
           distanceVector(col) = ...
               1 - exp(-chi2Dist(curSignature,otherSignatures(:,col)) / expchi2Avg);
        end
        assert(all(all(distanceVector>=0)));
    otherwise
        error('Not a distance metric.');
end
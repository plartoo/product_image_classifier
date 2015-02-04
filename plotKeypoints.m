% plotKeypoints.m
%  Plot selected keypoints.

% Run as 
% plotKeypoints('../images/la_pointy_21',1,50,'_nKeypoints=10000_keypointDetector=canny_sigmaPdf=oneOverXto0.5')

function plotKeypoints(stemFileName,minSigma,minSiftNorm,howChoseKeypoints)

[f d] = loadDescriptors(stemFileName,minSigma,minSiftNorm,howChoseKeypoints);
f = f'; % they're reversed from the usual order
d = d'; % same as above

% To show points on image, uncomment below.
jpgFile = strcat(stemFileName,'.jpg');
imshow(jpgFile);
hold on;
nShow = round(size(f,1) / 1);
randPermutation = randperm(size(f,1));
candidatesToShow = randPermutation(1:nShow);
x = round(f(candidatesToShow,1));
y = round(f(candidatesToShow,2));
sigmas = f(candidatesToShow,3);
MAX_SIGMA_SHOW = 10;
smallEnoughSigmas = find(sigmas<MAX_SIGMA_SHOW);
fprintf('Keeping %i points.',length(smallEnoughSigmas));
scatter(x(smallEnoughSigmas),y(smallEnoughSigmas),sigmas(smallEnoughSigmas).^2 * pi,'r'); % Area of circle.
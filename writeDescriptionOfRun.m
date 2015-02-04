% Write a text file that describes the parameters, images, etc. used in
% this run.

function writeDescriptionOfRun(fullFolderName,paramStruct,view,...
    imageNamesByNumber,results,varargin)

% Get input.
parser = inputParser;
parser.FunctionName = 'writeDescriptionOfRun';
parser.addRequired('fullFolderName');
parser.addRequired('paramStruct');
parser.addRequired('view');
parser.addRequired('imageNamesByNumber');
parser.addRequired('results');
parser.parse(fullFolderName,paramStruct,view,imageNamesByNumber,...
    results,varargin{:});
fullFolderName = parser.Results.fullFolderName;
paramStruct = parser.Results.paramStruct;
view = parser.Results.view;
imageNamesByNumber = parser.Results.imageNamesByNumber;
results = parser.Results.results;

% Open file.
fileName = fullfile(fullFolderName,'readme.txt');
try
    file = fopen(fileName,'w');

    % Write parameters.
    fprintf(file,'************************************\n');
    fprintf(file,'Printed %s.\n',datestr(now));
    fprintf(file,'Elapsed time = %f seconds.\n',results.timeElapsed);
    fprintf(file,'\nParameters:\n');
    fprintf(file,'view=%s\n',view);
    fprintf(file,'classifier=%s\n',paramStruct.classifier);
    fprintf(file,'k=%i\n',paramStruct.k);
    fprintf(file,'fracDataTestOn=%g\n',paramStruct.fracDataTestOn);
    fprintf(file,'data_min_sigma=%g\n',paramStruct.data_min_sigma);
    fprintf(file,'data_shuffle=%i\n',paramStruct.data_shuffle);
    fprintf(file,'tree_fair_data=%i\n',paramStruct.tree_fair_data);
    fprintf(file,'tree_limit_data=%g\n',paramStruct.tree_limit_data);
    fprintf(file,'tree_K=%i\n',paramStruct.tree_K);
    fprintf(file,'tree_nleaves=%i\n',paramStruct.tree_nleaves);
    fprintf(file,'keypointDetector=%s\n',paramStruct.keypointDetector);
    fprintf(file,'sigmaPdf=%s\n',paramStruct.sigmaPdfAsString);
    fprintf(file,'tree_restrict_to_train=%i\n',paramStruct.tree_restrict_to_train);
    fprintf(file,'stat_downsample=%g\n',paramStruct.stat_downsample);
    fprintf(file,'fracTrainExToVote=%g\n',paramStruct.fracTrainExToVote);
    fprintf(file,'zScoreVoting=%i\n',paramStruct.zScoreVoting);
    fprintf(file,'minSiftNorm=%i\n',paramStruct.minSiftNorm);
    fprintf(file,'nKeypoints=%i\n',paramStruct.nKeypoints);
    %fprintf(file,'cutoff=%g\n',paramStruct.cutoff);
    fprintf(file,'maxViewsPerProduct=%i\n',paramStruct.maxViewsPerProduct);
    fprintf(file,'combineDistances=%s\n',paramStruct.combineDistances);
    fprintf(file,'signatureDistance=%s\n',paramStruct.signatureDistance);
    fprintf(file,'leaveOneOut=%i\n',paramStruct.leaveOneOut);
    fprintf(file,'coeffForPhog=%f\n',paramStruct.coeffForPhog);
    fprintf(file,'maxProductsPerCategory=%i\n',paramStruct.maxProductsPerCategory);

    % Write results.
    fprintf(file,'\nResults:\n');
    fprintf(file,'Accuracy=%g +/- %g\n',results.accuracy,results.stdAccuracy);
    fprintf(file,'Class-size-adjusted accuracy=%g +/- %g\n',...
        results.classSizeAdjustedAccuracy,...
        results.stdClassSizeAdjustedAccuracy);
    fprintf(file,'p-value of chi2 test=%g\n',results.pVal);
    fprintf(file,'Raw confusion matrix:\n');
    fclose(file);
    dlmwrite(fileName,results.confMatrix,'-append','roffset',0,...
        'delimiter',' ','precision','%.2i');
    file = fopen(fileName,'a');
    fprintf(file,'Normalized confusion matrix:\n');
    fclose(file);
    dlmwrite(fileName,results.normConfMatrix,'-append','roffset',0,...
        'delimiter',' ','precision','%.2g');
    file = fopen(fileName,'a');

    % Write misclassifications.
    fprintf(file,'\nMisclassifications:\n');
    for cat = 1:length(paramStruct.categories)
        fprintf(file,'\tYou wrongly said these were %s:\n',paramStruct.categories{cat});
        for i = 1:length(results.misclassifications{cat})
            fprintf(file,'\t\t%s\n',results.misclassifications{cat}{i});
        end
    end

    % Write images.
    fprintf(file,'\nImages and their categories:\n');
    for cat = 1:length(imageNamesByNumber)
        nImagesThisCat = 0;
        fprintf(file,'%s\n',paramStruct.categories{cat});
        for num = 1:length(imageNamesByNumber{cat})
            for imgView = 1:length(imageNamesByNumber{cat}{num})
                fprintf(file,'\t%s\n',imageNamesByNumber{cat}{num}{imgView});
                nImagesThisCat = nImagesThisCat + 1;
            end
        end
        fprintf(file,'\t\tApprox # training examples = %.0f\n',...
            nImagesThisCat * (1-paramStruct.fracDataTestOn));
    end
    fprintf(file,'************************************\n');

    % Close file.
    fclose(file);
end
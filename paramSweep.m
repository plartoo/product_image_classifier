% paramSweep.m
%  Run a parameter sweep with getResults.m. Output the results to a .csv
%  file.

function paramSweep(paramName,functionHandle,paramValues,catNumsToRun)

% Set constant.
USE_TRY = 1;

% Define categories.
listOfCategories = {{'velcro','laces'},... %1
    {'pointy','nonpointy'},... %2
    {'shortslv','longslv'},... %3
    {'collar','vneck','crew'},... %4
    {'balletanddance','boating','basesoftball'}} %5

% Get input.
parser = inputParser;
parser.FunctionName = 'paramSweep';
parser.addRequired('paramName');
parser.addRequired('functionHandle');
parser.addRequired('paramValues', @iscell);
parser.addRequired('catNumsToRun');
parser.parse(paramName,functionHandle,paramValues,catNumsToRun);
paramName = parser.Results.paramName;
functionHandle = parser.Results.functionHandle;
paramValues = parser.Results.paramValues;
catNumsToRun = parser.Results.catNumsToRun;

% Create output file.
unix('mkdir sweeps');
sweepFile = fullfile('sweeps',strcat(sprintf('%s_%s',paramName,datestr(now,1)),'.txt'));
file = fopen(sweepFile,'w');
fprintf(file,',');
for c = 1:length(listOfCategories)
    categories = listOfCategories{c};
    for i = 1:length(categories)
        fprintf(file,'%s',categories{i});
        if(i < length(categories))
            fprintf(file,' vs. ');
        else
            fprintf(file,',');
        end
    end
end

% Run each category and parameter value, getting results.
for i = 1:length(paramValues)
    if(isnumeric(paramValues{1}))
        fprintf(file,'\n%g,',paramValues{i});
    else % The parameter is a string not a number.
        fprintf(file,'\n%s,',paramValues{i});
    end
    for c = catNumsToRun
        categories = listOfCategories{c};
        if(USE_TRY)
            try
                results = functionHandle(categories,paramValues{i});
                fprintf(file,'%g,%g',results.classSizeAdjustedAccuracy,results.stdClassSizeAdjustedAccuracy);
            catch
                err = lasterror;
                warning('FAILED!!')
                error = err
                for iStack = 1:length(err.stack)
                    stacktrace = err.stack(iStack)
                end
            end
        else
            results = functionHandle(categories,paramValues{i});
            fprintf(file,'%g',results.classSizeAdjustedAccuracy);
        end
        fprintf(file,',');
    end
end
fclose(file);

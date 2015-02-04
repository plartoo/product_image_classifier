% reviewParams.m
%  A script to run getResults.m under various parameter settings.

% Get our computer name.
[status cur_computer] = unix('hostname');
trimmed = strtrim(cur_computer);

% Run 15 Jan:
N_CATS=5;
for tld = [.5]
    switch trimmed
        case 'catnip'
            handle = @(categories,val)getResults('categories',categories,'powerForSigma',val,'tree_limit_data',tld,'nKeypoints',5000);
            paramSweep(sprintf('resultsToShowForNumKeypoints,tld=%f',tld),handle,{1},1:N_CATS);
        case 'butter'
            handle = @(categories,val)getResults('categories',categories,'powerForSigma',val,'tree_limit_data',tld,'nKeypoints',15000);
            paramSweep(sprintf('resultsToShowForNumKeypoints,tld=%f',tld),handle,{1},1:N_CATS);
        case 'sage'
            % NOTE THE TWO DIFFERENT SWEEPS WE DO. WE NEED BOTH.
            handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val,'tree_limit_data',tld);
            paramSweep(sprintf('zScoreVoting,tld=%f',tld),handle,{0,1},1:N_CATS);
            handle = @(categories,val)getResults('categories',categories,'zScoreVoting',0,'tree_limit_data',tld,'fracTrainExToVote',val);
            paramSweep(sprintf('fracTrainExToVote,tld=%f',tld),handle,{.05,.1},1:N_CATS);
        case 'curry'
            handle = @(categories,val)getResults('categories',categories,'keypointDetector',val,'tree_limit_data',tld);
            paramSweep(sprintf('keypointDetector,tld=%f',tld),handle,{'smallCanny','smallRandom'},1:N_CATS);
        case 'ginger'
            handle = @(categories,val)getResults('categories',categories,'maxViewsPerProduct',val,'tree_limit_data',tld);
            paramSweep(sprintf('maxViewsPerProduct,tld=%f',tld),handle,{1,2,3,5,Inf},1:N_CATS);
        case 'wasabi'
            handle = @(categories,val)getResults('categories',categories,'minSiftNorm',val,'tree_limit_data',tld);
            paramSweep(sprintf('minSiftNorm,tld=%f',tld),handle,{0, 1, 25, 50, 75, 100, 200},1:N_CATS);
        case 'tarragon'
            handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val,'tree_limit_data',tld);
            paramSweep(sprintf('maxProductsPerCategory,tld=%f',tld),handle,{5,25,50,75},1:N_CATS);
        otherwise
            error('not a valid machine');
    end
end


%{
% Run 5 Dec:
for tld = [.005 .5]
    switch machine
        case 'chervil'
            handle = @(categories,val)getResults('categories',categories,'powerForSigma',val,'tree_limit_data',tld);
            paramSweep(sprintf('powerForSigma,tld=%f',tld),handle,{.75,1,1.15,1.75},1:3);
        case 'cilantro'
            % NOTE THE TWO DIFFERENT SWEEPS WE DO. WE NEED BOTH.
            handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val,'tree_limit_data',tld);
            paramSweep(sprintf('zScoreVoting,tld=%f',tld),handle,{0,1},1:5);
            handle = @(categories,val)getResults('categories',categories,'zScoreVoting',0,'tree_limit_data',tld,'fracTrainExToVote',val);
            paramSweep(sprintf('fracTrainExToVote,tld=%f',tld),handle,{.05,.1},1:5);
        case 'orange'
            handle = @(categories,val)getResults('categories',categories,'keypointDetector',val,'tree_limit_data',tld);
            paramSweep(sprintf('keypointDetector,tld=%f',tld),handle,{'canny','none'},1:5);
        case 'rosemary'
            handle = @(categories,val)getResults('categories',categories,'maxViewsPerProduct',val,'tree_limit_data',tld);
            paramSweep(sprintf('maxViewsPerProduct,tld=%f',tld),handle,{1,2,3,4,5,6,Inf},1:5);
        case 'cheese'
            handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val,'tree_limit_data',tld);
            paramSweep(sprintf('fracTrainExToVote,tld=%f',tld),handle,{.05, .1, .25, .5, .75, 1},1:5);
        case 'wasabi'
            handle = @(categories,val)getResults('categories',categories,'minSiftNorm',val,'tree_limit_data',tld);
            paramSweep(sprintf('minSiftNorm,tld=%f',tld),handle,{0, 1, 25, 50, 75, 100, 200},1:5);
        case 'tarragon'
            handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val,'tree_limit_data',tld);
            paramSweep(sprintf('maxProductsPerCategory,tld=%f',tld),handle,{2,5,10,20,30,50,75,100,Inf},1:5);
        otherwise
            error('not a valid machine');
    end
end
%}

%{
% Run 4 Dec:
switch machine
    case 'chervil'
        handle = @(categories,val)getResults('categories',categories,'powerForSigma',val,'tree_limit_data',.01);
        paramSweep('powerForSigma',handle,{.5,1},1:7);
        handle = @(categories,val)getResults('categories',categories,'maxViewsPerProduct',val,'tree_limit_data',.05);
        paramSweep('maxViewsPerProduct',handle,{1,2,3,4,5,6,Inf},1:4);
        handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val,'tree_limit_data',.05);
        paramSweep('fracTrainExToVote',handle,{.05, .1, .25, .5, .75, 1},1);
        handle = @(categories,val)getResults('categories',categories,'tree_K',val,'tree_limit_data',.05);
        paramSweep('tree_K',handle,{10, 25, 50, 100, 150, 200, 500, 1000},1);
    case 'cilantro'
        handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val,'tree_limit_data',.05);
        paramSweep('zScoreVoting',handle,{0,1},1:4);
        handle = @(categories,val)getResults('categories',categories,'signatureDistance',val,'tree_limit_data',.05);
        paramSweep('signatureDistance',handle,{'L1','cosine','expchi2'},1:4);
        handle = @(categories,val)getResults('categories',categories,'minSiftNorm',val,'tree_limit_data',.05);
        paramSweep('minSiftNorm',handle,{0, 1, 25, 50, 75, 100, 200},1:4);
        handle = @(categories,val)getResults('categories',categories,'tree_nleaves',val,'tree_limit_data',.05);
        paramSweep('tree_nleaves',handle,{500, 1000, 2000, 5000, 10000},1);
    case 'orange'
        handle = @(categories,val)getResults('categories',categories,'keypointDetector',val);
        paramSweep('keypointDetector',handle,{'none','canny'},1:7);
        handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val,'tree_limit_data',.05);
        paramSweep('maxProductsPerCategory',handle,{2,5,10,20,30,50,75},1:7);
    otherwise
        error('not a valid machine');
end
%}

%{
% Run 29 Nov:
switch machine
    case 'chervil'
        handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val);
        paramSweep('fracTrainExToVote',handle,{.05 .1 .25 .5 .75 1});
        handle = @(categories,val)getResults('categories',categories,'tree_K',val);
        paramSweep('tree_K',handle,{10, 25, 50, 100, 150, 200, 500, 1000});
        handle = @(categories,val)getResults('categories',categories,'maxViewsPerProduct',val);
        paramSweep('maxViewsPerProduct',handle,{0,1});
    case 'cilantro'
        handle = @(categories,val)getResults('categories',categories,'minSiftNorm',val);
        paramSweep('minSiftNorm',handle,{0, 1, 25, 50, 75, 100, 200});
        handle = @(categories,val)getResults('categories',categories,'tree_nleaves',val);
        paramSweep('tree_nleaves',handle,{500, 1000, 2000, 5000, 10000});
        handle = @(categories,val)getResults('categories',categories,'signatureDistance',val);
        paramSweep('signatureDistance',handle,{'L1','cosine','expchi2'});
        handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val);
        paramSweep('zScoreVoting',handle,{0,1});
    case 'orange'
        handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val);
        paramSweep('maxProductsPerCategory',handle,{1,5,10,15,20,30,50,75,100});
        handle = @(categories,val)getResults('categories',categories,'coeffForPhog',val);
        paramSweep('coeffForPhog',handle,{0, .1, .25, .5, .75, 1, 2, 4, 10, 100});
    case 'birds'
        handle = @(categories,val)getResults('categories',categories,'tree_K',val);
        paramSweep('tree_K',handle,{25,50,100},'listOfCategories',...
		   {{'Accipitridae-Accipiter-cirrocephalus','Accipitridae-Accipiter-fasciatus','Accipitridae-Accipiter-novaehollandiae','Accipitridae-Aquila-audax','Accipitridae-Aviceda-subcristata','Accipitridae-Circus-approximans','Accipitridae-Circus-assimilis','Accipitridae-Circus-spilonotus','Accipitridae-Elanus-axillaris','Accipitridae-Elanus-scriptus','Accipitridae-Haliaeetus-leucogaster','Accipitridae-Haliastur-indus','Accipitridae-Haliastur-sphenurus','Accipitridae-Hamirostra-melanosternon','Accipitridae-Hieraaetus-morphnoides','Accipitridae-Lophoictinia-isura','Accipitridae-Milvus-migrans','Accipitridae-Pandion-cristatus','Accipitridae-Pernis-ptilorhyncus','Ardeidae-Ardea-modesta','Ardeidae-Ardeola-bacchus','Ardeidae-Bubulcus-ibis','Ardeidae-Egretta-garzetta','Ardeidae-Egretta-novaehollandiae','Ardeidae-Egretta-sacra','Ardeidae-Ixobrychus-cinnamomeus','Ardeidae-Nycticorax-caledonicus','Ardeidae-Nycticorax-nycticorax','Charadriidae-Charadrius-dubius','Charadriidae-Charadrius-hiaticula','Charadriidae-Haematopus-fuliginosus','Charadriidae-Haematopus-longirostris','Charadriidae-Himantopus-leucocephalus','Charadriidae-Pluvialis-dominica','Charadriidae-Pluvialis-fulva','Charadriidae-Pluvialis-squatarola','Charadriidae-Vanellus-cinereus','Charadriidae-Vanellus-miles','Ciconiidae-Ephippiorhynchus-asiaticus','Falconidae-Falco-berigora','Falconidae-Falco-cenchroides','Falconidae-Falco-longipennis','Falconidae-Falco-peregrinus','Falconidae-Falco-subniger','Laridae-Anous-stolidus','Laridae-Chlidonias-hybridus','Laridae-Gygis-alba','Laridae-Larus-crassirostris','Laridae-Larus-dominicanus','Laridae-Larus-fuscus','Laridae-Larus-novaehollandiae','Laridae-Larus-pacificus','Laridae-Larus-pipixcan','Laridae-Larus-ridibundus','Laridae-Stercorarius-longicaudus','Laridae-Stercorarius-maccormicki','Laridae-Stercorarius-parasiticus','Laridae-Stercorarius-pomarinus','Laridae-Sterna-albifrons','Laridae-Sterna-anaethetus','Laridae-Sterna-bergii','Laridae-Sterna-caspia','Laridae-Sterna-fuscata','Laridae-Sterna-nereis','Laridae-Sterna-nilotica','Laridae-Sterna-paradisaea','Laridae-Sterna-striata','Laridae-Sterna-vittata','Laridae-Xema-sabini'},{'Accipitridae-Accipiter-cirrocephalus','Accipitridae-Accipiter-fasciatus'},{'Laridae-Xema-sabini','Falconidae-Falco-subniger'},{'Charadriidae-Vanellus-miles','Ciconiidae-Ephippiorhynchus-asiaticus','Falconidae-Falco-berigora','Falconidae-Falco-cenchroides'}});
    otherwise
        error('not a valid machine');
end
%}


%{
% Run 22-23 Nov:
switch machine
    case 'chervil'
        handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val);
        paramSweep('fracTrainExToVote',handle,{.05 .1 .25 .5 .75 1});
        handle = @(categories,val)getResults('categories',categories,'tree_K',val);
        paramSweep('tree_K',handle,{10, 25, 50, 100, 150, 200, 500, 1000});
        handle = @(categories,val)getResults('categories',categories,'useMultViews',val);
        paramSweep('useMultViews',handle,{0,1});
    case 'cilantro'
        handle = @(categories,val)getResults('categories',categories,'minSiftNorm',val);
        paramSweep('minSiftNorm',handle,{0, 1, 25, 50, 75, 100, 200});
        handle = @(categories,val)getResults('categories',categories,'tree_nleaves',val);
        paramSweep('tree_nleaves',handle,{500, 1000, 2000, 5000, 10000});
        handle = @(categories,val)getResults('categories',categories,'signatureDistance',val);
        paramSweep('signatureDistance',handle,{'L1','cosine','expchi2'});
        handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val);
        paramSweep('zScoreVoting',handle,{0,1});
    case 'orange'
        handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val);
        paramSweep('maxProductsPerCategory',handle,{1,5,10,15,20,30,50,75,100});
        handle = @(categories,val)getResults('categories',categories,'coeffForPhog',val);
        paramSweep('coeffForPhog',handle,{0, .1, .25, .5, .75, 1, 2, 4, 10, 100});
    otherwise
        error('not a valid machine');
end
%}

%{
% Run 22-23 Nov:
switch machine
    case 'chervil'
        handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val);
        paramSweep('fracTrainExToVote',handle,{.05 .1 .25 .5 .75 1});
        handle = @(categories,val)getResults('categories',categories,'tree_K',val,'forceRebuildTree',1);
        paramSweep('tree_K',handle,{10, 25, 50, 75, 100, 150, 200});
    case 'cilantro'
        handle = @(categories,val)getResults('categories',categories,'minSiftNorm',val);
        paramSweep('minSiftNorm',handle,{0, 1, 50, 100, 200});
        handle = @(categories,val)getResults('categories',categories,'tree_nleaves',val);
        paramSweep('tree_nleaves',handle,{500, 1000, 2000, 5000, 10000});
    case 'orange'
        handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val);
        paramSweep('maxProductsPerCategory',handle,{5,10,15,20,30,50,70,90});
        handle = @(categories,val)getResults('categories',categories,'coeffForPhog',val);
        paramSweep('coeffForPhog',handle,{0, .1, .25, .5, .75, 1, 2, 4, 10, 100});
    otherwise
        error('not a valid machine');
end
%}

%{
% Run 20-21 Nov:
switch machine
    case 'chervil'
        handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val);
        paramSweep('fracTrainExToVote',handle,{.05 .1 .25 .5 .75 1});
        handle = @(categories,val)getResults('categories',categories,'tree_K',val,'forceRebuildTree',1);
        paramSweep('tree_K',handle,{10, 20, 30, 50});
    case 'cilantro'
        handle = @(categories,val)getResults('categories',categories,'signatureDistance',val);
        paramSweep('signatureDistance',handle,{'L1','cosine','expchi2'});
        handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val);
        paramSweep('zScoreVoting',handle,{0,1});
        handle = @(categories,val)getResults('categories',categories,'tree_nleaves',val);
        paramSweep('tree_nleaves',handle,{500, 1000, 2000, 5000, 10000});
    case 'orange'
        handle = @(categories,val)getResults('categories',categories,'maxProductsPerCategory',val);
        paramSweep('maxProductsPerCategory',handle,{5,10,15,20,30,50,70,90});
        handle = @(categories,val)getResults('categories',categories,'coeffForPhog',val);
        paramSweep('coeffForPhog',handle,{0, .1, .25, .5, .75, 1, 2, 4, 10, 100});
    otherwise
        error('not a valid machine');
end
%}

% Run on Tues, 18 Nov:
%{
switch machine
    case 'chervil'
        handle = @(categories,val)getResults('categories',categories,'fracTrainExToVote',val);
        paramSweep('fracTrainExToVote',handle,{.05 .1 .25 .5 .75 1});
        handle = @(categories,val)getResults('categories',categories,'tree_K',val);
        paramSweep('tree_K',handle,{10, 20, 30, 50});
    case 'cilantro'
        handle = @(categories,val)getResults('categories',categories,'signatureDistance',val);
        paramSweep('signatureDistance',handle,{'L1','cosine','expchi2'});
        handle = @(categories,val)getResults('categories',categories,'zScoreVoting',val);
        paramSweep('zScoreVoting',handle,{0,1});
        handle = @(categories,val)getResults('categories',categories,'tree_nleaves',val);
        paramSweep('tree_nleaves',handle,{500, 1000, 2000, 5000, 10000, 50000});
    case 'orange'
        handle = @(categories,val)getResults('categories',categories,'fracDataTestOn',val);
        paramSweep('fracDataTestOn',handle,{.1, .25, .5, .9});
    otherwise
        error('not a valid machine');
end
%}

%{
% Run on Sunday - Monday, 16-17 Nov:

categories = {{'velcro','laces'},...
    {'pointy','nonpointy'},...
    {'balletanddance','basesoftball','boating'}};

for cat = 1:length(categories)
    switch machine
        case 'chervil'
            for k = [10 20 30 50]
                getResults('categories',categories{cat},'tree_K',k);
            end
        case 'cilantro'
            for n = [500 1000 2000 5000 10000 50000]
                getResults('categories',categories{cat},'tree_nleaves',n);
            end
        case 'orange'
            for f = [.05 .1 .25 .5 .9 1]
                getResults('categories',categories{cat},'fracTrainExToVote',f);
            end
        otherwise
            warning('Not a valid machine!');
            getResults('categories',categories{cat});
    end
end
%}


%{
    Run on Saturday - Sunday, 15-16 Nov:

    categories = {{'velcro','laces'},...
        {'pointy','nonpointy'},...
        {'balletanddance','basesoftball','boating'},...
        {'balletanddance','basesoftball'},...
        {'balletanddance','boating'},...
        {'basesoftball','boating'}};

    for tld = [.1, .5, 1]
        for cat = 1:length(categories)
            switch machine
                case 'chervil'
                    for f = [.05 .1 .25 .5 .75 1]
                        getResults('categories',categories{cat},'tree_limit_data',tld,'fracTrainExToVote',f);
                    end
                case 'cilantro'
                    d = {'L1','cosine','expchi2'};
                    for i = 1:length(d)
                        getResults('categories',categories{cat},'tree_limit_data',tld,'signatureDistance',d{i});
                    end
                    getResults('categories',categories{cat},'tree_limit_data',tld,'zScoreVoting',0,'fracTrainExToVote',.25);
                case 'orange'
                    for f = [.1 .5 .9]
                        getResults('categories',categories{cat},'tree_limit_data',tld,'fracDataTestOn',f);
                    end
                otherwise
                    warning('Not a valid machine!');
                    getResults('categories',categories{cat},'tree_limit_data',tld);
            end
        end
    end
%}

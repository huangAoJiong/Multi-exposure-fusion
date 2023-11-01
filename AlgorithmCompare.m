clear all;clc;
name={'Dataset_Part2(1)'};
dataset = strcat('E:\数据集\HDR图像数据集', filesep, name, filesep, '*.*');
outImgFolder='outputImg';
mkdir(outImgFolder);
for i=1:length(name)
    mkdir([outImgFolder,filesep,name{i}]);
end
% specify methods and metrics
method = {@exposure_fusion};
metric = {}; 
% metric = {@loe100x100 @vif}; % NOTE matlabPyrTools is required to run VIF metric (vif.m).

for n = 1:numel(dataset) %for each dataset
    datasetName=dataset{n};
    filenames=dir(datasetName);
    for i=3:length(filenames)  %for each file in a dataset
        if mod(str2double(filenames(i).name),5)~=0
            continue;
        end
        fullFileName=fullfile(filenames(i).folder,filesep,filenames(i).name);
        I=load_images(fullFileName);
        if (size(I,1)>1200)
            I=imresize(I,1200/size(I,1));
        end
        if (size(I,2)>1600)
            I=imresize(I,1600/size(I,2));
        end
        
        methodIdx=0;
       for m=1:length(method) %for each kind of algorithm
           methodIdx=methodIdx+1;
           func=method{m};
           [outImg,outImg1]=func(I);
           
           %保存图像
           saveFileName=strcat(filenames(i).name,'_',func2str(method{m}),'.png');
           saveFilePath=strcat(outImgFolder,filesep,name{n},filesep,saveFileName);
           imwrite(outImg,saveFilePath);
           saveFileName1=strcat(filenames(i).name,'_',func2str(method{m}),'1.png');
           saveFilePath1=strcat(outImgFolder,filesep,name{n},filesep,saveFileName1);
           imwrite(outImg1,saveFilePath1);
       end
    end
end

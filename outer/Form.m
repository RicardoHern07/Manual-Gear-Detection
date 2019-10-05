classdef Form
    methods(Static=true)
        % References: 
        %       Source: https://www.mathworks.com/matlabcentral/answers/424785-how-to-make-a-video-out-of-sequenced-images-in-order
        %       Author: Image Analyst
        %
        %       Source: https://www.mathworks.com/matlabcentral/answers/101413-how-can-i-add-text-to-an-image-and-make-the-text-become-part-of-the-image-within-matlab
        %       Author: MathWorks Support Team (Staff)
        %
        
        % load('data/svm/svmStruct_rbf.mat');
        % load('data/svm/svmStruct_linear.mat');
        % Form.Images2Video(['data/test_gears/'], ['video_data/'],svmStruct_rbf);
        % Form.Images2Video(['data/test_gears/'], ['video_data/'],svmStruct_linear);
        function []= Images2Video(in_path,svmStruct)
            filePattern = fullfile(in_path, '*.tif');
            tifFiles=dir(filePattern);
            writerObj=VideoWriter('Gear Output Final');
            writerObj.FrameRate=30;
            open(writerObj);
            
            tic;
            for i=1:length(tifFiles)
                filename=[sprintf('%d',i-1) '.tif'];
                fullname=fullfile(in_path,filename);
                
                img=imread(fullname);
                
                hog = Prior.hog_single(img);
                [label, PostProbs] = predict(svmStruct, hog);
                score = PostProbs(:,1);
                
                if strcmp('0', label)
                    img=insertText(img,[1 1],'Neutral');
                elseif strcmp('7', label)
                    img=insertText(img,[1 1],'Switch');
                elseif strcmp('-1', label) 
                    img=insertText(img,[1 1],'Reverse');
                elseif strcmp('1', label) 
                    img=insertText(img,[1 1],'First');
                elseif strcmp('2', label)
                    img=insertText(img,[1 1],'Second');
                elseif strcmp('3', label)
                    img=insertText(img,[1 1],'Third');
                elseif strcmp('4', label)
                    img=insertText(img,[1 1],'Fourth');
                elseif strcmp('5', label)
                    img=insertText(img,[1 1],'Fifth');
                end
                
                drawnow;
                writeVideo(writerObj,img);
            end
            close(writerObj);
            toc; % 361.31 seconds
        end
    end
end


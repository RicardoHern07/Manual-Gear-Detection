classdef PreProc
    %%%% This is a class containing material from Digital Image Processing class by Hongkai Yu.
    methods(Static=true)
        % Perform First
        % sample call for ground data: PreProc.ParseVideo2Images(['video_data/Ground Data.wmv'], ['data/ground_gears/'], 1);
        % sample call for test data: PreProc.ParseVideo2Images(['video_data/Test Data.wmv'], ['data/test_gears/'], 1);
        function []= ParseVideo2Images(video_path,output_images, frame_start_save)
            mov=VideoReader(video_path);
            tic;
            for i=1:mov.NumberOfFrames
                if i<frame_start_save
                    continue;
                end
                img=read(mov,i);
                img=rgb2gray(img);
                filename=[sprintf('%d',i-1) '.tif'];
                fullname=fullfile(output_images,filename);
                imwrite(img,fullname);
            end
            toc; % 213.15 seconds for 19,658 images | 261.90 seconds for 14,051 images
        end
        %----------------------------------------------------------------------------
        
        % Perform Second 
        % Note: Read comments on lines 30-35 before executing both sample
        % calls
        % sample call to produce ground truth mats: PreProc.ConstructMat(['data/ground_gear_ranges/neutral'], ['data/ground_gear_ranges/switch'], ['data/ground_gear_ranges/reverse'], ['data/ground_gear_ranges/first'], ['data/ground_gear_ranges/second'], ['data/ground_gear_ranges/third'], ['data/ground_gear_ranges/fourth'], ['data/ground_gear_ranges/fifth'], ['data/ground_gears_mat/']);
        % sample call to produce test mats: PreProc.ConstructMat(['data/test_gear_ranges/neutral'], ['data/test_gear_ranges/switch'], ['data/test_gear_ranges/reverse'], ['data/test_gear_ranges/first'], ['data/test_gear_ranges/second'], ['data/test_gear_ranges/third'], ['data/test_gear_ranges/fourth'], ['data/test_gear_ranges/fifth'], ['data/test_gears_mat/']);
        function []= ConstructMat(neutral_path, switch_path, reverse_path, first_path, second_path, third_path, fourth_path, fifth_path, out_path)
            % Images should be categorized by the user by visually
            % scanning the /data/ground_gears/ and /data/test_gears/ folders and placing them in
            % corresponding folders such as in the /data/ground_gear_ranges/ folder or the /data/test_gear_ranges/ folder
            % These subfolders will include additional subfolders, each dedicated to holding the classifications defined.
            % For ground truth, the greater the number of images the better
            % For test, lesser amounts of images are fine
            
            PreProc.DispMessage('Neutral', neutral_path, out_path);
            PreProc.DispMessage('Switch', switch_path, out_path);
            PreProc.DispMessage('Reverse', reverse_path, out_path);
            PreProc.DispMessage('First', first_path, out_path);
            PreProc.DispMessage('Second', second_path, out_path);
            PreProc.DispMessage('Third', third_path, out_path);
            PreProc.DispMessage('Fourth', fourth_path, out_path);
            PreProc.DispMessage('Fifth', fifth_path, out_path);
            clc;
            close all;
        end
        %----------------------------------------------------------------------------
        
        % Function used to prompt user for a range of images that feature a
        % the corresponding gear
        function DispMessage(gear, in_path, out_path)
            fprintf('Creating %s Gear Mat\n',gear);
            
            PreProc.ConvertImages2Mat(gear, in_path, out_path);
            
        end
        %----------------------------------------------------------------------------
        
        % Function used to store images into a mat file
        % Reference: https://www.mathworks.com/matlabcentral/answers/49954-how-to-create-a-single-mat-file-from-multiple-images
        % Author: Azzi Abdelmalek
        function ConvertImages2Mat(gear, in_path, out_path)
            n=PreProc.CurrentGear(gear);
            
            filePattern = fullfile(in_path, '*.tif');
            tifFiles=dir(filePattern);
            
            for i=1:length(tifFiles)
                filename=[sprintf('%s', tifFiles(i).name)];
                fullname=fullfile(in_path,filename);
                
                if n==0
                    neutral_mat{i}=imread(fullname);
                elseif n==7
                    switch_mat{i}=imread(fullname);
                elseif n==-1
                    reverse_mat{i}=imread(fullname);
                elseif n==1
                    first_mat{i}=imread(fullname);
                elseif n==2
                    second_mat{i}=imread(fullname);
                elseif n==3
                    third_mat{i}=imread(fullname);
                elseif n==4
                    fourth_mat{i}=imread(fullname);
                elseif n==5
                    fifth_mat{i}=imread(fullname);
                end
            end
            
            % Reference: https://www.mathworks.com/matlabcentral/answers/292406-how-to-save-the-output-in-a-certain-folder
            % Author: Chad Greene
            if n==0
                out_path=strcat(out_path,'neutral_mat');
                save(out_path,'neutral_mat');
            elseif n==7
                out_path=strcat(out_path,'switch_mat');
                save(out_path,'switch_mat');
            elseif n==-1
                out_path=strcat(out_path,'reverse_mat');
                save(out_path,'reverse_mat');
            elseif n==1
                out_path=strcat(out_path,'first_mat');
                save(out_path,'first_mat');
            elseif n==2
                out_path=strcat(out_path,'second_mat');
                save(out_path,'second_mat');
            elseif n==3
                out_path=strcat(out_path,'third_mat');
                save(out_path,'third_mat');
            elseif n==4
                out_path=strcat(out_path,'fourth_mat');
                save(out_path,'fourth_mat');
            elseif n==5
                out_path=strcat(out_path,'fifth_mat');
                save(out_path,'fifth_mat');
            end
        end
        %----------------------------------------------------------------------------
        
        % Function used to compare strings, returns integer for simpler
        % comparison
        function n=CurrentGear(gear)
            if strcmpi(gear,'Neutral')
                n=0;
            elseif strcmpi(gear,'Switch')
                n=7;
            elseif strcmpi(gear,'Reverse')
                n=-1;
            elseif strcmpi(gear,'First')
                n=1;
            elseif strcmpi(gear,'Second')
                n=2;
            elseif strcmpi(gear,'Third')
                n=3;
            elseif strcmpi(gear,'Fourth')
                n=4;
            elseif strcmpi(gear,'Fifth')
                n=5;
            end
        end
    end
end


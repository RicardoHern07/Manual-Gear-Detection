% This is a class for SVM training and testing, 
% Computer Vision & Intelligent Transportation System Lab
% University of Texas - Rio Grande Valley, 02/2019
% contact: hongkai.yu@utrgv.edu

% Modified by: Ricardo Hernandez

classdef Prior 
  methods(Static=true)
    %---------------------------------------------------------------------------    
    % Perform second (optional)
    % test trained svm on patch images (gray)
    % load('data/svm/svmStruct_rbf.mat');
    % load('data/svm/svmStruct_linear.mat');
    % Prior.TestSVM(svmStruct_rbf, 'data/test_gears_mat/neutral_mat.mat', 'data/test_gears_mat/switch_mat','data/test_gears_mat/reverse_mat.mat', 'data/test_gears_mat/first_mat.mat', 'data/test_gears_mat/second_mat.mat', 'data/test_gears_mat/third_mat.mat','data/test_gears_mat/fourth_mat.mat','data/test_gears_mat/fifth_mat.mat')
    % Prior.TestSVM(svmStruct_linear, 'data/test_gears_mat/neutral_mat.mat', 'data/test_gears_mat/switch_mat','data/test_gears_mat/reverse_mat.mat', 'data/test_gears_mat/first_mat.mat', 'data/test_gears_mat/second_mat.mat', 'data/test_gears_mat/third_mat.mat','data/test_gears_mat/fourth_mat.mat','data/test_gears_mat/fifth_mat.mat')
    function TestSVM(svmStruct, neutral_mat,switch_mat,reverse_mat,first_mat,second_mat,third_mat,fourth_mat,fifth_mat)
        
        load(neutral_mat);
        load(switch_mat);
        load(reverse_mat);
        load(first_mat);
        load(second_mat);
        load(third_mat);
        load(fourth_mat);
        load(fifth_mat);
        
        clc;
        disp('Testing Neutral Samples');
        gear='0';
        neutral_score=Prior.test_mat(svmStruct,neutral_mat,gear);
        fprintf('Accuracy: %f \n',neutral_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
                
        disp('Testing Switch Samples');
        gear='7';
        switch_score=Prior.test_mat(svmStruct,switch_mat,gear);
        fprintf('Accuracy: %f \n',switch_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        disp('Testing Reverse Samples');
        gear='-1';
        reverse_score=Prior.test_mat(svmStruct,reverse_mat,gear);
        fprintf('Accuracy: %f \n',reverse_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        disp('Testing First Samples');
        gear='1';
        first_score=Prior.test_mat(svmStruct,first_mat,gear);
        fprintf('Accuracy: %f \n',first_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        disp('Testing Second Samples');
        gear='2';
        second_score=Prior.test_mat(svmStruct,second_mat,gear);
        fprintf('Accuracy: %f \n',second_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        disp('Testing Third Samples');
        gear='3';
        third_score=Prior.test_mat(svmStruct,third_mat,gear);
        fprintf('Accuracy: %f \n',third_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        disp('Testing Fourth Samples');
        gear='4';
        fourth_score=Prior.test_mat(svmStruct,fourth_mat,gear);
        fprintf('Accuracy: %f \n',fourth_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        disp('Testing Fifth Samples');
        gear='5';
        fifth_score=Prior.test_mat(svmStruct,fifth_mat,gear);
        fprintf('Accuracy: %f \n',fifth_score);
        disp('Press Any Key to Continue');
        pause;
        clc;
    end
    %---------------------------------------------------------------------------
    % Perform First
    % Ensure that mat files have been created or present prior to execution
    % sample call: Prior.TrainSVM('data/ground_gears_mat/neutral_mat.mat', 'data/ground_gears_mat/switch_mat','data/ground_gears_mat/reverse_mat.mat', 'data/ground_gears_mat/first_mat.mat', 'data/ground_gears_mat/second_mat.mat', 'data/ground_gears_mat/third_mat.mat','data/ground_gears_mat/fourth_mat.mat','data/ground_gears_mat/fifth_mat.mat');
    function TrainSVM(neutral_mat,switch_mat,reverse_mat,first_mat,second_mat,third_mat,fourth_mat,fifth_mat)
       load(neutral_mat);
       load(switch_mat);
       load(reverse_mat);
       load(first_mat);
       load(second_mat);
       load(third_mat);
       load(fourth_mat);
       load(fifth_mat);
       
       clc;
       
       neutral=[];
       neutral_label={};
       parfor i=1:length(neutral_mat);
           box_img=neutral_mat{i};
           hog=Prior.hog_single(box_img);
           neutral(i,:)=hog;
           neutral_label{i}='0';%'neutral';
       end
       disp('neutral samples are extracted...');
       
       switxh=[];
       switch_label={};
       parfor i=1:length(switch_mat)
           box_img=switch_mat{i};
           hog=Prior.hog_single(box_img);
           switxh(i,:)=hog;
           switch_label{i}='7';%'switch';
       end
       disp('switch samples are extracted...');
       
        reverse=[];
        reverse_label={};
        parfor i=1:length(reverse_mat)
            box_img=reverse_mat{i};
            hog = Prior.hog_single(box_img);
            reverse(i,:)=hog;
            reverse_label{i}='-1';%'reverse';
        end
        disp('reverse samples are extracted...');
        
        first=[];
        first_label={};
        parfor i=1:length(first_mat)
            box_img=first_mat{i};                
            hog = Prior.hog_single(box_img);
            first(i,:)=hog;
            first_label{i}='1';%'first';
        end
        disp('first samples are extracted...');        
        
        second=[];
        second_label={};
        parfor i=1:length(second_mat)
            box_img=second_mat{i};               
            hog = Prior.hog_single(box_img);
            second(i,:)=hog;
            second_label{i}='2';%'second';
        end
        disp('second samples are extracted...');        
        
        third=[];
        third_label={};
        parfor i=1:length(third_mat)
            box_img=third_mat{i};                
            hog = Prior.hog_single(box_img);
            third(i,:)=hog;
            third_label{i}='3';%'third';
        end
        disp('third samples are extracted...');        
        
        fourth=[];
        fourth_label={};
        parfor i=1:length(fourth_mat)
            box_img=fourth_mat{i};                
            hog = Prior.hog_single(box_img);
            fourth(i,:)=hog;
            fourth_label{i}='4';%'fourth';
        end
        disp('fourth samples are extracted...');        
        
        fifth=[];
        fifth_label={};
        parfor i=1:length(fifth_mat)
            box_img=fifth_mat{i};                
            hog = Prior.hog_single(box_img);
            fifth(i,:)=hog;
            fifth_label{i}='5'%'fifth';
        end
        disp('fifth samples are extracted...');        
        
        
        hog=[neutral; switxh; reverse; first; second; third; fourth; fifth];
        fprintf('hog feature size: %d, %d\n', size(hog,1), size(hog,2));  
        
        disp('Press Any Key to Continue');
        pause;
        clc;
        
        all_data = hog;
        all_label=[neutral_label,switch_label,reverse_label,first_label,second_label,third_label,fourth_label,fifth_label];  
        
        % shuffle all the data
        random_position = randperm(length(all_label));
        all_data=all_data(random_position, :);
        
        tmp=[];
        for k=1:length(all_label)
            tmp{k} = all_label{random_position(k)};
        end
        all_label = tmp;
        
        seed = datasample(1:length(all_label), floor(0.2*length(all_label) ), 'Replace', false ); % testing set seed
        
        id_train=1;
        id_test=1;
        for j = 1: length(all_label) 
             if ismember(j,seed)    % in testing seed
                 test_data(id_test,:) = all_data(j,:);
                 test_label{id_test}= all_label{j};
                 id_test = id_test+1;
             else
                 train_data(id_train,:)  = all_data(j,:);
                 train_label{id_train} = all_label{j};
                 id_train = id_train+1;
             end
        end
        
        % Reference: https://www.mathworks.com/help/stats/fitcecoc.html
        % Multi-Class svm trainer
        tic;
        svmStruct_linear = fitcecoc(train_data, train_label);
        disp('Time to train linear svm model: ');
        toc
        
        % Reference: https://www.researchgate.net/post/How_to_use_fitcecoc_in_matlab_with_rpf
        % Author: Fardin Mirzapour
       
        svmParams = templateSVM('KernelFunction','rbf', 'KernelScale', 'auto', 'Standardize', 1);
        tic;
        svmStruct_rbf = fitcecoc(train_data, train_label, 'Learners', svmParams, 'Coding', 'onevsall');
        disp('Time to train rbf svm model: ');
        toc
        
        
        % for old matlab version: predict = ClassificationSVM(svmStruct_linear,test_data);
        CompactSVMModel = compact(svmStruct_linear);
        
        [label1, PostProbs1] = predict(svmStruct_linear,test_data);
        score1=PostProbs1(:,1); % positive class posterior probabilities
        
        correct=0;
        for i=1:length(label1)
            if test_label{i}==label1{i}%strcmp(test_label{i},label1{i})
                correct=correct+1;
            end
        end
        fprintf('validation accuracy for svm linear is %f \n', correct/length(label1));
        % validation accuracy by linear-kernel svm
       
        
        % for old matlab version: predict = ClassificationSVM(svmStruct_rbf,test_data);
        CompactSVMModel2 = compact(svmStruct_rbf);
        [label2, PostProbs2] = predict(svmStruct_rbf,test_data);
        score2=PostProbs2(:,1); % positive class posterior probabilities
       
        correct=0;
        for i=1:length(label2)
            if test_label{i}==label2{i}%strcmp(test_label{i},label2{i})
                correct=correct+1;
            end
        end
        fprintf('validation accuracy for svm rbf is %f \n', correct/length(label2));
        % validation accuracy by rbf-kernel svm
        
        save(['data/svm/svmStruct_rbf.mat'], 'svmStruct_rbf');
        save(['data/svm/svmStruct_linear.mat'], 'svmStruct_linear');
    end
    %---------------------------------------------------------------------------   
    function hog = hog_single(box_img)
        Im_gray = box_img;    
        [hog,hog_visualization] = extractHOGFeatures(Im_gray,'CellSize',[15,15]);         
    end
    %---------------------------------------------------------------------------
    function out = hog_distance(im1, im2, size)
       if nargin==2
           size=[250,320]; % to-do: change a reasonable size for other tasks
       end
       Im1_gray=imresize(im1, size);
       Im2_gray=imresize(im2, size);
       [hog1,~] = extractHOGFeatures(Im1_gray,'CellSize',[5 5]);
       [hog2,~] = extractHOGFeatures(Im2_gray,'CellSize',[5 5]);
       feature1=[hog1];
       feature2=[hog2];
       out.l1distance=sum(abs(feature1-feature2));
       out.l2distance=sqrt(sum((feature1-feature2).^2));
    end
    %---------------------------------------------------------------------------
    function result = test_mat(svmStruct,mat,gear)
        result=0;
        for i=1:length(mat)
           img=mat{i};
           hog = Prior.hog_single(img);
           [label, PostProbs] = predict(svmStruct, hog);
           
           if strcmp(gear,label)
               result = result + 1;
           end
        end
        result=(result)/(length(mat));
    end
  end
end

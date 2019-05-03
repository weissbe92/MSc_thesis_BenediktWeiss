%process all available data

%% define subjects (without sub-09, 10, 18 --> not enough activation during voi-extraction)
subject_list = {'sub-03','sub-04','sub-05','sub-06','sub-07','sub-08','sub-11','sub-12','sub-13','sub-14','sub-15','sub-16','sub-17','sub-19','sub-20','sub-21','sub-22','sub-23','sub-24'};

%% define B-matrices (27 in 3 families)

%     HG_l HG_r PT_l PT_r PP_l PP_r
%     HG_r
%     PT_l
%     PT_r
%     PP_l
%     PP_r

B_matrix_A_1= [1 0 0 0 1 0;
               1 1 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               1 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_A_2= [1 0 1 0 1 0;
               1 1 0 0 0 0;
               1 0 0 0 0 0;
               0 0 1 0 0 0;
               1 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_A_3= [1 0 1 0 0 0;
               1 1 0 0 0 0;
               1 0 0 0 0 0;
               0 0 1 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_A_4= [1 0 0 0 1 0;
               1 1 0 0 0 1;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               1 0 0 0 0 0;
               0 1 0 0 0 0]; 

B_matrix_A_5= [1 0 1 0 1 0;
               1 1 0 1 0 1;
               1 0 0 1 0 0;
               0 1 1 0 0 0;
               1 0 0 0 0 0;
               0 1 0 0 0 0];                   

B_matrix_A_6= [1 0 1 0 0 0;
               1 1 0 1 0 0;
               1 0 0 1 0 0;
               0 1 1 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0];                    

B_matrix_A_7= [1 0 0 0 0 0;
               1 1 0 0 0 1;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               0 1 0 0 0 0]; 

B_matrix_A_8= [1 0 0 0 0 0;
               1 1 0 1 0 1;
               0 0 0 1 0 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 1 0 0 0 0];                    

B_matrix_A_9= [1 0 0 0 0 0;
               1 1 0 1 0 0;
               0 0 0 1 0 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0];                    

B_matrix_B_1= [1 1 0 0 1 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               1 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_B_2= [1 1 1 0 1 0;
               0 1 0 0 0 0;
               1 0 0 0 0 0;
               0 0 1 0 0 0;
               1 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_B_3= [1 1 1 0 0 0;
               0 1 0 0 0 0;
               1 0 0 0 0 0;
               0 0 1 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_B_4= [1 1 0 0 1 0;
               0 1 0 0 0 1;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               1 0 0 0 0 0;
               0 1 0 0 0 0]; 

B_matrix_B_5= [1 1 1 0 1 0;
               0 1 0 1 0 1;
               1 0 0 1 0 0;
               0 1 1 0 0 0;
               1 0 0 0 0 0;
               0 1 0 0 0 0];                   

B_matrix_B_6= [1 1 1 0 0 0;
               0 1 0 1 0 0;
               1 0 0 1 0 0;
               0 1 1 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0];                    

B_matrix_B_7= [1 1 0 0 0 0;
               0 1 0 0 0 1;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               0 1 0 0 0 0]; 

B_matrix_B_8= [1 1 0 0 0 0;
               0 1 0 1 0 1;
               0 0 0 1 0 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 1 0 0 0 0];                    

B_matrix_B_9= [1 1 0 0 0 0;
               0 1 0 1 0 0;
               0 0 0 1 0 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0];                     

B_matrix_C_1= [1 1 0 0 1 0;
               1 1 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               1 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_C_2= [1 1 1 0 1 0;
               1 1 0 0 0 0;
               1 0 0 0 0 0;
               0 0 1 0 0 0;
               1 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_C_3= [1 1 1 0 0 0;
               1 1 0 0 0 0;
               1 0 0 0 0 0;
               0 0 1 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrix_C_4= [1 1 0 0 1 0;
               1 1 0 0 0 1;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               1 0 0 0 0 0;
               0 1 0 0 0 0]; 

B_matrix_C_5= [1 1 1 0 1 0;
               1 1 0 1 0 1;
               1 0 0 1 0 0;
               0 1 1 0 0 0;
               1 0 0 0 0 0;
               0 1 0 0 0 0];                   

B_matrix_C_6= [1 1 1 0 0 0;
               1 1 0 1 0 0;
               1 0 0 1 0 0;
               0 1 1 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0];                    

B_matrix_C_7= [1 1 0 0 0 0;
               1 1 0 0 0 1;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0;
               0 1 0 0 0 0]; 

B_matrix_C_8= [1 1 0 0 0 0;
               1 1 0 1 0 1;
               0 0 0 1 0 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 1 0 0 0 0];                    

B_matrix_C_9= [1 1 0 0 0 0;
               1 1 0 1 0 0;
               0 0 0 1 0 0;
               0 1 0 0 0 0;
               0 0 0 0 0 0;
               0 0 0 0 0 0]; 

B_matrices = {B_matrix_A_1, B_matrix_A_2, B_matrix_A_3, B_matrix_A_4, B_matrix_A_5, B_matrix_A_6, B_matrix_A_7, B_matrix_A_8, B_matrix_A_9, B_matrix_B_1, B_matrix_B_2, B_matrix_B_3, B_matrix_B_4, B_matrix_B_5, B_matrix_B_6, B_matrix_B_7, B_matrix_B_8, B_matrix_B_9, B_matrix_C_1, B_matrix_C_2, B_matrix_C_3, B_matrix_C_4, B_matrix_C_5, B_matrix_C_6, B_matrix_C_7, B_matrix_C_8, B_matrix_C_9};

%% define path to subject_data
for sub = 1:length(subject_list)
    for sess = 1:4
        
        data_path=fullfile('/home/prakt23/contrasts_allcond/contrasts',subject_list{sub});
    
        try cd(data_path);
        catch, display(strcat('subject ',subject_list{sub},' not existend')); continue;
        end    

        clear DCM


        %% Load SPM.mat (same for all 4 runs/sessions)
        try load(fullfile('/home/prakt23/contrasts_allcond/contrasts',subject_list{sub},'SPM.mat'));
        catch, display(strcat('subject ',subject_list{sub},' has no SPM.mat')); continue;                                
        end    
    
        %% Load regions of interest (6 regions*4 runs/sessions each --> 24 VOI.mat-files) 
        try 
            load(fullfile(data_path,strcat('VOI_lhHG_',num2str(sess),'.mat')),'xY');
            DCM.xY(1) = xY;
            load(fullfile(data_path,strcat('VOI_rhHG_',num2str(sess),'.mat')),'xY'); 
            DCM.xY(2) = xY;
            load(fullfile(data_path,strcat('VOI_lhPT_',num2str(sess),'.mat')),'xY'); 
            DCM.xY(3) = xY;
            load(fullfile(data_path,strcat('VOI_rhPT_',num2str(sess),'.mat')),'xY'); 
            DCM.xY(4) = xY;
            load(fullfile(data_path,strcat('VOI_lhPP_',num2str(sess),'.mat')),'xY'); 
            DCM.xY(5) = xY;
            load(fullfile(data_path,strcat('VOI_rhPP_',num2str(sess),'.mat')),'xY'); 
            DCM.xY(6) = xY;
            
        
        catch
            display(strcat('subject ',subject_list{sub},' has not all VOIs')); continue;
        end  
        
        DCM.n = length(DCM.xY);      % number of regions
        DCM.v = length(DCM.xY(sess).u); % number of time points

        %% Time series

        DCM.Y.dt  = SPM.xY.RT;
        DCM.Y.X0  = DCM.xY(1).X0;
        for i = 1:DCM.n
            DCM.Y.y(:,i)  = DCM.xY(i).u;
            DCM.Y.name{i} = DCM.xY(i).name;
        end

        DCM.Y.Q    = spm_Ce(ones(1,DCM.n)*DCM.v);

        %% Experimental inputs

        DCM.U.dt   =  SPM.Sess(sess).U(4).dt; % braucht man nur 1x
        % die Regressoren allcon, voice, singing, music
        DCM.U.name = [SPM.Sess(sess).U(4).name,SPM.Sess(sess).U(1).name,SPM.Sess(sess).U(2).name,SPM.Sess(sess).U(3).name]; 
        DCM.U.u    = [SPM.Sess(sess).U(4).u(33:end,1),SPM.Sess(sess).U(1).u(33:end,1),SPM.Sess(sess).U(2).u(33:end,1),SPM.Sess(sess).U(3).u(33:end,1)];
    

         
        
        %% DCM parameters and options

        DCM.delays = repmat(SPM.xY.RT/2,DCM.n,1); 
        DCM.TE     = 0.025;                   

        DCM.options.nonlinear  = 0;                 
        DCM.options.two_state  = 0;                
        DCM.options.stochastic = 0;                 
        DCM.options.nograph    = 1;                 


        %% Matrix definitions
        % ROI-order in rows/colums: lhHG, rhHG, lhPT, rhPT, lhPP, rhPP
         
        % design-matrix for fixed intrinsic connections (A-matrix)
        % model intrinsic connectivity for all regions (negative self-regulation)
        for matrix=1:length(B_matrices)
        
            DCM.a = [1 1 1 0 1 0;
                     1 1 0 1 0 1;
                     1 0 1 1 0 0;
                     0 1 1 1 0 0;
                     1 0 0 0 1 0;
                     0 1 0 0 0 1]; 
             
         
            DCM.b = zeros(6,6,4); % 1. dim: zielregion, 2. dim: source reg 3. dim: regressor index        
		
            DCM.b(:,:,2) = B_matrices{matrix};
            DCM.b(:,:,3) = B_matrices{matrix};
            DCM.b(:,:,4) = B_matrices{matrix};    
          
              	
            % driving input of the 3 regressors (columns) into both HGs (2nd and 5th row)
            DCM.c = [1,0,0,0;
                     1,0,0,0;
                     0,0,0,0;
                     0,0,0,0;
                     0,0,0,0;
                     0,0,0,0];
                 
            DCM.d = zeros(6,6,0);
        
        
        %% save specified model
        % name and save the spm for spefific model estimation after each model in each session for each subject
            if matrix <= 9
                save(strcat('/home/prakt23/dcm_2ndtry/',subject_list{sub},'/DCM_',subject_list{sub},'_run-',num2str(sess),'_model-0',num2str(matrix),'.mat'),'DCM');
            elseif matrix > 9
                save(strcat('/home/prakt23/dcm_2ndtry/',subject_list{sub},'/DCM_',subject_list{sub},'_run-',num2str(sess),'_model-',num2str(matrix),'.mat'),'DCM');
            %display(strcat('.... DCM_',subject_list{sub},'_run_',num2str(sess),'_model_',num2str(matrix),'.mat will now be estimated !!!! ....'))
            % hiermit kann man es direkt schaetzen lassen
            % spm_dcm_estimate(strcat('/home/prakt23/dcm_2ndtry/',subject_list{sub},'/DCM_',subject_list{sub},'_run-',num2str(sess),'_model-',num2str(matrix),'.mat'));
            end
        end
    end

end



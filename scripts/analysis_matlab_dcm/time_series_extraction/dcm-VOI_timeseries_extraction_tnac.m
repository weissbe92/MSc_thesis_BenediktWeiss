
%% script for eigenvariate extraction - DCM bene
% start spm
spm fmri;

% generate subject_list to iterate over
subject_list = {'sub-02','sub-03','sub-04','sub-05','sub-06','sub-07','sub-08','sub-09','sub-10','sub-11','sub-12','sub-13','sub-14','sub-15','sub-16','sub-17','sub-18','sub-19','sub-20','sub-21','sub-22','sub-23','sub-24'};
            
% ROIs for DCM (see norman haignere: middle HG: TE10)            
regions_of_interest = {'lhPT','lhHG','lhPP','rhPT','rhHG','rhPP'};
masks_of_interest = {'lh.pt_trans_mask.nii','lh.te10_trans_mask.nii','lh.pp_trans_mask.nii','rh.pt_trans_mask.nii','rh.te10_trans_mask.nii','rh.pp_trans_mask.nii'};

for sub = 1:length(subject_list)

    % change spm-paths to current mount of external drive and needed nipype-outputs (SPM.mat)
    spm_changepath(strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/1stlevel/output_1stlevel/contrasts/',subject_list{sub},'/SPM.mat'), '86A406A0A406933B1','86A406A0A406933B2')

    % get the smoothed functionals from the 4 runs
    for sess = 1:4
        spm_changepath(strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/1stlevel/output_1stlevel/contrasts/',subject_list{sub},'/SPM.mat'), ...
            strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/1stlevel/workingdir_1stlevel/l1analysis/_subject_id_',subject_list{sub},'/modelspec/sr',subject_list{sub},'_task-tnac_run-',num2str(sess),'_bold.nii'), ...
            strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/preprocessing/output_preproc/smooth/',subject_list{sub},'/sr',subject_list{sub},'_task-tnac_run-',num2str(sess),'_bold.nii'));
    end
    
    % move beta images to directory of spm.mat
    cd(strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/1stlevel/workingdir_1stlevel/l1analysis/_subject_id_',subject_list{sub},'/level1estimate'));
    newdir = strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/1stlevel/output_1stlevel/contrasts/',subject_list{sub},'/');
    betafiles = dir('beta*.nii');
    for beta = 1:length(betafiles)
        copyfile(betafiles(beta).name, newdir)
    end
    cd(newdir);   
    
    % run matlabbatch to get timeseries
    for reg = 1:length(regions_of_interest)
        for sess = 1:4


            matlabbatch{1}.spm.util.voi.spmmat = {strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/1stlevel/output_1stlevel/contrasts/',subject_list{sub},'/SPM.mat')};
            matlabbatch{1}.spm.util.voi.adjust = 5; % eoi index
            matlabbatch{1}.spm.util.voi.session = sess; % index of session as defined by loop
            matlabbatch{1}.spm.util.voi.name = regions_of_interest{reg};
            matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''};
            matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 4; % index of all_conditions_t-contrast
            matlabbatch{1}.spm.util.voi.roi{1}.spm.conjunction = 1;
            matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
            matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.05; % hier koennte man spaeter auf 0.001 gehen, falls alle Probanden genuegend Aktivierung zeigen
            matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0;
            matlabbatch{1}.spm.util.voi.roi{1}.spm.mask = struct('contrast', {}, 'thresh', {}, 'mtype', {});
            matlabbatch{1}.spm.util.voi.roi{2}.mask.image = {strcat('/media/lmn/86A406A0A406933B2/TNAC_BIDS/derivatives/masks/output_inverse_transform_ROIs/inverse_transform_rois/',subject_list{sub},'/',masks_of_interest{reg})};
            matlabbatch{1}.spm.util.voi.roi{2}.mask.threshold = 0.5;
            matlabbatch{1}.spm.util.voi.expression = 'i1 & i2';
            
            spm_jobman('run',matlabbatch)
            clear matlabbatch

        end
    end
end


% % design-matrix for fixed intrinsic connections (A-matrix)
% % ROI-order in rows/colums: lhPT, lhHG, lhPP, rhPT, rhHG, rhPP
% % also model intrinsic connectivity of HGs, even if they do not change
% % over models!

% A_matrix = [0 1 0 1 0 0;
%             1 1 1 0 1 0;
%             0 1 0 0 0 0;
%             1 0 0 0 1 0;
%             0 1 0 1 1 1;
%             0 0 0 0 1 0];
% 
% % matrices for 27 models modelling modulatory connectivity between ROIs (B-matrix)
% B_matrix_01 = [0 1 0 1 0 0;
%                1 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 0 0;
%                0 0 0 0 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_02 = [0 0 0 1 0 0;
%                0 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 0 0 0 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_03 = [0 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 0 0 1 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_04 = [0 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 0 0;
%                0 0 0 0 1 1;
%                0 0 0 0 1 0];
% % 01+02           
% B_matrix_05 = [0 1 0 1 0 0;
%                1 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 0 0 0 1 0;
%                0 0 0 0 0 0];
% % 03+04           
% B_matrix_06 = [0 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 0 0 1 1 1;
%                0 0 0 0 1 0];
% % 01+03           
% B_matrix_07 = [0 1 0 1 0 0;
%                1 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 0 0 1 1 0;
%                0 0 0 0 0 0];
% % 02+04           
% B_matrix_08 = [0 0 0 1 0 0;
%                0 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 0 0 0 1 1;
%                0 0 0 0 1 0];
% % 01+02+03+04           
% B_matrix_09 = [0 1 0 1 0 0;
%                1 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 1 0;
%                0 0 0 1 1 1;
%                0 0 0 0 1 0];
%            
% B_matrix_10 = [0 1 0 1 0 0;
%                1 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_11 = [0 0 0 1 0 0;
%                0 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_12 = [0 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_13 = [0 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 1;
%                0 0 0 0 1 0];
% % 10+11           
% B_matrix_14 = [0 1 0 1 0 0;
%                1 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0];
% % 12+13           
% B_matrix_15 = [0 0 0 1 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 1;
%                0 0 0 0 1 0];
% % 10+12           
% B_matrix_16 = [0 1 0 1 0 0;
%                1 1 0 0 1 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 0;
%                0 0 0 0 0 0];
% % 11+13          
% B_matrix_17 = [0 0 0 1 0 0;
%                0 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 1;
%                0 0 0 0 1 0];
% % same as A_Matrix           
% B_matrix_18 = [0 1 0 1 0 0;
%                1 1 1 0 1 0;
%                0 1 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 1;
%                0 0 0 0 1 0];
%            
% B_matrix_19 = [0 1 0 1 0 0;
%                1 1 0 0 0 0;
%                0 0 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_20 = [0 0 0 1 0 0;
%                0 1 1 0 0 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_21 = [0 0 0 1 0 0;
%                0 1 0 0 0 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 0;
%                0 0 0 0 0 0];
%            
% B_matrix_22 = [0 0 0 1 0 0;
%                0 1 0 0 0 0;
%                0 0 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 1;
%                0 0 0 0 1 0];
% % 19+20           
% B_matrix_23 = [0 1 0 1 0 0;
%                1 1 1 0 0 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 0;
%                0 0 0 0 0 0];
% % 21+22            
% B_matrix_24 = [0 0 0 1 0 0;
%                0 1 0 0 0 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 1;
%                0 0 0 0 1 0];
% % 19+21           
% B_matrix_25 = [0 1 0 1 0 0;
%                1 1 0 0 0 0;
%                0 0 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 0;
%                0 0 0 0 0 0];
% % 20+22           
% B_matrix_26 = [0 0 0 1 0 0;
%                0 1 1 0 0 0;
%                0 1 0 0 0 0;
%                1 0 0 0 0 0;
%                0 1 0 0 1 1;
%                0 0 0 0 1 0];
% % 19+20+21+22           
% B_matrix_27 = [0 1 0 1 0 0;
%                1 1 1 0 0 0;
%                0 1 0 0 0 0;
%                1 0 0 0 1 0;
%                0 1 0 1 1 1;
%                0 0 0 0 1 0];
%            
%            
%            
%            
           
           
           







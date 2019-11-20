%% 
%  Figures for manuscript DOI: 

addpath('/home/matteo/Desktop/git_rep/epi/matlab/episign/multiple_biomarkers_analysis/')
addpath('/home/matteo/Desktop/git_rep/epi/matlab/episign/biomarker_pipeline/')
addpath(fullfile('/home/matteo/Desktop/git_rep/','jsonlab'))
addpath('/home/matteo/Desktop/git_rep/Violinplot-Matlab/')

cfg = [];

% subject information table 
cfg.info_F           = '/home/matteo/Desktop/tle_e/info/info.tsv';

% root folder name of raw data in BIDS format
cfg.bidsFolder       = '/home/matteo/Desktop/tle_e/converted/';


% Result folders and files

% Result folder where the computed biomarkers are saved 
cfg.rootInResFolder   = '/home/matteo/Desktop/tle_e/zscore_notch/2Dbip/combined/';
% Folder where to save the summary tables
cfg.rootSummaryFolder = '/home/matteo/Desktop/tle_e/zscore_notch/2Dbip/summary_table_new/'; 
% Filename for the output picture of the group level analysis pooling all
% channels
cfg.poolingChannelRes = '/home/matteo/Desktop/pics_4_result_section/actual_figures_tryingonefile/group_level_pooling channels'; 

% Folder for the results of the comparison between distribution of the
% maximum value per subject
cfg.outFolderMaxComparison   = '/home/matteo/Desktop/pics_4_result_section/actual_figures_tryingonefile/';

% regular expression to define the group of patients used to compute the global
% threshold (cured patients)
cfg.normTempRegExp = '1a_AED_stop\w*';





% subjects to remove from the analysis
cfg.subj2rem       = {                                                        ...                                              
                      'RESP0448','RESP0480','RESP0482','RESP0484','RESP0497', ... % hfo trial
                      'RESP0500','RESP0519','RESP0537','RESP0542','RESP0556', ... % hfo trial
                      'RESP0566','RESP0572','RESP0604','RESP0631','RESP0636', ... % hfo trial
                      'RESP0640','RESP0644', ...                                  % hfo trial 
                      'RESP0353','RESP0623'  ...                                  % no last post recording
                     };

% regular expression defining the epilepsy type (all/ T = temporal, E = extra-temporal ) 
cfg.typeEPI = {'\w*','T','E'};  

% seizure outcome to consider (i.e. after one year/longer)
cfg.sf_class   = {'description_sf_1y'};

% biomarker of interest 
cfg.bioNames = {'ARR','PAC','PLV','PLI','H2','GC','sdDTF'};


% comparison between maximum distribution per subject
cfg.bioMarker2plotMaxDistribution = [1 2 3 4 5 6 7 ];  
cfg.alpha_level                   = 0.01            ;

% selection of a specific pathology group (i.e. MST, FCD etc they are coded
% in information table) or all subjects
cfg.path_label                 = {'all'};
cfg.path_group                 = {[0]};
% pathology group to consider according to what group is investigated 
cfg.path_idx_of_interest       = 1;
% regular expression to define the seizure outcome groups where to test the global
% threshold
cfg.seizOut2try                = {'1a_AED_stop\w*','1(a|b)\w*'};
cfg.seizOut_idx                = [1 2];

% remove channels labeled with N-N (not present)
cfg.removeNNchannels           = 1;

% function to plot and save the figures
compute_results_and_save_figure(cfg)
% Extract the biomarker values according to the class (RES/CUT/NRES pre & post)
% and rename them in preR / preNR / postNR 
% 
% INPUT
% subj_tbl - table (see create_summary_table_main for the layout)
%
%
% OUTPUT
% vals    - array of double (relative to the biomaker) organized in three
%           classes pre-resection resected / pre-resection not resected /
%           post-resection
% G_idx   - cell arry of labels 
%                               'preR' for pre-resection resected 
%                               'preNR' for pre-resection not resected 
%                               'postNR' for  post-resection 
% new_tbl - table with the four variables
%                               
%                               subjName  - coded name of the subject (RESPXXXX)
%                               sitName   - name of the situation considered      
%                               chName    - name of the channel considered    
%                               biomarker - double, biomarker value
%                                           
%

%     Copyright (C) 2019 Matteo Demuru
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <https://www.gnu.org/licenses/>.
function [vals,G_idx,new_tbl] = getValXclass_pre_post_R_NR(subj_tbl)

resected_idx  = strcmp(subj_tbl.resected,'RES');
cut_idx       = strcmp(subj_tbl.resected,'CUT');
nresected_idx = strcmp(subj_tbl.resected,'NRES');

pre_idx  = ~cellfun(@isempty,regexp(subj_tbl.sitName,'SITUATION1\w*'));
post_idx = ~cellfun(@isempty,regexp(subj_tbl.sitName,'SITUATION[^1]\w*'));


preR   = subj_tbl.biomarker(pre_idx  & resected_idx );
preNR  = subj_tbl.biomarker(pre_idx  & nresected_idx);
postNR = subj_tbl.biomarker(post_idx & nresected_idx);

chName_preR   = subj_tbl.chName(pre_idx  & resected_idx);
chName_preNR  = subj_tbl.chName(pre_idx  & nresected_idx);
chName_postNR = subj_tbl.chName(post_idx & nresected_idx);


vals = [preR ;preNR ; postNR];
G_idx = [repmat({'preR'},size(preR,1),1) ; repmat({'preNR'},size(preNR,1),1) ; repmat({'postNR'},size(postNR,1),1)];

sName_preR   = subj_tbl.sitName(pre_idx  & resected_idx );
sName_preNR  = subj_tbl.sitName(pre_idx  & nresected_idx);
sName_postNR = subj_tbl.sitName(post_idx & nresected_idx);

subName_preR   = subj_tbl.subjName(pre_idx & resected_idx);
subName_preNR  = subj_tbl.subjName(pre_idx & nresected_idx);
subName_postNR = subj_tbl.subjName(post_idx& nresected_idx);


val_tbl  = array2table([ preR ; preNR ; postNR],'VariableNames',{'biomarker'});
ch_tbl   = array2table([ chName_preR  ; chName_preNR ; chName_postNR],'VariableNames',{'chName'});
sit_tbl  = array2table([ sName_preR ; sName_preNR ; sName_postNR],'VariableNames',{'sitName'});
sub_tbl  = array2table([ subName_preR ; subName_preNR ; subName_postNR],'VariableNames',{'subjName'});



new_tbl  = [sub_tbl sit_tbl ch_tbl val_tbl];
% apply a grid montage (passed as a function) 
% INPUT
% data    - fieldtrip data structure
% fun     - handler to one of the possible montage function
%           the signature of the generic function takes 
%           two input parameters (channel label [cell], matrix of data [ch X samples])
% OUTPUT       
% outdata - fieldtrip data structure with the data transformed according to the montage funtion fun 

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
function outdata = apply_montage2data(data,fun)

outdata = data;
ntrial = numel(data.trial);
for i = 1: ntrial
    
    [outdata.label,outdata.trial{i}] = fun(data.label,data.trial{i});
    if(isempty(outdata.trial{i}))
        outdata = [];
        return
    end
end

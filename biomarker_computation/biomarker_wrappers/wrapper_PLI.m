% wrapper PLI
function [ bio_vals, extra ] = wrapper_PLI(cfg,data)

extra    = [];
bio_vals = [];

band_of_interest  = cfg.boi;


% zscore
for i = 1 : numel(data.trial)

    aux = data.trial{i};
    aux = zscore(aux,[],2);

    data.trial{i} = aux;

end
aux = [];


cfg_f            = [];
cfg_f.bpfilter   = 'yes';
cfg_f.bpfreq     = band_of_interest;
cfg_f.bpfilttype = 'fir';

f_data = ft_preprocessing(cfg_f, data);

[~,outdata.hdr.datasetName,~] = fileparts(cfg.datasetName); 

ntrial = size(f_data.trial,2);

for i = 1: ntrial
    
    m           = pli(f_data.trial{i});
    aux.m       = m;
    aux.boi     = band_of_interest;
    extra{i}    = aux;
    
    bio_vals{i} = sum(m,2) / (size(m,1)-1); 
end





function m = pli(a)
% a is a filtered multichannel matrix (channels X time)
% hilbert(a) calculates analytic signal (complex valued) of each 
% row of a. Phase Lag Index between channel i and j is stored in m(i,j) 

N          = size(a,1);
nch        = size(a,1);
m(1:N,1:N) = 0; 
h  = hilbert(a'); 

for i = 1 : nch
    for j = 1 : nch
        if i<j
            
            m(i,j)  = abs( mean(sign( (angle( h(:,i).*conj(h(:,j)) ) ) ) ) ) ;
            
        end 
    end 
end

m = m + m';

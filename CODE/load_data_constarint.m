
function data = load_data_constarint(raw0, size_ml,size_cl)

% Input :
%    raw0:    raw data, the last column is label vector, such as UCI datasets 
%    size_ml; The size of must-link constarints 
%    size_cl: The size of cannot-link constarints
% Output:
%    data.X:   The original data without labels
%    data.Y:   The label of the data
%    data.ML:  The must-link constarints ([i j]: example i and example j is must-link constraint)
%    data.CL:  The cannot-link constarints ()
%
data=[];
data.raw = raw0;
data.n = size(data.raw,1);
data.d = size(data.raw,2)-1;% the last column is class label
data.X = data.raw(:,1:data.d);
data.Y = data.raw(:,data.d+1);
data.c = length(unique(data.Y));
[ML, CL] = rand_sel_constarints(data.X,data.Y,size_ml, size_cl,1);
data.ML = ML;
data.CL = CL;
end

function [ML, CL] = rand_sel_constarints(X, Y,size_ml, size_cl, rand_flag)
[n d] = size(X);% each row is a example
max_csize = n*(n-1)/2;
if max_csize<(size_ml+size_cl)
    disp('constarints size larger than data size!');
    size_ml = 0;
    size_cl = 0;
end
% construct all pairwise 
temp_id=1;
temp = zeros(max_csize,3);
for i=1:n-1
    for j=i+1:n
        temp(temp_id,1) = i;
        temp(temp_id,2) = j;
        if Y(i)==Y(j)
            temp(temp_id,3) = 1;
        else
            temp(temp_id,3) = -1;
        end
        temp_id = temp_id +1;
    end 
end

index1 = find(temp(:,3)==1);
index2 = find(temp(:,3)==-1);

if (rand_flag == 1) % sort at random
    rand_index1 = randperm(size(index1,1));
    index1 = index1(rand_index1,1);
    rand_index2 = randperm(size(index2,1));
    index2 = index2(rand_index2,1);
end
if size_ml>size(index1,1)
    error('Msut-Link constraints number is too large! ');
end
if size_cl>size(index2,1)
    error('Cannot-Link constraints number is too large!');
end
index_ml = index1(1:size_ml,1);
%index_cl = index2(size_ml+1:size_ml+size_cl,1);
index_cl = index2(1:size_cl,1);

ML = temp(index_ml,1:2);
CL = temp(index_cl,1:2);
end % end function rand_sel_constarints
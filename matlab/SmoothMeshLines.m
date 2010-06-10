function [ lines ] = SmoothMeshLines( lines, max_res, ratio )
%function [ lines ] = SmoothMeshLines( lines, max_res, ratio )
%
% create smooth mesh lines
%
% CSXCAD matlab interface
% -----------------------
% author: Thorsten Liebig

if (numel(lines)<2)
    return
end

if (nargin<3)
    ratio = 1.3;
end


lines = unique(sort(lines));

diff_Lines = diff(lines);

index = find(diff_Lines>max_res);

% for n=1:numel(diff_Lines)-1
%     if ( (diff_Lines(n+1)/diff_Lines(n) > ratio) )
%         index = [index n+1];
%     end
% end

index = unique(index);

addLines = [];

for n=1:numel(index)
    if (index(n)==1)
        start_res = max_res;
    else
        start_res = lines(index(n)) - lines(index(n)-1);
    end
    
    if ((index(n)+1)==numel(lines))
        stop_res = max_res;
    else
        stop_res = lines(index(n)+2) - lines(index(n)+1);
    end
    
    addLines = [addLines SmoothRange(lines(index(n)),lines(index(n)+1),start_res,stop_res,max_res,ratio)];
end


lines = unique(sort([lines addLines]));

[EC pos] = CheckMesh(lines,0,max_res,ratio);

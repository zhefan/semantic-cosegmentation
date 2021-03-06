function [trackind, totalmaxnum] = cal_tracklet_ind(cluster_names, total_num)

for ii = 1:length(cluster_names)
    inds_s = regexp(cluster_names(ii).name,'\d','start'); 
	cluster_id(ii) = str2double(cluster_names(ii).name(inds_s));
end
% initial pool
if total_num < 36
	imglist = [1, total_num];
else
	gap = 10;
	imglist = [16:gap:total_num];
	if numel(imglist) > 10
		randnum = randperm(numel(imglist));
		imglist = imglist(randnum(1:5));
	end
	imglist = sort(imglist);
end
imglist = intersect([imglist, 1], cluster_id);

if length(imglist) == 0
	randnum = randperm(numel(cluster_id));
	imglist = cluster_id(randnum(1));
end
trackind = imglist;
if trackind(end)==total_num && numel(trackind) >= 2
    totalmaxnum = length(trackind)-1;
else
    totalmaxnum = length(trackind);
end

totalmaxnum = max(totalmaxnum, 1);

% Removes the duplicates in the notMINST datasets (as formatted by 
% matlab_convert.py) and stores the  unique (and reshaped) sets as
% `images_unique` and `labels_unique` in the same .mat file.
% USAGE: octave remove_duplicates.m notMNIST_small.mat

clear all
function remove_duplicates(fn)
	load(fn)

	% reshape
	images_reshaped = permute(images, [3 1 2]);

	[m h w] = size(images_reshaped);
	images_reshaped = reshape(images_reshaped, [m h*w]);
	labels_reshaped = labels';

	% remove duplicates (this does some unwanted sorting also)
	[dummy, unique_rows, iorig] = unique(images_reshaped, 'rows');
	images_unique = images_reshaped(unique_rows,:);
	labels_unique = labels_reshaped(unique_rows,:);
	num_dups = num2str(m - length(labels_unique));
	printf(['\n', num_dups, ' duplicates found in small dataset.\n'])

	% save('-7',fn, 'images', 'labels', 'unique_rows')
	out_name = [fn(1:end-4) '_unique' '.mat']
	save('-4', out_name, 'images_unique', 'labels_unique')
end

remove_duplicates(char(argv()))

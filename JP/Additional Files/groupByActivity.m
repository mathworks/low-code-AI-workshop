function [grouped_train, grouped_test] = groupByActivity(rawTrain, numTrain, rawTest, numTest)
% This function groups all six sensor signals together into a
% multidimensional array where each dimension represents one activity.

%% Train data
raw_train_new=table2array(rawTrain(:,1));
% stack the matrix (columns to rows) as following:
% Sensor 1 X channel rows 1 to 7352,
%          Y channel rows 7353 to 14705,
%          Z channel rows 14705 to 22056, 
% Sensor 2 X channel 22057 to 29408, etc.
for i=2:size(rawTrain, 2)
    raw_train_new=[raw_train_new; table2array(rawTrain(:,i))];
end
%%
% sort by time
% Activity 1 rows 1 to 6 (both sensors),
% Activity 2 rows 7 to 12, etc.
% Activity 7352 rows 44107 to 44112
tot_acc_xyz_train = ones(size(raw_train_new,1),size(raw_train_new,2));
i = 0;
for j = 1:length(raw_train_new)/6
    tot_acc_xyz_train(i+j,:)   = raw_train_new(j,:);
    tot_acc_xyz_train(i+j+1,:) = raw_train_new(j+numTrain,:);
    tot_acc_xyz_train(i+j+2,:) = raw_train_new(j+numTrain*2,:);
    tot_acc_xyz_train(i+j+3,:) = raw_train_new(j+numTrain*3,:);
    tot_acc_xyz_train(i+j+4,:) = raw_train_new(j+numTrain*4,:);
    tot_acc_xyz_train(i+j+5,:) = raw_train_new(j+numTrain*5,:);
    i = i + 5;
end
%%
% create multidimensional array with the structure 6x128x7352
k = 0;
len_acc_train = length(tot_acc_xyz_train)/6;
grouped_train = zeros(6,128,len_acc_train);

for i = 1:len_acc_train
    grouped_train(:,:,i) = tot_acc_xyz_train(i+k:i+k+5,:);
    k = k + 5;
end
%% Test data
raw_test_new=table2array(rawTest(:,1));

for i=2:size(rawTest, 2)
    raw_test_new=[raw_test_new; table2array(rawTest(:,i))];
end
%%

tot_acc_xyz_test = ones(size(raw_test_new,1),size(raw_test_new,2));
i = 0;
for j = 1:length(raw_test_new)/6
    tot_acc_xyz_test(i+j,:)   = raw_test_new(j,:);
    tot_acc_xyz_test(i+j+1,:) = raw_test_new(j+numTest,:);
    tot_acc_xyz_test(i+j+2,:) = raw_test_new(j+numTest*2,:);
    tot_acc_xyz_test(i+j+3,:) = raw_test_new(j+numTest*3,:);
    tot_acc_xyz_test(i+j+4,:) = raw_test_new(j+numTest*4,:);
    tot_acc_xyz_test(i+j+5,:) = raw_test_new(j+numTest*5,:);
    i = i + 5;
end
%%

k = 0;
len_acc_test = length(tot_acc_xyz_test)/6;
grouped_test = zeros(6,128,len_acc_test);

for i = 1:len_acc_test
    grouped_test(:,:,i) = tot_acc_xyz_test(i+k:i+k+5,:);
    k = k + 5;
end
end

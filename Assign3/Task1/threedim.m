% Define the dataset variable (change this line to switch datasets)
dataset = P30;  
dataset_name = 'P30';  

% Create a directory for the dataset if it doesn't exist
if ~exist(dataset_name, 'dir')
    mkdir(dataset_name);
end

% Create and train the SOM
som = newsom(dataset, [10 10], 'hextop', 'linkdist', 100, 5);
[som_P, stats] = train(som, dataset);

fprintf('The following are the plots:\n');

% Plot and save Winning Nodes for F1
figure;
plotsomhits(som_P, dataset(:,1:100));
title(['Winning Nodes for F1 (' dataset_name ')']);  
saveas(gcf, fullfile(dataset_name, ['winning_nodes_F1_' dataset_name '.png']));  

% Plot and save Winning Nodes for F2
figure;
plotsomhits(som_P, dataset(:,101:200));
title(['Winning Nodes for F2 (' dataset_name ')']);  
saveas(gcf, fullfile(dataset_name, ['winning_nodes_F2_' dataset_name '.png']));  

fprintf('Plot the nodes of som_P in the input space:\n');

% Plot and save SOFM topology with input data
figure;
plotsom(som_P.iw{1,1}, som_P.layers{1}.distances);
hold on;
plot3(dataset(1,:), dataset(2,:), dataset(3,:), '+k');
title(['SOFM Topology with Input Data (' dataset_name ')']); 
saveas(gcf, fullfile(dataset_name, ['som_input_space_' dataset_name '.png']));  

fprintf('Plots saved as PNG files in the "%s" directory.\n', dataset_name);

som = newsom(wineInputs, [10 10], 'hextop', 'linkdist', 150, 5);
som.trainParam.epochs = 200;  

[trained_som, stats] = train(som, wineInputs);

fprintf('The following are the plots:\n');

% Assign each data point to the best matching unit (BMU)
bmu_indices_class1 = vec2ind(trained_som(wineInputs(:, 1:59)));
bmu_indices_class2 = vec2ind(trained_som(wineInputs(:, 60:130)));
bmu_indices_class3 = vec2ind(trained_som(wineInputs(:, 131:178)));

% Create a grid to keep track of the overlap for each pair of classes
grid_size = trained_som.layers{1}.dimensions;
overlap_grid_class1_class2 = zeros(grid_size);
overlap_grid_class1_class3 = zeros(grid_size);
overlap_grid_class2_class3 = zeros(grid_size);

% Mark the winning nodes for each class and calculate overlap
for i = 1:length(bmu_indices_class1)
    overlap_grid_class1_class2(bmu_indices_class1(i)) = overlap_grid_class1_class2(bmu_indices_class1(i)) + 1;
end
for i = 1:length(bmu_indices_class2)
    overlap_grid_class1_class2(bmu_indices_class2(i)) = overlap_grid_class1_class2(bmu_indices_class2(i)) + 2;
end

for i = 1:length(bmu_indices_class1)
    overlap_grid_class1_class3(bmu_indices_class1(i)) = overlap_grid_class1_class3(bmu_indices_class1(i)) + 1;
end
for i = 1:length(bmu_indices_class3)
    overlap_grid_class1_class3(bmu_indices_class3(i)) = overlap_grid_class1_class3(bmu_indices_class3(i)) + 4;
end

for i = 1:length(bmu_indices_class2)
    overlap_grid_class2_class3(bmu_indices_class2(i)) = overlap_grid_class2_class3(bmu_indices_class2(i)) + 2;
end
for i = 1:length(bmu_indices_class3)
    overlap_grid_class2_class3(bmu_indices_class3(i)) = overlap_grid_class2_class3(bmu_indices_class3(i)) + 4;
end

% Calculate the overlap percentage for each pair of classes
total_nodes = numel(overlap_grid_class1_class2);
overlap_count_class1_class2 = sum(overlap_grid_class1_class2 == 3);  % Class 1 and Class 2 overlap
overlap_percentage_class1_class2 = (overlap_count_class1_class2 / total_nodes) * 100;

total_nodes = numel(overlap_grid_class1_class3);
overlap_count_class1_class3 = sum(overlap_grid_class1_class3 == 5);  % Class 1 and Class 3 overlap
overlap_percentage_class1_class3 = (overlap_count_class1_class3 / total_nodes) * 100;

total_nodes = numel(overlap_grid_class2_class3);
overlap_count_class2_class3 = sum(overlap_grid_class2_class3 == 6);  % Class 2 and Class 3 overlap
overlap_percentage_class2_class3 = (overlap_count_class2_class3 / total_nodes) * 100;

fprintf('The overlap between Class 1 and Class 2 is %.2f%%\n', overlap_percentage_class1_class2);
fprintf('The overlap between Class 1 and Class 3 is %.2f%%\n', overlap_percentage_class1_class3);
fprintf('The overlap between Class 2 and Class 3 is %.2f%%\n', overlap_percentage_class2_class3);

% Plot and save Winning Nodes for Class 1
figure;
plotsomhits(trained_som, wineInputs(:, 1:59));
title('Winning Nodes for Class 1');
saveas(gcf, 'winning_nodes_class1_10x10.png');

% Plot and save Winning Nodes for Class 2
figure;
plotsomhits(trained_som, wineInputs(:, 60:130));
title('Winning Nodes for Class 2');
saveas(gcf, 'winning_nodes_class2_10x10.png');

% Plot and save Winning Nodes for Class 3
figure;
plotsomhits(trained_som, wineInputs(:, 131:178));
title('Winning Nodes for Class 3');
saveas(gcf, 'winning_nodes_class3_10x10.png');


fprintf('Plots saved as PNG files.\n');

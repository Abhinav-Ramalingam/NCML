% Normalize the input data
normIrisInputs = mapminmax(irisInputs);

% Create and train a 10x10 SOFM
som = newsom(normIrisInputs, [10 10], 'hextop', 'linkdist', 150, 5);
som.trainParam.epochs = 200;  
[trained_som, stats] = train(som, normIrisInputs);

% Assign each data point to the best matching unit (BMU)
bmu_indices_setosa = vec2ind(trained_som(normIrisInputs(:, 1:50)));
bmu_indices_versicolour = vec2ind(trained_som(normIrisInputs(:, 51:100)));
bmu_indices_virginica = vec2ind(trained_som(normIrisInputs(:, 101:150)));

% Create a grid to keep track of the overlap for each pair of classes
grid_size = trained_som.layers{1}.dimensions;
overlap_grid_setosa_versicolour = zeros(grid_size);
overlap_grid_setosa_virginica = zeros(grid_size);
overlap_grid_versicolour_virginica = zeros(grid_size);

% Mark the winning nodes for each class and calculate overlap
for i = 1:length(bmu_indices_setosa)
    overlap_grid_setosa_versicolour(bmu_indices_setosa(i)) = overlap_grid_setosa_versicolour(bmu_indices_setosa(i)) + 1;
end
for i = 1:length(bmu_indices_versicolour)
    overlap_grid_setosa_versicolour(bmu_indices_versicolour(i)) = overlap_grid_setosa_versicolour(bmu_indices_versicolour(i)) + 2;
end

for i = 1:length(bmu_indices_setosa)
    overlap_grid_setosa_virginica(bmu_indices_setosa(i)) = overlap_grid_setosa_virginica(bmu_indices_setosa(i)) + 1;
end
for i = 1:length(bmu_indices_virginica)
    overlap_grid_setosa_virginica(bmu_indices_virginica(i)) = overlap_grid_setosa_virginica(bmu_indices_virginica(i)) + 4;
end

for i = 1:length(bmu_indices_versicolour)
    overlap_grid_versicolour_virginica(bmu_indices_versicolour(i)) = overlap_grid_versicolour_virginica(bmu_indices_versicolour(i)) + 2;
end
for i = 1:length(bmu_indices_virginica)
    overlap_grid_versicolour_virginica(bmu_indices_virginica(i)) = overlap_grid_versicolour_virginica(bmu_indices_virginica(i)) + 4;
end

% Calculate the overlap percentage for each pair of classes
total_nodes = numel(overlap_grid_setosa_versicolour);
overlap_count_setosa_versicolour = sum(overlap_grid_setosa_versicolour == 3);  % Setosa and Versicolour overlap
overlap_percentage_setosa_versicolour = (overlap_count_setosa_versicolour / total_nodes) * 100;

total_nodes = numel(overlap_grid_setosa_virginica);
overlap_count_setosa_virginica = sum(overlap_grid_setosa_virginica == 5);  % Setosa and Virginica overlap
overlap_percentage_setosa_virginica = (overlap_count_setosa_virginica / total_nodes) * 100;

total_nodes = numel(overlap_grid_versicolour_virginica);
overlap_count_versicolour_virginica = sum(overlap_grid_versicolour_virginica == 6);  % Versicolour and Virginica overlap
overlap_percentage_versicolour_virginica = (overlap_count_versicolour_virginica / total_nodes) * 100;

fprintf('The overlap between Setosa and Versicolour is %.2f%%\n', overlap_percentage_setosa_versicolour);
fprintf('The overlap between Setosa and Virginica is %.2f%%\n', overlap_percentage_setosa_virginica);
fprintf('The overlap between Versicolour and Virginica is %.2f%%\n', overlap_percentage_versicolour_virginica);

% Plot and save Winning Nodes for each class
figure;
plotsomhits(trained_som, normIrisInputs(:, 1:50));
title('Winning Nodes for Iris Setosa');
saveas(gcf, 'winning_nodes_setosa_10x10.png');

figure;
plotsomhits(trained_som, normIrisInputs(:, 51:100));
title('Winning Nodes for Iris Versicolour');
saveas(gcf, 'winning_nodes_versicolour_10x10.png');

figure;
plotsomhits(trained_som, normIrisInputs(:, 101:150));
title('Winning Nodes for Iris Virginica');
saveas(gcf, 'winning_nodes_virginica_10x10.png');

fprintf('Plots saved as PNG files.\n');

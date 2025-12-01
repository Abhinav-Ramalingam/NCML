% Normalize the data
normUnknownData = mapminmax(unknown_data);

% Create and train a 10x10 SOM
som = newsom(normUnknownData, [10 10], 'hextop', 'linkdist', 150, 5);
som.trainParam.epochs = 200;  % Number of training epochs
[trained_som, stats] = train(som, normUnknownData);

% Identify the winning nodes for each data point
bmu1 = vec2ind(trained_som(point1));
bmu2 = vec2ind(trained_som(point2));
bmu3 = vec2ind(trained_som(point3));
bmu4 = vec2ind(trained_som(point4));
bmu5 = vec2ind(trained_som(point5));

% Plot and save individual plots for each point
figure;
plotsomhits(trained_som, point1);
title('Point 1 Winning Node');
saveas(gcf, 'winning_node_point1.png');

figure;
plotsomhits(trained_som, point2);
title('Point 2 Winning Node');
saveas(gcf, 'winning_node_point2.png');

figure;
plotsomhits(trained_som, point3);
title('Point 3 Winning Node');
saveas(gcf, 'winning_node_point3.png');

figure;
plotsomhits(trained_som, point4);
title('Point 4 Winning Node');
saveas(gcf, 'winning_node_point4.png');

figure;
plotsomhits(trained_som, point5);
title('Point 5 Winning Node');
saveas(gcf, 'winning_node_point5.png');

fprintf('Individual plots saved.\n');

% Define SOM for P30 and train it
som = newsom(P30, [10, 10], 'hextop', 'linkdist', 100, 5);
[som_P30, stats30] = train(som, P30);

% Train SOM for P10
[som_P10, stats10] = train(som, P10);

% Plot and save Winning Nodes for F1 (P10 with som_P30)
figure;
plotsomhits(som_P30, P10(:,1:100)); % Winning nodes for F1
title('Winning Nodes for F1 using P10 with som_P30');
saveas(gcf, 'winning_nodes_F1_P10_with_som_P30.png'); % Save figure as PNG

% Plot and save Winning Nodes for F2 (P30 with som_P10)
figure;
plotsomhits(som_P10, P30(:,1:100)); % Winning nodes for F2
title('Winning Nodes for F2 using P30 with som_P10');
saveas(gcf, 'winning_nodes_F2_P30_with_som_P10.png'); % Save figure as PNG

% Plot and save the distance map for som_P30 using 3D visualization
figure;
plotsom(som_P30.iw{1,1}, som_P30.layers{1}.distances);
hold on;
plot3(P30(1,:), P30(2,:), P30(3,:), '+k'); % Plot data points on the 3D plane
title('Distance Map for som_P30 with 3D points');
saveas(gcf, 'distance_map_som_P30_with_3D_points.png'); % Save figure as PNG

fprintf('Figures have been saved as PNG files.\n');

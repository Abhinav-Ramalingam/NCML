% Create and train the SOFM
som = newsom(RGB, [10 10], 'gridtop', 'linkdist', 0.9, 125, 0.02, 0);
som.trainParam.epochs = 200; 

[trained_som, stats] = train(som, RGB);

% weight analysis
figure;
plotsomplanes(trained_som);
saveas(gcf, 'weight_analysis.png'); 

% the color map of the SOFM
figure;
plot_colors(trained_som);
saveas(gcf, 'smooth_color_map.png'); 

fprintf('Plots saved as PNG files.\n');


%Initialize
star = GAparams;
star.objParams.star = star1;
star.visual.active = 1;
star.visual.func = 'circle';

% Pressure values to test
pressures = [2, 1.75, 1.5, 1.25, 1];

% Loop through each pressure value
for i = 1:length(pressures)
    % Set the pressure value for this iteration
    star.select.pressure = pressures(i);
    
    % Modify Selection function to 'rank'
    star.select.func = 'rank';

    % Plot Visualization
    [best, fit, stat] = GAsolver(2, [0 20 ; 0 20], 'circle', 50, 100, star);
    
    % Save the plot of the largest circle
    saveas(gcf, sprintf('figures/plot2/largest_circle_ranked_%.2f.png', pressures(i)));

    % Show Parameters
    ga_show_parameters(star);

    % Show Diversity Plot
    ga_plot_diversity(stat);
    
    % Save the diversity plot with the appropriate filename
    saveas(gcf, sprintf('figures/plot2/diversity_plot_%.2f.png', pressures(i))); 
end

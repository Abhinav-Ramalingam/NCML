% Initialize
star = GAparams;
star.objParams.star = star3;
star.visual.active = 1;
star.visual.func = 'circle';

% Modified Parameters
star.select.func = 'rank';  % Selection method: Rank-based selection

% Plot Visualization
[best, fit, stat] = GAsolver(2, [0 20 ; 0 20], 'circle', 50, 100, star);
saveas(gcf, 'Task1/figures/elitism/largest_circle_star3_woel.png');

% Show Parameters
ga_show_parameters(star);

% Show Diversity
ga_plot_diversity(stat);
saveas(gcf, 'Task1/figures/elitism/diversity_plot_star3_woel.png');

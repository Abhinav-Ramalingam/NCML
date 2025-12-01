%Initialize
star = GAparams;
star.objParams.star = star1;
star.visual.active = 1;
star.visual.func = 'circle';

%Modified Parameters
star.select.func = 'rank';

%Plot Visualization
[best, fit, stat] = GAsolver(2, [0 20 ; 0 20], 'circle', 50, 100, star);
saveas(gcf, 'Task1/figures/plot2/largest_circle_ranked.png'); 

%Show Parameters
ga_show_parameters(star);

%Show Diversity
ga_plot_diversity(stat);  
saveas(gcf, 'Task1/figures/plot2/diversity_plot_ranked.png'); 


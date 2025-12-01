options = psooptimset('DemoMode','fast', ...
    'PlotFcns', {@psoplotswarmsurf, @psoplotbestf}, ...
    'PopInitRange', [-32; 32], 'InertiaWeight', 1, ...
    'SocialAttraction', 2, 'CognitiveAttraction', 2);

options = psooptimset(options, 'Generations', 500);

[x, fval] = pso(@ackleysfcn, 20, [], [], [], [], [], [], [], options);

saveas(gcf, 'figures/min/pso_best_fitness.png'); 

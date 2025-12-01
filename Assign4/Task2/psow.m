options = psooptimset('DemoMode','fast', ...
    'PlotFcns', {@psoplotswarmsurf, @psoplotbestf, @psoplotvelocity}, ...
    'PopInitRange', [-32; 32], ...
    'InertiaWeight', 1, ...                % Inertia Weight (w = 1)
    'SocialAttraction',2, ...             % Social Component (c2 = 2)
    'CognitiveAttraction', 2);        % Cognitive Component (c1 = 2)
            

options = psooptimset(options, 'Generations', 500);

% Run PSO optimization
[x, fval] = pso(@ackleysfcn, 20, [], [], [], [], [], [], [], options);

% Save the figure
saveas(gcf, 'figures/min/pso_best_fitness_122_without_vc.png');  % Save the best fitness plot
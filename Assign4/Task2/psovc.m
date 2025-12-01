velocity_limits = [30, 15, 5, 1];  

for vlim = velocity_limits
    options = psooptimset('DemoMode', 'fast', ...
        'PlotFcns', {@psoplotswarmsurf, @psoplotbestf, @psoplotvelocity}, ...
        'PopInitRange', [-32; 32], 'InertiaWeight', 1, ...
        'SocialAttraction', 2, 'CognitiveAttraction', 2, ...
        'VelocityLimit', vlim);

    options = psooptimset(options, 'Generations', 500);

    [x, fval] = pso(@ackleysfcn, 20, [], [], [], [], [], [], [], options);

    saveas(gcf, sprintf('figures/min/pso_velocity_%d.png', vlim));
end

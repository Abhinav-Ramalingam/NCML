addpath('testfcns/')

% Creating the Neural Network
global psonet P T;
P = [[0; 0] [0; 1] [1; 0] [1; 1]];
T = [0 1 1 0];
psonet = newff(P, T, [2], {'tansig', 'logsig'}, 'traingd', ...
    '', 'mse', {}, {}, '');

% Initializing PSO options with parameter adjustments
options = psooptimset('PopInitRange', [-1; 1], ...
    'PopulationSize', 50, 'DemoMode', 'pretty', ...
    'PlotFcns', {@psoplotswarm, @psoplotbestf, @psoplotvelocity});


options = psooptimset(options, 'InertiaWeight', [0.9, 0.4]);  % Adjust inertia weight
options = psooptimset(options, 'CognitiveAttraction', 1.8, 'SocialAttraction', 1.8);  % Increase cognitive/social attraction

% Training
[x, fval] = pso(@nntrainfcn, 9, [], [], [], [], [], [], [], options);
saveas(gcf, 'figures/nn/pso_best_fitness.png'); 

% Evaluation
psonet = setx(psonet, x);
plot_xor(psonet);
saveas(gcf, 'figures/nn/xor_plot.png');  

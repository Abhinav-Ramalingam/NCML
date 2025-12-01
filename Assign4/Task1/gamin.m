ack = GAparams;

% Visualization Settings
ack.visual.type = 'mesh';
ack.visual.bounds = [-32, 32];
ack.visual.interval = 0.05;
ack.visual.func = 'ackley';
ack.visual.active = true;

% Stop criteria settings
ack.stop.direction = 'min';

% Visualize the Ackley function
ga_visual_ackley([], [], [], [], [], [], ack.visual, [], []);
saveas(gcf, 'figures/min/ackley_function_visualization.png');

% GA Parameters Setup 
ack.crossover.func = 'blend';       % Crossover
ack.mutate.decay = 'linear';         % mutation decay
ack.replace.comparative =true; %  replacement
ack.mutate.proportional = false; % Mutation proportion


% Initialize an array to store fitness values for each generation
fitness_over_generations = [];

% Function to store fitness values for each generation
ack.output.fitness = @(generation, fitness) fitness_over_generations(end + 1) == fitness;

% Running the GA Solver with the tracking functionality
[best, fit, stat] = GAsolver(20, [-32, 32], 'ackley', 200, 250, ack);

% Compute the final mean fitness from the last generation
final_mean_fitness = mean(stat.fitness(:, end));

% Display the final mean fitness
fprintf('Final Mean Fitness For 100: %.4f\n', final_mean_fitness);
 
%Same values for 100dim = 1.4871
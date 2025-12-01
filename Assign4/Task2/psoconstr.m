addpath('testfcns');

% Define constants for cognitive, social, and inertia weights
w = 1;           
phi1 = 4;            
phi2 = 2;            

% Calculate the constriction factor (χ)
phi = phi1 + phi2;
chi = 2 / abs(phi - 2 + sqrt(phi^2 - 4*phi));

% Apply constriction factor to inertia weight, cognitive and social components
w = w * chi;           
c1 = phi1 * chi;         
c2 = phi2 * chi;        
fprintf('Constriction Factor (χ) = %.4f\n', chi);
fprintf('Updated Inertia Weight (w) = %.4f\n', w);
fprintf('Updated Cognitive Component (c1) = %.4f\n', c1);
fprintf('Updated Social Component (c2) = %.4f\n', c2);


% Initialize the options with the adjusted values
options = psooptimset('DemoMode','fast', ...
    'PlotFcns', {@psoplotswarmsurf, @psoplotbestf, @psoplotvelocity}, ...
    'PopInitRange', [-32; 32], ...
    'InertiaWeight', w, ...  
    'SocialAttraction', c2, ...
    'CognitiveAttraction', c1);

options = psooptimset(options, 'Generations', 500);

% Run PSO optimization
[x, fval] = pso(@ackleysfcn, 20, [], [], [], [], [], [], [], options);

% Save the figure
saveas(gcf, 'figures/min/pso_best_fitness_with_constriction.png');

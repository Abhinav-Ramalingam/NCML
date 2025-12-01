p = [[0; 0] [0; 1] [1; 0] [1; 1]]
t = [0 1 1 0]

learning_rates = [0.1, 2, 20];
num_sessions = 10;

for lr_idx = 1:length(learning_rates)
    lr = learning_rates(lr_idx);
    
    figure; % Create a new figure
    ax = axes; % Get a handle to the figure's axes
    hold on; % Set the figure to not overwrite old plots
    grid on; % Turn on the grid
    title(ax, sprintf('lr = %.1f', lr));  
    
    for session = 1:num_sessions
        net = newff(p, t, [2], {'tansig', 'logsig'}, 'traingd', '', 'mse', {}, {}, '');
        net.trainParam.lr = lr;  
        net.trainParam.epochs = 1000;  
        net.trainParam.min_grad = 0;  
        
        net = init(net);
        [trained_net, stats] = train(net, p, t);
        
        % Print session-specific details
        fprintf('Learning rate: %.1f | Session %d: Final Performance = %e, Gradient = %e, Epochs = %d\n', ...
            lr, session, stats.perf(end), stats.gradient(end), length(stats.perf));
        
        plot(ax, stats.perf, 'DisplayName', sprintf('Session %d', session));
    end
    
    % Add the legend and save the plot
    legend show; % Show legend to differentiate training sessions
    saveas(gcf, sprintf('/Users/abhinavramalingam/Documents/Uppsala/NCML/Assign1/Task1/plot1/plot_lr_%.1f.png', lr)); % Save plot for each learning rate
end

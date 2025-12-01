% Create input and target
p = [[0; 0] [0; 1] [1; 0] [1; 1]];
t = [0 1 1 0];

% Define the network using Rprop
net = newff(p, t, [2], {'tansig', 'logsig'}, 'trainrp', '', 'mse', {}, {}, '');
net.trainParam.delta0 = 0.01;   
net.trainParam.deltamax = 50;  
net.trainParam.delt_inc = 1.2; 
net.trainParam.delt_dec = 0.5; 

% Train the network for 10 sessions
num_sessions = 10;

% Plot performance of each session
figure;   
hold on;
grid on;

for i = 1:num_sessions
    net = init(net);
    [trained_net, stats] = train(net, p, t);
    fprintf('Session %d: Final Performance = %e, Gradient = %e, Epochs = %d\n', ...
        i, stats.perf(end), stats.gradient(end), length(stats.perf));
    plot(stats.perf); 
end

title('Performance Statistics for 10 Training Sessions (Rprop)');
xlabel('Epoch');
ylabel('Performance (Error)');

% Save the plot
saveas(gcf, '/Users/abhinavramalingam/Documents/Uppsala/NCML/Assign1/plot3/performance_rprop.png');

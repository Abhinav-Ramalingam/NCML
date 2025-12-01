p = linspace(0, pi, 10);   % Original 10 data points
t = sin(p) .* sin(5 * p);  % Target values

hidden_nodes = [3, 6, 10, 20];
epochs = 500;

% Generate 10 random test points within the range [0, pi]
p_new = pi * rand(1, 10);   % Random test points between 0 and pi
t_new = sin(p_new) .* sin(5 * p_new);  % True target values for test points

figure;
hold on;
grid on;

for i = 1:length(hidden_nodes)
    % Create and train network using Rprop
    net = newff(p, t, hidden_nodes(i), {'tansig', 'purelin'}, 'trainrp', '', 'mse', {}, {}, '');
    net.trainParam.epochs = epochs;
    net.trainParam.min_grad = 0;
    net.trainParam.show = 50;
    
    net = init(net);
    [trained_net, stats] = train(net, p, t);

    % Plotting the results
    subplot(2, 2, i);
    plot(p, t, 'o', 'MarkerSize', 8, 'DisplayName', 'True Function');
    hold on;
    plot(p, trained_net(p), 'x', 'MarkerSize', 8, 'DisplayName', 'Trained Network Output');
    
    % Plot new points
    plot(p_new, t_new, 's', 'MarkerSize', 8, 'DisplayName', 'New Test Points');
    plot(p_new, trained_net(p_new), '*', 'MarkerSize', 8, 'DisplayName', 'Network Output on New Points');
    
    title(['Network with ' num2str(hidden_nodes(i)) ' Hidden Nodes']);
    xlabel('Input (p)');
    ylabel('Output');
    legend('Location', 'best');
    
    % Calculate MSE for training set
    mse_train = stats.perf(end);
    disp(['MSE for network with ' num2str(hidden_nodes(i)) ' hidden nodes on training data: ' num2str(mse_train)]);
    
    % Calculate MSE for test set (new random points)
    output_new = trained_net(p_new);   % Output from network for new test points
    mse_test = mean((output_new - t_new).^2);  % MSE for the new points
    disp(['MSE for network with ' num2str(hidden_nodes(i)) ' hidden nodes on new test data: ' num2str(mse_test)]);
end

saveas(gcf, 'network_function_plot_with_random_test_points_rprop.png');

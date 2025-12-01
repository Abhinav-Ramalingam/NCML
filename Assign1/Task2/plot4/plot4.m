p = linspace(0, pi, 10);
t = sin(p) .* sin(5*p);

hidden_nodes = [3, 6, 10, 20];
epochs = 500;
learning_rate = 0.1;

figure;
hold on;
grid on;

for i = 1:length(hidden_nodes)
    net = newff(p, t, hidden_nodes(i), {'tansig', 'purelin'}, 'traingd', '', 'mse', {}, {}, '');
    net.trainParam.epochs = epochs;
    net.trainParam.lr = learning_rate;
    net.trainParam.min_grad = 0;
    net.trainParam.show = 50;
    
    net = init(net);
    [trained_net, stats] = train(net, p, t);
    
    subplot(2, 2, i);
    plot(p, t, 'o', 'MarkerSize', 8, 'DisplayName', 'True Function');
    hold on;
    plot(p, trained_net(p), 'x', 'MarkerSize', 8, 'DisplayName', 'Trained Network Output');
    title(['Network with ' num2str(hidden_nodes(i)) ' Hidden Nodes']);
    xlabel('Input (p)');
    ylabel('Output');
    legend('Location', 'best');
    
    mse_value = stats.perf(end);
    disp(['MSE for network with ' num2str(hidden_nodes(i)) ' hidden nodes: ' num2str(mse_value)]);
end

saveas(gcf, 'network_function_plot.png');

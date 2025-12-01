save_dir = '/Users/abhinavramalingam/Documents/Uppsala/NCML/Assign1/Task1/plot2';

learning_rates = [0.1, 0.5]; % Selected learning rates
epochs_list = [3000, 1000]; % Corresponding epochs

for i = 1:length(learning_rates)
    net = newff(p, t, [2], {'tansig', 'logsig'}, 'traingd', '', 'mse', {}, {}, '');
    net.trainParam.lr = learning_rates(i); 
    net.trainParam.epochs = epochs_list(i); 
    net.trainParam.min_grad = 0; 

    net = init(net);
    [trained_net, stats] = train(net, p, t);
    
    fprintf('Training with learning rate = %.2f, Epochs = %d\n', learning_rates(i), epochs_list(i));
    
    figure;
    plot_xor(trained_net);
    title(sprintf('XOR Decision Boundary - Learning Rate %.2f, Epochs = %d', learning_rates(i), epochs_list(i)));
    saveas(gcf, fullfile(save_dir, sprintf('xor_decision_boundary_lr_%.2f_epochs_%d.png', learning_rates(i), epochs_list(i))));
    
    figure;
    plot(stats.perf);
    title(sprintf('Training Performance - Learning Rate %.2f, Epochs = %d', learning_rates(i), epochs_list(i)));
    saveas(gcf, fullfile(save_dir, sprintf('performance_plot_lr_%.2f_epochs_%d.png', learning_rates(i), epochs_list(i))));
end

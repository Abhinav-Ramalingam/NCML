load wine_dataset;

hidden_nodes = 15;


% Create and initialize the network
net = newff(wineInputs, wineTargets, hidden_nodes, {'tansig', 'softmax'}, 'trainrp', 'mse');


net = init(net);

% Train the network
[trained_net, stats] = train(net, wineInputs, wineTargets);

% Training stats
disp('Training Stats:');
disp(['Final training performance (MSE): ' num2str(stats.perf(end))]);

% Calculate outputs from the trained network
outputs = sim(trained_net, wineInputs);

% Convert network outputs to class predictions (index of max output)
[~, predicted_classes] = max(outputs, [], 1);

% Convert wineTargets to actual class labels (index of max target value)
[~, true_classes] = max(wineTargets, [], 1);

% Confusion matrix calculation
conf_matrix = confusionmat(true_classes', predicted_classes');

% Print confusion matrix components
disp('Confusion Matrix:');
disp(conf_matrix);

% Calculate TP, TN, FP, FN for each class
for i = 1:3
    TP = conf_matrix(i,i);
    FN = sum(conf_matrix(i,:)) - TP;
    FP = sum(conf_matrix(:,i)) - TP;
    TN = sum(conf_matrix(:)) - TP - FN - FP;

    disp(['Class ' num2str(i) ':']);
    disp(['TP: ' num2str(TP) ', FN: ' num2str(FN) ', FP: ' num2str(FP) ', TN: ' num2str(TN)]);
end

% Plot confusion matrix
figure;
imagesc(conf_matrix);
colorbar;
title('Confusion Matrix');
xlabel('Predicted Class');
ylabel('True Class');

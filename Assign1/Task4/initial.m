% Normalize 
normHouseInputs = mapminmax(houseInputs);

% Create the MLP network with Rprop
hidden_nodes = 20;
net = newff(normHouseInputs, houseTargets, hidden_nodes, {'tansig', 'purelin'}, 'trainrp', '', 'mse', {}, {}, 'dividerand');

% Modify training parameters
net.trainParam.max_fail = 1000;    
net.trainParam.min_grad = 0;      
net.trainParam.epochs = 5000;      

% Train the network
[trained_net, stats] = train(net, normHouseInputs, houseTargets);

% Plot the performance curves for training, validation, and testing
figure;
plotperform(stats);  % This will automatically plot the training, validation, and test error curves

% Save the performance plot
saveas(gcf, '/Users/abhinavramalingam/Documents/Uppsala/NCML/Assign1/Task4/plot5.png');

% Testing the MLP
outputs = sim(trained_net, normHouseInputs);  % Simulate the network to get predictions

% Evaluation and Plotting
mse_test = mean((outputs - houseTargets).^2);
disp(['Test MSE: ' num2str(mse_test)]);

% Plot True vs Predicted House Prices
figure;
plot(houseTargets, 'o', 'DisplayName', 'True Prices');
hold on;
plot(outputs, 'x', 'DisplayName', 'Predicted Prices');
xlabel('Sample Index');
ylabel('Price ($1000)');
legend('show');
title('True vs Predicted House Prices');

% Additional performance metrics
% Calculate R-squared (Coefficient of Determination)
SS_total = sum((houseTargets - mean(houseTargets)).^2);
SS_residual = sum((houseTargets - outputs).^2);
R_squared = 1 - (SS_residual / SS_total);
disp(['R-squared: ' num2str(R_squared)]);

% Calculate Mean Absolute Error (MAE)
mae = mean(abs(outputs - houseTargets));
disp(['Mean Absolute Error (MAE): ' num2str(mae)]);

% Calculate Root Mean Squared Error (RMSE)
rmse = sqrt(mse_test);
disp(['Root Mean Squared Error (RMSE): ' num2str(rmse)]);

import matplotlib.pyplot as plt

epochs = list(range(1, 22))
train_loss = [1.1557, 1.0657, 1.0297, 1.0059, 0.9773, 0.9705, 0.9493, 0.9390, 0.9199, 0.9086, 0.9071, 0.8773, 0.8890, 0.8725, 0.8497, 0.8409, 0.8376, 0.7874, 0.7620, 0.7495, 0.7333]
val_loss = [1.1041, 1.0707, 1.0364, 1.0059, 1.0267, 0.9840, 0.9963, 0.9968, 0.9890, 0.9805, 0.9537, 0.9822, 0.9765, 0.9888, 0.9654, 1.0086, 0.9939, 0.9898, 1.0024, 1.0251, 1.0295]

# Find the best (lowest) validation loss and corresponding epoch
min_val_loss = min(val_loss)
best_epoch = epochs[val_loss.index(min_val_loss)]

plt.figure(figsize=(10, 6))
plt.plot(epochs, train_loss, label='Train Loss', marker='o')
plt.plot(epochs, val_loss, label='Validation Loss', marker='s')

# Highlight best val loss
plt.scatter(best_epoch, min_val_loss, color='red', zorder=5)
plt.annotate(f'Best Val Loss\nEpoch {best_epoch}\n{min_val_loss:.4f}',
             (best_epoch, min_val_loss),
             textcoords="offset points", xytext=(0, -30),
             ha='center', color='red', fontsize=9)

plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.title('Training vs Validation Loss')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig('rnn_loss_plot.png', dpi=300)
plt.close()

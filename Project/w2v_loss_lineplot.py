import matplotlib.pyplot as plt

# Extracted data
epochs = list(range(1, 28))
train_loss = [
    1.3071, 1.2029, 1.1624, 1.1295, 1.1287, 1.1036, 1.0907, 1.0721, 1.0640,
    1.0669, 1.0544, 1.0500, 1.0395, 1.0432, 1.0418, 1.0372, 1.0457, 1.0370,
    1.0404, 1.0376, 1.0303, 1.0286, 1.0329, 1.0252, 1.0285, 1.0225, 1.0314
]
val_loss = [
    1.1879, 1.1503, 1.1206, 1.1169, 1.0740, 1.0635, 1.0817, 1.0700, 1.0698,
    1.0580, 1.0240, 1.0168, 1.0107, 1.0122, 1.0171, 1.0071, 1.0112, 1.0071,
    1.0076, 1.0044, 1.0011, 0.9992, 1.0064, 1.0044, 1.0086, 1.0033, 1.0013
]

# Find best val loss
min_val_loss = min(val_loss)
best_epoch = epochs[val_loss.index(min_val_loss)]

# Plotting
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
plt.title('Training vs Validation Loss (Wav2Vec2 Classifier)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig('wave2vec_loss_plot.png', dpi=300)
plt.close()

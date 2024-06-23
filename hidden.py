import numpy as np
import matplotlib.pyplot as plt
import os

INPUT_SIZE = 784
HIDDEN_SIZE = 128
OUTPUT_SIZE = 10
def load_hidden_layer(filename):
    if not os.path.exists(filename):
        raise FileNotFoundError(f"The file {filename} does not exist.")
    
    hidden_layer = {}
    with open(filename, 'rb') as f:
        hidden_layer['weights'] = np.fromfile(f, dtype=np.float64, count=INPUT_SIZE * HIDDEN_SIZE).reshape((INPUT_SIZE, HIDDEN_SIZE))
        hidden_layer['biases'] = np.fromfile(f, dtype=np.float64, count=HIDDEN_SIZE)
    
    if hidden_layer['weights'].shape != (INPUT_SIZE, HIDDEN_SIZE):
        raise ValueError("The shape of the loaded weights does not match the expected shape.")
    if hidden_layer['biases'].shape != (HIDDEN_SIZE,):
        raise ValueError("The shape of the loaded biases does not match the expected shape.")
    
    return hidden_layer

def save_weights_image(weights, layer_name, num_neurons, output_file):
    num_rows = (num_neurons + 7) // 8  # Ensure at most 8 neurons per row
    fig, axes = plt.subplots(num_rows, 8, figsize=(20, num_rows * 2))
    for i in range(num_neurons):
        row = i // 8
        col = i % 8
        axes[row, col].imshow(weights[:, i].reshape(28, 28), cmap='viridis')
        axes[row, col].set_title(f'Neuron {i+1}')
        axes[row, col].axis('off')
    for j in range(num_neurons, num_rows * 8):
        row = j // 8
        col = j % 8
        fig.delaxes(axes[row, col])  # Remove empty subplots
    plt.suptitle(f'Weights Visualization for {layer_name}')
    plt.savefig(output_file, bbox_inches='tight')
    plt.close()

hidden_layer = load_hidden_layer('hidden_layer.bin')
save_weights_image(hidden_layer['weights'], 'Hidden Layer', HIDDEN_SIZE, 'hidden_layer_weights.png')

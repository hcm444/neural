import numpy as np
import matplotlib.pyplot as plt
import os

INPUT_SIZE = 784
HIDDEN_SIZE = 128
OUTPUT_SIZE = 10

def load_output_layer(filename):
    if not os.path.exists(filename):
        raise FileNotFoundError(f"The file {filename} does not exist.")
    
    output_layer = {}
    with open(filename, 'rb') as f:
        output_layer['weights'] = np.fromfile(f, dtype=np.float64, count=HIDDEN_SIZE * OUTPUT_SIZE).reshape((HIDDEN_SIZE, OUTPUT_SIZE))
        output_layer['biases'] = np.fromfile(f, dtype=np.float64, count=OUTPUT_SIZE)
    
    if output_layer['weights'].shape != (HIDDEN_SIZE, OUTPUT_SIZE):
        raise ValueError("The shape of the loaded weights does not match the expected shape.")
    if output_layer['biases'].shape != (OUTPUT_SIZE,):
        raise ValueError("The shape of the loaded biases does not match the expected shape.")
    
    return output_layer

def save_weights_histogram(weights, layer_name, output_file):
    fig, axes = plt.subplots(1, weights.shape[1], figsize=(20, 2))
    for i in range(weights.shape[1]):
        axes[i].hist(weights[:, i], bins=20, color='skyblue', alpha=0.7)
        axes[i].set_title(f'Neuron {i+1}')
    plt.suptitle(f'Weights Histogram for {layer_name}')
    plt.savefig(output_file, bbox_inches='tight')
    plt.close()

output_layer = load_output_layer('output_layer.bin')
save_weights_histogram(output_layer['weights'], 'Output Layer', 'output_layer_weights_histogram.png')

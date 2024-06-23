#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <time.h>

#define INPUT_SIZE 784
#define HIDDEN_SIZE 128
#define OUTPUT_SIZE 10
#define LEARNING_RATE 0.01
#define EPOCHS 10

typedef struct {
    double weights[INPUT_SIZE][HIDDEN_SIZE];
    double biases[HIDDEN_SIZE];
} HiddenLayer;

typedef struct {
    double weights[HIDDEN_SIZE][OUTPUT_SIZE];
    double biases[OUTPUT_SIZE];
} OutputLayer;

void initialize_layer(HiddenLayer *hidden, OutputLayer *output) {
    srand(time(NULL));
    for (int i = 0; i < INPUT_SIZE; i++) {
        for (int j = 0; j < HIDDEN_SIZE; j++) {
            hidden->weights[i][j] = ((double)rand() / RAND_MAX) * 2 - 1;
        }
    }
    for (int i = 0; i < HIDDEN_SIZE; i++) {
        hidden->biases[i] = ((double)rand() / RAND_MAX) * 2 - 1;
        for (int j = 0; j < OUTPUT_SIZE; j++) {
            output->weights[i][j] = ((double)rand() / RAND_MAX) * 2 - 1;
        }
    }
    for (int i = 0; i < OUTPUT_SIZE; i++) {
        output->biases[i] = ((double)rand() / RAND_MAX) * 2 - 1;
    }
}

double sigmoid(double x) {
    return 1.0 / (1.0 + exp(-x));
}

double sigmoid_derivative(double x) {
    return x * (1.0 - x);
}

void forward_pass(HiddenLayer *hidden, OutputLayer *output, uint8_t *input, double *hidden_output, double *output_output) {
    for (int i = 0; i < HIDDEN_SIZE; i++) {
        double sum = hidden->biases[i];
        for (int j = 0; j < INPUT_SIZE; j++) {
            sum += input[j] / 255.0 * hidden->weights[j][i];
        }
        hidden_output[i] = sigmoid(sum);
    }

    for (int i = 0; i < OUTPUT_SIZE; i++) {
        double sum = output->biases[i];
        for (int j = 0; j < HIDDEN_SIZE; j++) {
            sum += hidden_output[j] * output->weights[j][i];
        }
        output_output[i] = sigmoid(sum);
    }
}

void backward_pass(HiddenLayer *hidden, OutputLayer *output, uint8_t *input, double *hidden_output, double *output_output, uint8_t label) {
    double output_errors[OUTPUT_SIZE];
    double hidden_errors[HIDDEN_SIZE];

    for (int i = 0; i < OUTPUT_SIZE; i++) {
        double target = (i == label) ? 1.0 : 0.0;
        output_errors[i] = (target - output_output[i]) * sigmoid_derivative(output_output[i]);
    }

    for (int i = 0; i < HIDDEN_SIZE; i++) {
        hidden_errors[i] = 0.0;
        for (int j = 0; j < OUTPUT_SIZE; j++) {
            hidden_errors[i] += output_errors[j] * output->weights[i][j];
        }
        hidden_errors[i] *= sigmoid_derivative(hidden_output[i]);
    }

    for (int i = 0; i < OUTPUT_SIZE; i++) {
        output->biases[i] += LEARNING_RATE * output_errors[i];
        for (int j = 0; j < HIDDEN_SIZE; j++) {
            output->weights[j][i] += LEARNING_RATE * output_errors[i] * hidden_output[j];
        }
    }

    for (int i = 0; i < HIDDEN_SIZE; i++) {
        hidden->biases[i] += LEARNING_RATE * hidden_errors[i];
        for (int j = 0; j < INPUT_SIZE; j++) {
            hidden->weights[j][i] += LEARNING_RATE * hidden_errors[i] * (input[j] / 255.0);
        }
    }
}

void train(HiddenLayer *hidden, OutputLayer *output, uint8_t *images, uint8_t *labels, int num_images, int num_epochs) {
    double hidden_output[HIDDEN_SIZE];
    double output_output[OUTPUT_SIZE];

    for (int epoch = 0; epoch < num_epochs; epoch++) {
        for (int i = 0; i < num_images; i++) {
            forward_pass(hidden, output, &images[i * INPUT_SIZE], hidden_output, output_output);
            backward_pass(hidden, output, &images[i * INPUT_SIZE], hidden_output, output_output, labels[i]);
        }
        printf("Epoch %d/%d completed\n", epoch + 1, num_epochs);
    }
}

uint32_t read_uint32(FILE *f) {
    uint32_t result;
    if (fread(&result, sizeof(result), 1, f) != 1) {
        perror("Failed to read uint32_t");
        exit(1);
    }
    return __builtin_bswap32(result);
}

uint8_t* load_mnist_images(const char *filename, int *num_images, int *image_size) {
    FILE *f = fopen(filename, "rb");
    if (!f) {
        perror("Failed to open file");
        exit(1);
    }

    uint32_t magic = read_uint32(f);
    *num_images = read_uint32(f);
    uint32_t rows = read_uint32(f);
    uint32_t cols = read_uint32(f);
    *image_size = rows * cols;

    uint8_t *images = (uint8_t*)malloc((*num_images) * (*image_size));
    if (!images) {
        perror("Failed to allocate memory for images");
        exit(1);
    }

    if (fread(images, *image_size, *num_images, f) != (size_t)(*num_images)) {
        perror("Failed to read images");
        free(images);
        exit(1);
    }

    fclose(f);
    return images;
}

uint8_t* load_mnist_labels(const char *filename, int *num_labels) {
    FILE *f = fopen(filename, "rb");
    if (!f) {
        perror("Failed to open file");
        exit(1);
    }

    uint32_t magic = read_uint32(f);
    *num_labels = read_uint32(f);

    uint8_t *labels = (uint8_t*)malloc(*num_labels);
    if (!labels) {
        perror("Failed to allocate memory for labels");
        exit(1);
    }

    if (fread(labels, 1, *num_labels, f) != (size_t)(*num_labels)) {
        perror("Failed to read labels");
        free(labels);
        exit(1);
    }

    fclose(f);
    return labels;
}

void save_model(const char *hidden_file, const char *output_file, HiddenLayer *hidden, OutputLayer *output) {
    FILE *f_hidden = fopen(hidden_file, "wb");
    if (!f_hidden) {
        perror("Failed to open hidden layer file");
        exit(1);
    }

    if (fwrite(hidden, sizeof(HiddenLayer), 1, f_hidden) != 1) {
        perror("Failed to write hidden layer");
        fclose(f_hidden);
        exit(1);
    }
    fclose(f_hidden);

    FILE *f_output = fopen(output_file, "wb");
    if (!f_output) {
        perror("Failed to open output layer file");
        exit(1);
    }

    if (fwrite(output, sizeof(OutputLayer), 1, f_output) != 1) {
        perror("Failed to write output layer");
        fclose(f_output);
        exit(1);
    }
    fclose(f_output);
}

int main() {
    int num_images, image_size, num_labels;
    uint8_t *images = load_mnist_images("mnist_data/train-images-idx3-ubyte", &num_images, &image_size);
    uint8_t *labels = load_mnist_labels("mnist_data/train-labels-idx1-ubyte", &num_labels);

    if (num_images != num_labels) {
        fprintf(stderr, "Number of images and labels do not match\n");
        exit(1);
    }

    HiddenLayer hidden;
    OutputLayer output;
    initialize_layer(&hidden, &output);

    int num_epochs = EPOCHS;
    train(&hidden, &output, images, labels, num_images, num_epochs);

    save_model("hidden_layer.bin", "output_layer.bin", &hidden, &output);

    free(images);
    free(labels);
    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <time.h>
#define INPUT_SIZE 784
#define HIDDEN_SIZE 128
#define OUTPUT_SIZE 10
#define LEARNING_RATE 0.01
#define EPOCHS 1
#define TEST_IMAGES 10
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

uint8_t recognize(HiddenLayer *hidden, OutputLayer *output, uint8_t *image) {
    double hidden_output[HIDDEN_SIZE];
    double output_output[OUTPUT_SIZE];

    forward_pass(hidden, output, image, hidden_output, output_output);

    uint8_t recognized_digit = 0;
    double max_output = output_output[0];
    for (int i = 1; i < OUTPUT_SIZE; i++) {
        if (output_output[i] > max_output) {
            max_output = output_output[i];
            recognized_digit = i;
        }
    }
    return recognized_digit;
}

uint32_t read_uint32(FILE *f) {
    uint32_t result;
    fread(&result, sizeof(result), 1, f);
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
    fread(images, *image_size, *num_images, f);

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
    fread(labels, 1, *num_labels, f);

    fclose(f);
    return labels;
}

double calculate_accuracy(HiddenLayer *hidden, OutputLayer *output, uint8_t *images, uint8_t *labels, int num_images) {
    int correct_predictions = 0;
    for (int i = 0; i < num_images; i++) {
        uint8_t recognized_digit = recognize(hidden, output, &images[i * INPUT_SIZE]);
        if (recognized_digit == labels[i]) {
            correct_predictions++;
        }
    }
    return (double)correct_predictions / num_images;
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

    double accuracy = calculate_accuracy(&hidden, &output, images, labels, num_images);
    printf("Training accuracy: %.2f%%\n", accuracy * 100);


    for (int i = 0; i < TEST_IMAGES; i++) {
        uint8_t recognized_digit = recognize(&hidden, &output, &images[i * INPUT_SIZE]);
        printf("Image %d: Recognized digit = %d, Actual digit = %d\n", i, recognized_digit, labels[i]);
    }

    free(images);
    free(labels);
    return 0;
}

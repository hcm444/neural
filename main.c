#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#define INPUT_SIZE 784
#define HIDDEN_SIZE 128
#define OUTPUT_SIZE 10
#define TEST_IMAGES 10

typedef struct {
    double weights[INPUT_SIZE][HIDDEN_SIZE];
    double biases[HIDDEN_SIZE];
} HiddenLayer;

typedef struct {
    double weights[HIDDEN_SIZE][OUTPUT_SIZE];
    double biases[OUTPUT_SIZE];
} OutputLayer;

double sigmoid(double x) {
    return 1.0 / (1.0 + exp(-x));
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
    if (fread(&result, sizeof(result), 1, f) != 1) {
        perror("Failed to read uint32_t");
        exit(1);
    }
    return __builtin_bswap32(result);
}

uint8_t* load_mnist_images(const char *filename, int *num_images, int *image_size) {
    FILE *f = fopen(filename, "rb");
    if (!f) {
        perror("Failed to open images file");
        exit(1);
    }
    printf("Opened image file: %s\n", filename);

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

void load_model(const char *hidden_file, const char *output_file, HiddenLayer *hidden, OutputLayer *output) {
    printf("Loading hidden layer model from %s\n", hidden_file);
    FILE *f_hidden = fopen(hidden_file, "rb");
    if (!f_hidden) {
        perror("Failed to open hidden layer file");
        exit(1);
    }

    if (fread(hidden, sizeof(HiddenLayer), 1, f_hidden) != 1) {
        perror("Failed to read hidden layer");
        fclose(f_hidden);
        exit(1);
    }
    fclose(f_hidden);

    printf("Loading output layer model from %s\n", output_file);
    FILE *f_output = fopen(output_file, "rb");
    if (!f_output) {
        perror("Failed to open output layer file");
        exit(1);
    }

    if (fread(output, sizeof(OutputLayer), 1, f_output) != 1) {
        perror("Failed to read output layer");
        fclose(f_output);
        exit(1);
    }
    fclose(f_output);
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

uint8_t* load_mnist_labels(const char *filename, int *num_labels) {
    FILE *f = fopen(filename, "rb");
    if (!f) {
        perror("Failed to open labels file");
        exit(1);
    }
    printf("Opened label file: %s\n", filename);

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

int main() {
    HiddenLayer hidden;
    OutputLayer output;

    load_model("hidden_layer.bin", "output_layer.bin", &hidden, &output);

    int num_images, image_size, num_labels;
    uint8_t *images = load_mnist_images("mnist_data/train-images-idx3-ubyte", &num_images, &image_size);
    uint8_t *labels = load_mnist_labels("mnist_data/train-labels-idx1-ubyte", &num_labels);

    if (num_images != num_labels) {
        fprintf(stderr, "Number of images and labels do not match\n");
        exit(1);
    }

    double accuracy = calculate_accuracy(&hidden, &output, images, labels, num_images);
    printf("Accuracy: %.2f%%\n", accuracy * 100);

    for (int i = 0; i < TEST_IMAGES; i++) {
        uint8_t recognized_digit = recognize(&hidden, &output, &images[i * INPUT_SIZE]);
        printf("Image %d: Recognized as %d, Actual %d\n", i + 1, recognized_digit, labels[i]);
    }

    free(images);
    free(labels);
    return 0;
}

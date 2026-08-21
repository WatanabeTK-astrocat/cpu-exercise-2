// #include <stdio.h>  // uncomment this line if you want to use printf
volatile int* const sum_loc = (int*)0x1000;  // Memory-mapped I/O address for the sum result

volatile int* const array = (int*)0x2000;
// volatile int array[4096];

int sum_array(int size);

// mainを一番上に
int main(int argc, char* argv[]) {
    int size = 8;

    array[0] = 5;
    array[1] = 9;
    array[2] = 1;
    array[3] = 4;
    array[4] = 3;
    array[5] = 2;
    array[6] = 0;
    array[7] = 8;

    int sum = sum_array(size);

    // printf("Sum: %d\n", sum);  // Print the sum
    *sum_loc = sum;  // Write the sum to the memory-mapped I/O address

    while (1) {
    }  // this infinite loop is to prevent the program from exiting, allowing you to observe the sum in the memory-mapped I/O address.

    return 0;
}

int sum_array(int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += array[i];
    }
    return sum;
}

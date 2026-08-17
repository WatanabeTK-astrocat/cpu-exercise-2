// #include <stdio.h>  // uncomment this line if you want to use printf
volatile short* const sum_loc = (short*)0x1000;  // Memory-mapped I/O address for the sum result

volatile short* const array = (short*)0x2000;
// volatile short array[4096];

short sum_array(short size);

// mainを一番上に
int main(int argc, char* argv[]) {
    short size = 8;

    array[0] = 5;
    array[1] = 9;
    array[2] = 1;
    array[3] = 4;
    array[4] = 3;
    array[5] = 2;
    array[6] = 0;
    array[7] = 8;

    short sum = sum_array(size);

    // printf("Sum: %d\n", sum);  // Print the sum
    *sum_loc = sum;  // Write the sum to the memory-mapped I/O address

    while (1) {
    }  // this infinite loop is to prevent the program from exiting, allowing you to observe the sum in the memory-mapped I/O address.

    return 0;
}

short sum_array(short size) {
    short sum = 0;
    for (short i = 0; i < size; i++) {
        sum += array[i];
    }
    return sum;
}

// #include <stdio.h>  // uncomment this line if you want to use printf

volatile int* const array = (int*)0x2000;
// volatile int array[4096];

void sort(int size);

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

    sort(size);

    while (1) {
    }

    // Uncomment this if you want to print the sorted array
    /* for (short i = 0; i < size; i++) {
        // Print the sorted array
        printf("%d ", array[i]);
    } */

    return 0;
}

/**
 * @brief Bubble sort implementation
 *
 * References:
 *
 * @param size
 */
void sort(int size) {
    int i, j;
    for (i = 0; i < size - 1; i++) {
        for (j = 0; j < size - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

volatile short* const array = (short*)0x2000;

/**
 * @brief Bubble sort implementation
 *
 * References:
 *
 * @param size
 */
void sort(short size) {
    short i, j;
    for (i = 0; i < size - 1; i++) {
        for (j = 0; j < size - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                short temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

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

    sort(size);

    return 0;
}

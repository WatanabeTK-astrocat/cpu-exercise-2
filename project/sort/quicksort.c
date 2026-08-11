volatile short* const array = (short*)0x2000;

/**
 * @brief Swap two elements in the array
 *
 * @param i
 * @param j
 */
void swap(short i, short j) {
    short temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

/**
 * @brief Return the median of three short
 *
 * @param a
 * @param b
 * @param c
 * @return short
 */
short median3(short a, short b, short c) {
    if (a < b) {
        if (b < c) {
            return b;
        } else if (a < c) {
            return c;
        } else {
            return a;
        }
    } else {
        if (a < c) {
            return a;
        } else if (b < c) {
            return c;
        } else {
            return b;
        }
    }
}

void partition(short left, short right) {
    if (left >= right) {
        return;
    }

    short pivot_l = array[left];
    short pivot_r = array[right];
    short pivot_m = array[((right + left) >> 1)];
    short pivot = median3(pivot_l, pivot_m, pivot_r);
    short low = left;
    short high = right;
    while (1) {
        while (low < right && array[low] < pivot) {
            low++;
        }
        if (low >= right) {
            return;
        }
        while (left < high && array[high] > pivot) {
            high--;
        }
        if (left >= high) {
            return;
        }
        if (low < high) {
            swap(low, high);
        } else {
            partition(left, high - 1);
            partition(high, right);
            return;
        }
    }
}

/**
 * @brief Quick sort implementation
 *
 * References:
 * https://ja.wikipedia.org/wiki/%E3%82%AF%E3%82%A4%E3%83%83%E3%82%AF%E3%82%BD%E3%83%BC%E3%83%88
 * https://qiita.com/Midori_M/items/4bb4e036beac50bb782e
 *
 * @param size
 */
void sort(short size) {
    partition(0, size - 1);
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

volatile int* const array = (int*)0x2000;

void swap(int i, int j);
int median3(int a, int b, int c);
void partition(int left, int right);
void sort(int size);

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

    return 0;
}

/**
 * @brief Swap two elements in the array
 *
 * @param i
 * @param j
 */
void swap(int i, int j) {
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

/**
 * @brief Return the median of three int
 *
 * @param a
 * @param b
 * @param c
 * @return int
 */
int median3(int a, int b, int c) {
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

void partition(int left, int right) {
    if (left >= right) {
        return;
    }

    int pivot_l = array[left];
    int pivot_r = array[right];
    int pivot_m = array[((right + left) >> 1)];
    int pivot = median3(pivot_l, pivot_m, pivot_r);
    int low = left;
    int high = right;
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
void sort(int size) {
    partition(0, size - 1);
}

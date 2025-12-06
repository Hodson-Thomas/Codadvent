#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

double averageWeight(int weights[], int length) {
    int s = 0;
    for (int i = 0; i < length; i++) {
        s += weights[i];
    }
    return s / length;
}

void test() {
    printf("Testing average weight ...\n");

    int test1[] = { 2, 5, 7, 10 };
    int test2[] = { 2 };
    int test3[0];
    int test4[] = { 1, 2 };
    int test5[] = { INT_MAX, 1 };

    printf("Test 1 ... ");
    assert(averageWeight(test1, 4) == 6);
    printf("Pass !\n"); 

    printf("Test 2 ... ");
    assert(averageWeight(test2, 1) == 2);
    printf("Pass !\n");

    printf("Test 3 ... ");
    assert(averageWeight(test3, 0) == 0);
    printf("Pass !\n");

    printf("Test 4 ... ");
    assert(averageWeight(test4, 2) == 1.5);
    printf("Pass !\n");

    printf("Test 5 ... ");
    assert(averageWeight(test5, 2) == -1);
    printf("Pass !\n");
}

int main(int argc, char **argv) {
    test();
    return EXIT_SUCCESS;
}

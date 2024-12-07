#include <stdio.h>
#include <math.h>

int main() {
    double x;
    printf("Enter value for x: ");
    scanf("%lf", &x);

    double result = exp(x);
    printf("e^%f = %f\n", x, result);

    return 0;
}


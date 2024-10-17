#include "func.h"
#include <cmath>  


// FuncA computes the sum of the first n terms of the series expansion of e^x.
// The parameter n specifies the number of terms to be included in the sum.
double Func::FuncA(int n) {
    double sum = 0;

    for (int i = 0; i < n; ++i) {
        sum += std::pow(1.0, i) / std::tgamma(i + 1); // Using gamma function for factorial

    }

    return sum; // master test

}



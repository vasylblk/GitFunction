#include "func.h"
#include <cmath>  


double Func::FuncA(int n) {
    double sum = 0;
    for (int i = 0; i < n; ++i) {
        sum += std::pow(1.0, i) / std::tgamma(i + 1);  
    }
    return sum;
}


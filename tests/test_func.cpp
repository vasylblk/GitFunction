#include <gtest/gtest.h>
#include "func.h"

TEST(FuncTest, TestFuncA) {
    Func f;
    EXPECT_NEAR(f.FuncA(5), 2.70833, 0.0001);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

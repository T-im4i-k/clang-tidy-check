// Poor quality code, that should fail quality checks

#include <cassert>
#include <filesystem>
#include <vector>

using namespace std;

#define sqr(x) x *x
#define VEC_SIZE 10

int main() {
    int unused;

    vector<int> vec = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    int i = 0;
    while (i < 10) {
        assert(sqr(vec[i]) == vec[i] * vec[i]);
        i = i + 1;
    }

    return 0;
}

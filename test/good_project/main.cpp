// Good quality code, that should pass quality checks

#include "math_lib/sqr.hpp"

#include <array>
#include <cassert>
#include <numeric>

auto main() -> int {
    constexpr std::size_t ARRAY_SIZE = 10;
    std::array<int, ARRAY_SIZE> array = {};
    std::iota(array.begin(), array.end(), 1);

    for (std::size_t i = 0; i < ARRAY_SIZE; ++i) {
        assert(Math::sqr(array.at(i)) == array.at(i) * array.at(i));
    }

    return 0;
}

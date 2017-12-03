package require math::linearalgebra

set A {
    {1.00  0.00  0.00  0.00  0.00   0.00}
    {1.00  0.63  0.39  0.25  0.16   0.10}
    {1.00  1.26  1.58  1.98  2.49   3.13}
    {1.00  1.88  3.55  6.70 12.62  23.80}
    {1.00  2.51  6.32 15.88 39.90 100.28}
    {1.00  3.14  9.87 31.01 97.41 306.02}
}
set b {-0.01 0.61 0.91 0.99 0.60 0.02}
puts -nonewline [math::linearalgebra::show [math::linearalgebra::solveGauss $A $b] "%.2f"]

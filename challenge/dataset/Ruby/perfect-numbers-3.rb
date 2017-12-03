def perf(n)
  divisors = []
  for i in 1..Math.sqrt(n)
    divisors << i << n/i  if n % i == 0
  end
  divisors.uniq.inject(:+) == 2*n
end

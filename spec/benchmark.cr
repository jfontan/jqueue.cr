require "benchmark"
require "../src/jdeque"

def work(q)
  100_000_000.times do |n|
    q.push n
  end

  50_000_000.times do
    q.pop
  end

  100_000_000.times do |n|
    q.push n
  end
end

Benchmark.bm do |b|
  b.report("Jqueue (1024):") do
    q = Jdeque::Queue(Int32).new(1024)
    work(q)
  end
  b.report("Jqueue (1024000):") do
    q = Jdeque::Queue(Int32).new(1024000)
    work(q)
  end
  b.report("Array") do
    q = Array(Int32).new
    work(q)
  end
  b.report("Deque") do
    q = Deque(Int32).new
    work(q)
  end
end

puts "jqueue(1024)", Benchmark.memory {
  q = Jdeque::Queue(Int32).new(1024)
  work(q)
}

puts "jqueue(1024000)", Benchmark.memory {
  q = Jdeque::Queue(Int32).new(1024000)
  work(q)
}

puts "deque", Benchmark.memory {
  q = Deque(Int32).new
  work(q)
}


require "benchmark"
require "../src/jdeque"

def work(q)
    10_000_000.times do |n|
        q.push n
    end

    5_000_000.times do
        q.pop
    end

    10_000_000.times do |n|
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


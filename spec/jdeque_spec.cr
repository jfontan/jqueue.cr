require "./spec_helper"

describe Jdeque do
  # TODO: Write tests

  describe Jdeque::Chunk do
    it "should be able to be able to push and pop" do
      c = Jdeque::Chunk(Int32).new(10, nil, nil)

      10.times do |n|
        c.push(n)
      end

      5.times do
        c.pop
      end

      5.times do |n|
        c.push n
      end
    end
  end

  describe Jdeque::Queue do
    it "should create new chunks on push" do
      q = Jdeque::Queue(Int32).new(10)

      10_000_000.times do |n|
        q.push(n)
      end

      # pp q

      10_000_000.times do |n|
        q.pop
      end

      # pp q
    end
  end

  # it "works" do
  #   false.should eq(true)
  # end
end

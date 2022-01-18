require "static_array"

module Jdeque
  VERSION    = "0.1.0"
  CHUNK_SIZE = 1024

  class Chunk(T)
    property left
    property right

    def initialize(@capacity : Int32, @left : Chunk(T)?, @right : Chunk(T)?)
      @start = 0
      @size = 0
      # @buffer = StaticArray(T, @capacity).new(0)
      # @buffer = [@capacity] of T
      # @buffer = Array(T).new(@capacity)
      # @buffer = uninitialized T[@capacity]
      @buffer = Pointer(T).malloc(@capacity)
    end

    def full?
      @size == @capacity
    end

    def empty?
      @size == 0
    end

    def can_push?
      return @start + @size < @capacity
    end

    def can_unshift?
      return @start > 0
    end

    def push(v : T)
      raise "out of bound" if !can_push?

      pos = @start + @size
      @size += 1
      # if pos >= @buffer.size
      #   @buffer.push v
      # else
        @buffer[pos] = v
      # end
    end

    def pop : T?
      return nil if empty?
      pos = @start + @size - 1
      @size -= 1
      @buffer[pos]
    end
  end

  class Queue(T)
    @head : Chunk(T)?
    @tail : Chunk(T)?

    def initialize(@chunk_size : Int32)
    end

    def push(v : T)
      if !@head
        @head = Chunk(T).new(@chunk_size, nil, nil)
        @tail = @head
      end

      head = @head.as(Chunk(T))
      if head.full?
        c = Chunk(T).new(@chunk_size, @head, nil)
        head.right = c
        @head = c
      end

      head = @head.as(Chunk(T))
      head.push(v)
    end

    def pop : T?
      if !@head
        return nil
      end

      head = @head.as(Chunk(T))
      if head.empty?
        @head = head.left
        if !@head
          @tail = nil
          return nil
        end

        @head.as(Chunk(T)).right = nil
      end

      head = @head.as(Chunk(T))
      head.pop
    end
  end
end

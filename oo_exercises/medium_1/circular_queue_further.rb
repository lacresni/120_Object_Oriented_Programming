# Your task is to write a CircularQueue class that implements a circular queue
# for arbitrary objects. The class should obtain the buffer size with an
# argument provided to CircularQueue::new, and should provide the following methods:
#
# - enqueue to add an object to the queue
# - dequeue to remove (and return) the oldest object in the queue.
#   It should return nil if the queue is empty.
#
# You may assume that none of the values stored in the queue are nil
# (however, nil may be used to designate empty spots in the buffer).

class CircularQueue
  attr_reader :size

  def initialize(size)
    @queue = []
    @size = size
  end

  def enqueue(element)
    dequeue if @queue.size == size
    @queue.push(element)
  end

  def dequeue
    @queue.shift
  end
end

# Examples:

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

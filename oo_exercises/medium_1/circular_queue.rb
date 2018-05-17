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
  def initialize(size)
    @queue = Array.new(size)
    @ptr_read = 0
    @ptr_write = 0
    @nb_elements = 0
  end

  def enqueue(element)
    dequeue if queue_full?

    @queue[@ptr_write] = element
    @nb_elements += 1
    @ptr_write = increment_pointer(@ptr_write)
  end

  def dequeue
    return nil if queue_empty?

    ret_val = @queue[@ptr_read]
    @nb_elements -= 1
    @ptr_read = increment_pointer(@ptr_read)

    ret_val
  end

  private

  def queue_full?
    @nb_elements == @queue.size
  end

  def queue_empty?
    @nb_elements == 0
  end

  def increment_pointer(position)
    (position + 1) % @queue.size
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

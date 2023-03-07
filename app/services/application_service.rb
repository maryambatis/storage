class ApplicationService
  
  # prevent Rails form creating new objects to optimize the performance.
  def self.call(*args, &block)
    new(*args, &block).call
  end
end



class ApplicationService
  
  # prevent Rails form creating new objects to optimize the performance.
  def call(*args, &block)
    new(*args, &block).call
  end
end

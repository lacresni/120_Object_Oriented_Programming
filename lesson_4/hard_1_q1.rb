class SecretFile
  attr_reader :logger

  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  def get_data
    logger.create_log_entry(self)
    @data
  end
end

class SecurityLogger
  def initialize
    @logs = []
  end

  def create_log_entry(client)
    @logs << "#{client} accessed secret data on #{Time.now}"
  end

  def display_log
    puts "---- Log entries ----"
    puts @logs
    puts "---------------------"
  end
end

security_log = SecurityLogger.new
nicolas = SecretFile.new("This is my secret", security_log)
bob = SecretFile.new("This is bob's secret", security_log)

security_log.display_log

nicolas.get_data
security_log.display_log
nicolas.get_data
bob.get_data
security_log.display_log

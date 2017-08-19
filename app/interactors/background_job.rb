class BackgroundJob < Interactor

  def initialize(arguments)
    super
  end


  def self.run_block(&block)
    Thread.new do
      yield
      ActiveRecord::Base.connection.close
    end
  end

end
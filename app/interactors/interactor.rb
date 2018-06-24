class Interactor
  include ActiveModel::Validations
  include ErrorRaiser

  attr_reader :arguments

  def initialize( arguments )
    @arguments = arguments
    validate!
  rescue ActiveModel::ValidationError => exception
    invalid exception.model.errors.messages.keys.first,
      exception.model.errors.messages.values.first.first
  end

  def method_missing( name, *args, **kwargs )
    @arguments[ name ]
  end

  def self.call(*args)
    new(*args)
  end

  protected

  def success
    call_handler @interactor_success_handler
  end

  def failure
    call_handler @interactor_failure_handler
  end

  def default_delegate_success_handler
    default_handler_for :success
  end

  def default_delegate_failure_handler
    default_handler_for :failure
  end

  def call_handler(handler)
    handler.call self if handler.is_a? Proc
    @interactor_delegate.send handler, self if @interactor_delegate && handler.is_a?(Symbol)
  end

  def default_handler_for(symbol)
    "#{self.class.name.underscore}_#{symbol}".to_sym
  end
end
# This class represents an interactor. An Interactor is a use case which has a
# success and a failure result, that result is communicated with a callback handler,
# which can be a delegate method or a block.
#
# To create an interactor you should subclassify and then call success or failure, depending
# on the result of the operation.
#
# @example Create an Interactor
#    class MyInteractor < Interactor
#      def initialize( arguments )
#        super
#        do_something
#      end
#
#      def do_something
#        if everything_ok?
#          success
#        else
#          failure
#        end
#      end
#
#      ...
#    end
#
# To use an interactor you should register a callback block or a delegate method, in both cases the
# interactor is passed as an argument.
#
# @example Use an Interactor with callback blocks
#    interactor = SomeInteractor.new( on_success: ->(i) { do_something }, on_failure: ->(i) { do_something_else } )
#
# @example Use an Interactor with delegate methods
#    class MyDelegate
#      def my_interactor_success( interactor )
#        do_something
#      end
#
#      def my_interactor_failure( interactor )
#        do_something_else
#      end
#    end
#
#    delegate = MyDelegate.new
#    interactor = MyInteractor.new( delegate: delegate )
#
# The delegate methods are constructed from the Interactor class lowercased and underscored (camelcase -> underscore) appended
# with `_success` and `_failure`, but can be changed passing the arguments `on_success` and `on_failure`.
class Interactor
# Creates a new interactor.
#
# @param argument_hash [Hash] Arguments to create the interactor with.
# @option argument_hash [Object, nil] :delegate The object to send the success and failure messages.
#    If nil then on_success and on_failure should be procs/lambdas.
# @option argument_hash [Symbol, Proc, nil] :on_success The message to send to the delegate on success, or a proc to be called.
#    If nil, a default message is sent to the delegate, created by the underscored version of the interactor class name
#    appended with `_success`.
# @option argument_hash [Symbol, Proc, nil] :on_failure The message to send to the delegate on failure, or a proc to be called.
#    If nil, a default message is sent to the delegate, created by the underscored version of the interactor class name
#    appended with `_failure`.
  def initialize(argument_hash = {})
    @interactor_success_handler = argument_hash.fetch :on_success, default_delegate_success_handler
    @interactor_failure_handler = argument_hash.fetch :on_failure, default_delegate_failure_handler
    @interactor_delegate = argument_hash.fetch :delegate, nil
  end

# Creates a new interactor
#
# It's a synonym for initialize.
# @see #initialize
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
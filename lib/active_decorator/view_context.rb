require 'request_store'

module ActiveDecorator
  module Controller
    class << self
      def current
        RequestStore.store[:active_decorator_controllers].last
      end

      def push(controller)
        RequestStore.store[:active_decorator_controllers] ||= []
        RequestStore.store[:active_decorator_controllers] << controller
      end

      def pop
        RequestStore.store[:active_decorator_controllers].pop if RequestStore.store[:active_decorator_contorllers]
      end
    end

    module Filter
      extend ActiveSupport::Concern

      included do
        if Rails::VERSION::MAJOR >= 4
          around_action do |controller, blk|
            begin
              ActiveDecorator::Controller.push controller
              blk.call
            ensure
              ActiveDecorator::Controller.pop
            end
          end
        else
          around_filter do |controller, blk|
            begin
              ActiveDecorator::Controller.push controller
              blk.call
            ensure
              ActiveDecorator::Controller.pop
            end
          end
        end
      end
    end
  end
end

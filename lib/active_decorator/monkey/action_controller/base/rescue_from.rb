module ActiveDecorator
  module Monkey
    module ActionController
      module Base
        def rescue_with_handler(*)
          ActiveDecorator::Controller.push(self)
          super
        ensure
          ActiveDecorator::Controller.pop
        end
      end
    end
  end
end

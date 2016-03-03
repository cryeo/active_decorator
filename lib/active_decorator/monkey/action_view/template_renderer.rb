module ActiveDecorator
  module Monkey
    module ActionView
      module TemplateRenderer
        def render(context, options)
          assigns = context.assigns
          assigns.values.each do |assign|
            ActiveDecorator::Decorator.instance.decorate assign
          end
          context.assign(assigns)
          options.values.each do |option|
            ActiveDecorator::Decorator.instance.decorate option
          end
          super
        end
      end
    end
  end
end

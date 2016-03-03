module ActiveDecorator
  module Monkey
    module ActionView
      module TemplateRenderer
        def render(context, options)
          context.assigns.values.each { |assign| ActiveDecorator::Decorator.instance.decorate assign }
          options.values.each { |option| ActiveDecorator::Decorator.instance.decorate option }
          super
        end
      end
    end
  end
end

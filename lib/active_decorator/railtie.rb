require 'active_decorator/controller'
require 'rails'

module ActiveDecorator
  class Railtie < ::Rails::Railtie
    initializer 'active_decorator' do
      ActiveSupport.on_load :action_view do
        require 'active_decorator/monkey/action_view/partial_renderer'
        ActionView::PartialRenderer.send :prepend, ActiveDecorator::Monkey::ActionView::PartialRenderer
        require 'active_decorator/monkey/action_view/template_renderer'
        ActionView::TemplateRenderer.send :prepend, ActiveDecorator::Monkey::ActionView::TemplateRenderer
      end

      ActiveSupport.on_load :action_controller do
        require 'active_decorator/monkey/abstract_controller/rendering'
        ::ActionController::Base.send :prepend, ActiveDecorator::Monkey::AbstractController::Rendering

        require 'active_decorator/monkey/action_controller/base/rescue_from'
        ActionController::Base.send :prepend, ActiveDecorator::Monkey::ActionController::Base

        ActionController::Base.send :include, ActiveDecorator::Controller::Filter
      end

      ActiveSupport.on_load :action_mailer do
        require 'active_decorator/monkey/abstract_controller/rendering'
        ActionMailer::Base.send :prepend, ActiveDecorator::Monkey::AbstractController::Rendering

        if ActionMailer::Base.respond_to? :before_action
          ActionMailer::Base.send :include, ActiveDecorator::Controller::Filter
        end
      end
    end
  end
end

# frozen_string_literal: true

module Decidim
  module Census
    module Admin
      # This controller is the abstract class from which all other controllers of
      # this engine inherit.
      #
      # Note that it inherits from `Decidim::Components::BaseController`, which
      # override its layout and provide all kinds of useful methods.
      # class ApplicationController < Decidim::Admin::Components::BaseController

      class ApplicationController < Decidim::Admin::ApplicationController

        private

        def permission_class_chain
          [
            Decidim::Census::Admin::Permissions,
            Decidim::Admin::Permissions
          ]
        end

      end
    end
  end
end

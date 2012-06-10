if defined?(PremailerRails) 
  PremailerRails.config = {
    preserve_styles: true,
    remove_ids: true
  }

  module PremailerRails
    module CSSHelper
      def self.assets_enabled?
        false
      end
    end
  end
end


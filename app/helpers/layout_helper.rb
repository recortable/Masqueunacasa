# encoding: utf-8
module LayoutHelper

  def main_content_span_size
    size = 8
    size = size - 2 if content_for?(:left)
    size
  end

  def active?(tab_name)
    return 'active' if tab_name == @active_tab
  end
end


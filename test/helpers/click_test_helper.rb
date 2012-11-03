module ClickTestHelper
  def find_action_link(action)
    page.all("a[data-action='#{action}']").first
  end

  def find_action_link!(action)
    page.find("a[data-action='#{action}']")
  end

  def click_submit(name = 'commit')
    page.find("input[name=\"#{name}\"]").click
  end
end

module ApplicationHelper
  def line_break(content)
    return safe_join(content.split("\n"),tag(:br))
  end
end

# frozen_string_literal: true

# ApplicationHelper is a helper module for application-related methods
module ApplicationHelper
  def error_messages_for(object)
    render(partial: 'layouts/error_messages', locals: { object: })
  end

  def status_tag(boolean, options = {})
    options[:true_text] ||= ''
    options[:false_text] ||= ''

    if boolean
      content_tag(:span, options[:true_text], class: 'status true')
    else
      content_tag(:span, options[:false_text], class: 'status false')
    end
  end
end

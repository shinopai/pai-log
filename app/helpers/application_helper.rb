module ApplicationHelper
  # set title per page
  BASE_TITLE = "パイログ - web本棚サービス".freeze
  def full_title(page_title)
    if page_title.blank?
      BASE_TITLE
    else
      "#{page_title} - #{BASE_TITLE}"
    end
  end
end

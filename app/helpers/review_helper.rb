module ReviewHelper
  def review_type_symbol(review)
    review.review_type == "good" ? "○" : "×"
  end

  def review_status_favicon(review)
    if review.status == "checked"
      return "fa-thumbs-up"
    end

    if review.status == "deleted"
      return "fa-trash-alt red"
    end

    ""
  end
end

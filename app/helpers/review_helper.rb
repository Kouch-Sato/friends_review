module ReviewHelper
  def review_type_symbol(review)
    if review.review_type == "good"
      return "far fa-circle card__review-symbol--good mr-1"
    else
      return "fas fa-times card__review-symbol--bad mr-1"
    end
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

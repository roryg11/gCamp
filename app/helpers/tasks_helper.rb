module TasksHelper
  def filter_params(filter)
    return_hash = {
      complete: params[:complete],
      order_by_desc: params[:order_by_desc],
      order_by_due_date: params[:order_by_due_date],
    }
    return_hash.merge(filter)
  end
end

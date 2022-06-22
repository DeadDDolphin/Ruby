require_relative "../view/TourDelete.rb"

require 'fox16'
include Fox

class ControllerDelete
  def initialize(app, model)
    @app = app
    @view = TourDelete.new(@app,self)
    @model = model
  end

  def show
    @view.create
  end

  def delete(value, attr)
    attributes = [
      "hotel_name",
      "country",
      "address",
      "cost",
      "start_date",
      "end_date",
      "tours_count"
    ]
    @model.del_by(value, attributes[attr])
    @model.call_update_in_observers
  end
end

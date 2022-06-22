require_relative "../view/TourEdit.rb"

require 'fox16'
include Fox

class ControllerUpdate
  def initialize(app, model, data)
    @app = app
    @view = TourEdit.new(@app,self)
    @model = model
    @id = data
  end

  def show
    @view.create
  end

  def update_record(new_value, label)
    attributes = [
      "hotel_name",
      "country",
      "address",
      "cost",
      "start_date",
      "end_date",
      "tours_count"
    ]
    @model.update_record(@id, new_value, attributes[label])
    @model.call_update_in_observers
  end
end

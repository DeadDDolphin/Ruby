require "./view/TourAdd.rb"

require 'fox16'
include Fox

class ControllerAdd
  def initialize(app, model)
    @app = app
    @view = TourAdd.new(@app,self)
    @model = model
  end

  def show
    @view.create
  end

  def add(data)
    @model.add(data)
    @model.call_update_in_observers
  end
end

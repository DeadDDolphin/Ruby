require_relative "../view/DisplayTours.rb"
require_relative "../Model/Tours.rb"
require_relative "ControllerAdd.rb"
require_relative "ControllerUpdate.rb"


require 'fox16'
include Fox

class MainController
  def initialize(path)
    @path = path
    @app = FXApp.new
    @view = DisplayTours.new(@app,self)
    @model = Tours.new(@path)
    @model.add_observer(self)
  end

  def show_table
    update_table
    @app.create
    @app.run
  end

  def update
    @view.clear_table
    update_table
  end

  def update_table
    @view.set_table(@model.get_data.map{|hash| hash.values})
  end

  def add_record
    controller_add = ControllerAdd.new(@app, @model)
    controller_add.show
  end

  def delete_record(id)
    @model.del_by_id(id)
    @model.call_update_in_observers
  end

  def update_record(id)
    controller_update = ControllerUpdate.new(@app, @model, id)
    controller_update.show
  end

  def save
    @model.write_to_json(@path)
  end

end

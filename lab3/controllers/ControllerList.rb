require "/home/dolph/Документы/GitHub/Ruby/lab3/view/ViewList.rb"
require "/home/dolph/Документы/GitHub/Ruby/lab3/ListEmployee.rb"
require_relative "./ControllerAdd.rb"
require_relative "./ControllerUpdate.rb"


require 'fox16'
include Fox

class ControllerList
  def initialize
    @app = FXApp.new
    @view = ViewList.new(@app,self)
    @model = ListEmployee.new
    @model.users << self
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
    @view.set_table(@model.return_data)
  end

  def add_record
    controller_add = ControllerAdd.new(@app, @model)
    controller_add.show
  end

  def delete_record(value, col)
    attributes = [
      "fio",
      "birth_date",
      "phone_number",
      "address",
      "mail",
      "pasport_serial",
      "speciality",
      "expirience",
      "last_place",
      "last_job",
      "zarplata"
    ]
    @model.del_by(value, attributes[col-1])
    #@model.rewrite_DB
    @model.update
  end

  def update_record(value,attr)
    controller_update = ControllerUpdate.new(@app, @model, [value, attr-1])
    controller_update.show
  end

end
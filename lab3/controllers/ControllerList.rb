require_relative "../view/ViewList.rb"
require_relative "../Model/ListEmployee.rb"
require_relative "ControllerAdd.rb"
require_relative "ControllerUpdate.rb"


require 'fox16'
include Fox

class ControllerList
  def initialize
    @app = FXApp.new
    @view = ViewList.new(@app,self)
    @model = ListEmployee.new
    @model.add_user(self)
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
      "adress",
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
    @model.update_users
  end

  def update_record(value,attr)
    controller_update = ControllerUpdate.new(@app, @model, [value, attr-1])
    controller_update.show
  end

end

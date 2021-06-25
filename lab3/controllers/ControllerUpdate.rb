require_relative "../view/ViewUpdate.rb"

require 'fox16'
include Fox

class ControllerUpdate
  def initialize(app, model, data)
    @app = app
    @view = ViewUpdate.new(@app,self)
    @model = model
    @value = data[0]
    @attr = data[1]
  end

  def show
    @view.create
  end

  def update_record(new_value, label)
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
    @model.update_record(@value, attributes[@attr], new_value, attributes[label])
    #@model.rewrite_DB
    @model.update_users
  end
end

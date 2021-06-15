require_relative "./view/ViewDelete.rb"

require 'fox16'
include Fox

class ControllerDelete
  def initialize(app, model)
    @app = app
    @view = ViewDelete.new(@app,self)
    @model = model
  end

  def show
    @view.create
  end

  def delete(value, attr)
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
    @model.del_by(value, attributes[attr])
    #@model.rewrite_DB
    @model.update
  end
end

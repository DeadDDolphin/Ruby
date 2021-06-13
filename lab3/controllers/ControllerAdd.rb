require "/home/dolph/Документы/GitHub/Ruby/lab3/view/ViewAdd.rb"

require 'fox16'
include Fox

class ControllerAdd
  def initialize(app, model)
    @app = app
    @view = ViewAdd.new(@app,self)
    @model = model
  end

  def show
    @view.create
  end

  def add(data)
    @model.add(data)
    #@model.rewrite_DB
    @model.update
  end
end

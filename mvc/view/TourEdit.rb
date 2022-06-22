require 'fox16'
include Fox

class TourEdit < FXMainWindow

  def initialize(app, controller)
    @controller = controller
    super(app, "Редактирование")
    FXToolTip.new(app)

    contents = FXVerticalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(contents, "Значение аттрибута, которое будет изменено:")

    data_frame = FXHorizontalFrame.new(contents)
    names = [
        "Отель",
        "Страна",
        "Адресс",
        "Стоимость",
        "Дата начала тура",
        "Дата окончания тура",
        "Количество доступных"
    ]

    attr_list = FXListBox.new(data_frame,
      :opts => LISTBOX_NORMAL|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
    attr_list.tipText = "Нажмите мышкой по нужному полю для выбора"
    attr_list.numVisible = 11
    attr_list.helpText = "Нажмите мышкой по нужному полю для выбора"
    names.each{|name| attr_list.appendItem(name)}
    value = FXTextField.new(data_frame, 50)

    update_button  = FXButton.new(contents, "Редактировать")
    update_button.connect(SEL_COMMAND) do |sender, selector, data|
      if attr_list.currentItem != -1 && value.text != ""
        @controller.update_record(value.text, attr_list.currentItem)
      else
        FXMessageBox.warning(self, MBOX_OK,"Warning","Вы должны выбрать элемент из списка и ввести данные")
      end
    end

  end

  def update

  end
  # Create and show this window
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

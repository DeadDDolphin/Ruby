require 'fox16'

include Fox

class TourAdd < FXMainWindow

  def initialize(app, controller)
    @controller = controller
    super(app, "Добавление")

    contents = FXVerticalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    frame_fields = FXVerticalFrame.new(contents,:padding => 10)

    frame_hotel = FXHorizontalFrame.new(frame_fields)
    hotel_label = FXLabel.new(frame_hotel, "Отель:")
    hotel_field = FXTextField.new(frame_hotel, 50, :x=>500)

    frame_country = FXHorizontalFrame.new(frame_fields)
    country_label = FXLabel.new(frame_country, "Страна:")
    country_field = FXTextField.new(frame_country, 50)

    frame_address = FXHorizontalFrame.new(frame_fields)
    address_label = FXLabel.new(frame_address, "Адресс:")
    address_field = FXTextField.new(frame_address, 50)

    frame_cost = FXHorizontalFrame.new(frame_fields)
    cost_label = FXLabel.new(frame_cost, "Стоимость:")
    cost_field = FXTextField.new(frame_cost, 50)

    frame_start_date = FXHorizontalFrame.new(frame_fields)
    start_date_label = FXLabel.new(frame_start_date, "Начало путевки:")
    start_date_field = FXTextField.new(frame_start_date, 50)

    frame_end_date = FXHorizontalFrame.new(frame_fields)
    end_date_label = FXLabel.new(frame_end_date, "Окончание путевки:")
    end_date_field = FXTextField.new(frame_end_date, 50)

    frame_count = FXHorizontalFrame.new(frame_fields)
    count_label = FXLabel.new(frame_count, "Количество путевок:")
    count_field = FXTextField.new(frame_count, 50)

    frame_buttons = FXVerticalFrame.new(contents, :opts => PACK_UNIFORM_WIDTH)
    add_button  = FXButton.new(frame_buttons, "Добавить")
    add_button.connect(SEL_COMMAND) do |sender, selector, data|
      @controller.add([
        hotel_field.text,
        country_field.text,
        address_field.text,
        cost_field.text,
        start_date_field.text,
        end_date_field.text,
        count_field.text
        ])
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

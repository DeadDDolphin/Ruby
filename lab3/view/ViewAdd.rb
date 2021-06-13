require 'fox16'
require 'date'

include Fox

class ViewAdd < FXMainWindow

  def initialize(app, controller)
    @controller = controller
    super(app, "Добавление")

    contents = FXVerticalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    frame_fields = FXVerticalFrame.new(contents,:padding => 10)

    frame_fio = FXHorizontalFrame.new(frame_fields)
    fio_label = FXLabel.new(frame_fio, "ФИО:")
    fio_field = FXTextField.new(frame_fio, 50, :x=>500)

    frame_birth = FXHorizontalFrame.new(frame_fields)
    birth_label = FXLabel.new(frame_birth, "Дата рождения:")
    birth_field = FXTextField.new(frame_birth, 50)

    frame_phone = FXHorizontalFrame.new(frame_fields)
    phone_label = FXLabel.new(frame_phone, "Номер телефона:")
    phone_field = FXTextField.new(frame_phone, 50)

    frame_address = FXHorizontalFrame.new(frame_fields)
    address_label = FXLabel.new(frame_address, "Адресс:")
    address_field = FXTextField.new(frame_address, 50)

    frame_mail = FXHorizontalFrame.new(frame_fields)
    mail_label = FXLabel.new(frame_mail, "Электронная почта:")
    mail_field = FXTextField.new(frame_mail, 50)

    frame_pasport = FXHorizontalFrame.new(frame_fields)
    pasport_label = FXLabel.new(frame_pasport, "Серия паспорта:")
    pasport_field = FXTextField.new(frame_pasport, 50)

    frame_speciality = FXHorizontalFrame.new(frame_fields)
    speciality_label = FXLabel.new(frame_speciality, "Профессия:")
    speciality_field = FXTextField.new(frame_speciality, 50)

    frame_experience = FXHorizontalFrame.new(frame_fields)
    experience_label = FXLabel.new(frame_experience, "Стаж:")
    experience_field = FXTextField.new(frame_experience, 50)

    frame_place = FXHorizontalFrame.new(frame_fields)
    place_label = FXLabel.new(frame_place, "Последнее место работы:")
    place_field = FXTextField.new(frame_place, 50)

    frame_job = FXHorizontalFrame.new(frame_fields)
    job_label = FXLabel.new(frame_job, "Должность:")
    job_field = FXTextField.new(frame_job, 50)

    frame_zarplata = FXHorizontalFrame.new(frame_fields)
    zarplata_label = FXLabel.new(frame_zarplata, "Зарплата:")
    zarplata_field = FXTextField.new(frame_zarplata, 50)

    frame_buttons = FXVerticalFrame.new(contents, :opts => PACK_UNIFORM_WIDTH)
    add_button  = FXButton.new(frame_buttons, "Добавить")
    add_button.connect(SEL_COMMAND) do |sender, selector, data|
      @controller.add([
        fio_field.text,
        birth_field.text,
        phone_field.text,
        address_field.text,
        mail_field.text,
        pasport_field.text,
        speciality_field.text,
        experience_field.text,
        place_field.text,
        job_field.text,
        zarplata_field.text
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

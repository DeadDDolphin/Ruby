require "fox16"
include Fox

class DisplayTours < FXMainWindow

    def initialize(app, controller)
        @controller = controller

        super(app, "Доступные туры", :opts => DECOR_ALL)

        contents = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
        frame_table = FXVerticalFrame.new(contents,
            FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y, :padding => 10)
            

        # Table
        @table = FXTable.new(frame_table, :padding => 2)

        @table.tableStyle |= TABLE_NO_ROWSELECT|TABLE_NO_COLSELECT
        @table.editable = false

        @table.rowHeaderWidth = 30
        @table.visibleRows = 10
        @table.visibleColumns = 6

        @table.setTableSize(10, 7)

        @table.setBackColor(FXRGB(255, 255, 255))
        @table.setCellColor(0, 0, FXRGB(255, 255, 255))
        @table.setCellColor(0, 1, FXRGB(255, 240, 240))
        @table.setCellColor(1, 0, FXRGB(240, 255, 240))
        @table.setCellColor(1, 1, FXRGB(240, 240, 255))

        #set_table(ListEmployee.new.return_data)
        set_size
        names = [
            "Отель",
            "Страна",
            "Адресс",
            "Стоимость",
            "Дата начала тура",
            "Дата окончания тура",
            "Количество доступных"
        ]

        # Initialize column headers
        (0...7).each  do |c|
            @table.setColumnText(c, names[c])
        end
        # Initialize row headers
        (0...10).each { |r| @table.setRowText(r, (r+1).to_s) }

        choosen_row = nil
        @table.connect(SEL_COMMAND) do |sender, selector, pos|

            choosen_row = pos.row
        end

        frame_buttons = FXVerticalFrame.new(contents, :opts => PACK_UNIFORM_WIDTH)
        #present_button = FXButton.new(frame_buttons, "Показать")
        add_button  = FXButton.new(frame_buttons, "Добавить")
        add_button.connect(SEL_COMMAND) do |sender, selector, data|
            @controller.add_record
        end

        delete_button = FXButton.new(frame_buttons, "Удалить")
        delete_button.connect(SEL_COMMAND) do |sender, selector, data|
            if choosen_row != nil
                @controller.delete_record(choosen_row)
            else
                FXMessageBox.warning(self, MBOX_OK,"Warning","Вы должны выбрать элемент из списка")
            end
        end

        update_button = FXButton.new(frame_buttons, "Редактировать")
        update_button.connect(SEL_COMMAND) do |sender, selector, data|
            if choosen_row != nil
                @controller.update_record(choosen_row)
            else
                FXMessageBox.warning(self, MBOX_OK,"Warning","Вы должны выбрать элемент из списка")
            end
        end

        save_button  = FXButton.new(frame_buttons, "Сохранить")
        save_button.connect(SEL_COMMAND) do |sender, selector, data|
            @controller.save
        end

    end

    def clear_table
        (0..9).each do |i|
            (0..6).each do |j|
                @table.setItemText(i,j, "")
            end
        end
    end

    def set_table(list_data)
        list_data.each_with_index do |obj, i|
            obj.each_with_index do |field, j|
                @table.setItemText(i,j, field.to_s)
            end
        end
    end

    def set_size
        @table.setColumnWidth(0, 150)
        @table.setColumnWidth(1, 120)
        @table.setColumnWidth(2, 200)
        @table.setColumnWidth(3, 80)
        @table.setColumnWidth(4, 150)
        @table.setColumnWidth(5, 150)
        @table.setColumnWidth(6, 150)
    end

    def update
    end

    # Create and show this window
    def create
        super
        show(PLACEMENT_SCREEN)
    end

end
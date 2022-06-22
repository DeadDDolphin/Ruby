class Date 
    attr_accessor :value
    def initialize(value)
        self.value = value
    end

    def value=(value)
        if not value =~ /^((0?[1-9])|([12]?\d)|(3[01]))\.((1[012])|(0?[1-9]))\.(([012]\d{3})|(\d{2}))$/
            raise "Uncorrect value: #{value}"
        else
            new_val = value.split(".")
            new_val[0] = new_val[0].sub(/^\d$/, "0"+new_val[0])
            new_val[1] = new_val[1].sub(/^\d$/, "0"+new_val[1])

            if new_val[2].to_i < 100 and new_val[2].to_i > 21
                new_val[2] = "00"+new_val[2]
            elsif new_val[2].to_i < 22
                new_val[2] = "20" + new_val[2]
            elsif new_val[2].to_i < 1000
                new_val[2] = "0" + new_val[2]
            end

            @value = new_val.join(".")
        end
    end

    def compare arr1, arr2
        puts arr1, arr2
        if arr1 == nil
            return 1
        end 

        if arr1[-1].to_i > arr2[-1].to_i
            return 0
        elsif first_date[-1].to_i < second_date[-1].to_i
            return -1
        else 
            return Date.compare( arr1[0..-1], rr2[0..-1])
        end
    end

    def <=> obj
        self.compare( self.value.split("."), obj.value.split("."))
    end

    def to_s
        @value
    end
end
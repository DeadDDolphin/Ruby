require "json"

class Tour

    attr_accessor :hotel_name,
        :country, :address, :cost,
        :start_date, :end_date, :tours_count

    def initialize(data)
        data.instance_of?(Array) ? set_from_array(data) : set_by_hash(data)
    end

    def self.check_date(value)
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

            return new_val.join(".")
        end
    end

    def start_date=(value)
        @start_date = Tour.check_date(value)
    end

    def end_date=(value)
        @end_date = Tour.check_date(value)
    end

    def set_by_hash(hash_data)        
        self.hotel_name = hash_data["hotel_name"]
        self.country = hash_data["country"]
        self.address = hash_data["address"]
        self.cost = hash_data["cost"]
        self.start_date = hash_data["start_date"]
        self.end_date = hash_data["end_date"]
        self.tours_count = hash_data["tours_count"]
    end

    def set_from_array(data)        
        self.hotel_name = data[0]
        self.country = data[1]
        self.address = data[2]
        self.cost = data[3]
        self.start_date = data[4]
        self.end_date = data[5]
        self.tours_count = data[6]
    end

    
    def set_from_json(json_data)        
        set_from_array(JSON.parse(json_data))
    end

    def get_as_hash
        {
            hotel_name: @hotel_name,
            country: @country,
            address: @address,
            cost: @cost,
            start_date: @start_date,
            end_date: @end_date,
            tours_count: @tours_count
        }
    end

    def get_as_json
        get_as_hash.to_json
    end

    def get_all
       return @hotel_name, @country, @address,
        @cost, @start_date, @end_date, @tours_count
    end

    def to_s
        "Тур в '#{@hotel_name}' с #{@start_date} по #{@end_date}. Стоимость - #{@cost}"
    end
end
require_relative "Tour"

class TourCollection
    attr_accessor :tours, :observers

    def initialize *args
        @tours = []
        @observers = []
    end

    def to_s
        @tours.reduce(""){|str, obj| str + obj.to_s + "\n"}
    end

    def read_from_json json_path
        data = JSON.load File.open json_path
        data.each do |key, obj|
            add(obj)
        end
    end

    def write_to_json json_path
        res = @tours.reduce('{') do |str, obj|
            str += '"' + @tours.index(obj).to_s + '"'+ ':' + obj.get_as_json + ','
        end
        res.chop!
        res+='}'
        file = File.open(json_path, "w")
        file.puts res
        file.close        
    end
    
    def write_to_yaml yaml_path
        File.open(yaml_path, "w") do |file|
            file.write(Psych.dump(@tours))
        end
    end

    def read_from_yaml yaml_path
        @tours = Psych.load_file yaml_path
    end
    
    def add(data)
        @tours << Tour.new(data)
    end

    # @param list [Array<Hash>]
    def tours=(list)
        @tours = list.map do |hash|
            Tour.set_by_hash(hash)
        end
    end

    def search_by(value, attr)
        command = "el."+attr
        @tours.map{|el| el if eval(command) == value}.compact
    end

    def del_by_id(id)
        @tours.reject!.with_index{|v, i| i == id }
    end

    def del_by(value, attr)
        search_by(value, attr).each{|el| @tours.delete(el)}
    end

    def update_record(id, new_value, label)
        # cmd = "obj.#{updated_attr} = new_value"
        # search_by(value, attr_for_search).each do |el|
        #     @tours.each{ |obj| obj <=> el ? eval(cmd): obj}
        # end
        @tours[id].instance_variable_set("@#{label}", new_value)
    end
    
    def change_by(value,attr, new_tour)
        search_by(value, attr).each do |el|
            @tours.map!{ |obj| obj <=> el ? new_tour : obj}
        end
    end

    def sort_by(attr)
        @tours.sort_by{|obj| eval("obj."+attr)}
    end

    def get_data
        @tours.map{|obj| obj.get_as_hash}
    end

    #Паттерн наблюдателя
    def call_update_in_observers
        @observers.each{|observer| observer.update}
        write_to_json("model/data_temp.json")
    end

    def add_observer observer
        @observers << observer
    end
end
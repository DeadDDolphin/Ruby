require_relative "Tour"

class TourCollection
    attr_accessor :tours, :observers

    def initialize
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
        File.open(json_path, "w") do |file|
          @tours.each{|obj| file.puts(obj.get_as_json)}
        end
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

    def del_by(value, attr)
        search_by(value, attr).each{|el| @tours.delete(el)}
    end

    def update_record(value, attr_for_search, new_value, updated_attr)
        cmd = "obj.#{updated_attr} = new_value"
        search_by(value, attr_for_search).each do |el|
            @tours.each{ |obj| obj <=> el ? eval(cmd): obj}
        end
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
        @tours.map{|obj| obj.get_as_json}
    end

    #Паттерн наблюдателя
    def call_update_in_observers
        @observers.update
    end

    def add_observer observer
        @observers.add(observer)
    end
end
require_relative "TourCollection"
require "awesome_print"

class Tours
    attr_accessor :model

    def initialize(path)
        self.model = path  
    end
    
    def model=(path)
        puts "here"
        model = TourCollection.new
        case path.split(".")[-1]
        when "json"
            model.read_from_json(path)   
        when "yaml"
            model.read_from_yaml(path)   
        end     

        @model = model
    end

    def to_s
        @model
    end
end


puts Tours.new("data.json").to_s
require_relative "TourCollection"
require "awesome_print"

class Tours < TourCollection
    # attr_accessor :model

    def initialize(path)
        super
        case path.split(".")[-1]
        when "json"
            self.read_from_json(path)   
        when "yaml"
            self.read_from_yaml(path)   
        end   
    end
    
    # def model=(path)
    #     model = TourCollection.new
    #     case path.split(".")[-1]
    #     when "json"
    #         model.read_from_json(path)   
    #     when "yaml"
    #         model.read_from_yaml(path)   
    #     end     

    #     @model = model
    # end

    # def to_s
    #     @model
    # end
end

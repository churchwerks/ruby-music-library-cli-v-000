#require_relative '../config/environment.rb'
module Concerns::Findable
  module ClassMethods
    def find_by_name(name)
      all.detect{|item| item.name == name}
    end
  end

  def find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
end

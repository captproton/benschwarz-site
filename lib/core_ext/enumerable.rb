module Enumerable
  def group_by 
    inject([]) do |groups, element| 
      value = yield(element) 
      if (last_group = groups.last) && last_group.first == value 
        last_group.last << element 
      else 
        groups << [value, [element]] 
      end 
      groups 
    end
  end
end
module Validation
  def self.valid_point?(p)
    p.kind_of?(Integer) && p.between?(0,7)
  end

  def self.valid_coordinate?(c)
    case c
      in [a, b] then 
        return valid_point?(a) && valid_point?(b)
      else return false
    end
  end
end
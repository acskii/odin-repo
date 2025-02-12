require_relative 'verify'

def knight_moves(s, e)
  return [s] if s == e

  dp = [[1,2], [2,1], [1,-2], [-1,2], [-2,1], [2,-1], [-2,-1], [-1,-2]]
  q = [[s, [s]]]
  visited = [s]

  until q.empty?
    point, path = q.shift

    dp.each do |dx, dy| 
      np = [point[0] + dx, point[1] + dy]

      return path + [np] if np == e

      if Validation.valid_coordinate?(np) && !visited.include?(np)
        visited << np
        q << [np, path + [np]]
      end
    end
  end
end
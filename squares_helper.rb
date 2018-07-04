class SquaresHelper
class<<self
    def for(n)
      limit = n + (n-1)
      (4..limit).select {|i|(Math.sqrt(i) % 1) == 0}
    end
  end
end
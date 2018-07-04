require './node.rb'
require './squares_helper.rb'
class PerfectSquares
  def call(n)
    return 'false' if n<15
    squares=SquaresHelper.for(n)
    nodes = (1..n).each_with_object({}) do |i,obj|
      links_for_i=squares.map{|sqrt|sqrt-i}.select{|val| val<=n && val>=1 && val!=i}
      obj[i]=Node.new(val: i, links:  links_for_i)
    end
    head=nodes.values.min
    paths=head.paths
    loop do
      new_paths=paths.each_with_object([]) do |path,object|
        *other,last=path
        nodes[last].paths.each do |sub_pth|
        object<<(other + sub_pth)unless other.include?(sub_pth.last)
      end
    end 
    break if new_paths.empty?
    paths=new_paths
    end
    paths.find{|path|path.size==n}|| 'false'
  end
end

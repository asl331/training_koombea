class Node
  include Comparable
  attr_reader :val
  attr_accessor :links

  def initialize(val:, links:)
    @val=val
    @links=links
  end

  def <=>(other)
    links.size <=> other.links.size
  end

  def paths
    links.map do |link|
      [val,link]
    end
  end
end
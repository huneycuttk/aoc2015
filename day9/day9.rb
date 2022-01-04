test_distances = File.readlines("/Users/kph/Stuff/aoc2015/day9/test-input.txt").map(&:strip)
distances = File.readlines("/Users/kph/Stuff/aoc2015/day9/input.txt").map(&:strip)

class Graph
  def initialize
    @nodes = {}
  end

  def add_edge(from, to, cost)
    @nodes[from] ||= []
    @nodes[from] << [ to, cost ]
  end

  def nodes
    @nodes.keys
  end

  def get_edge_cost(from, to)
    @nodes[from].find { |(dest, cost)| to == dest }.last
  end

  def hamiltonian_paths
    @nodes.keys.permutation(@nodes.keys.length).map do |path|
      path.each_cons(2).map { |(from, to)| get_edge_cost(from, to) }.reduce(&:+)
    end
  end

end

def parse_graph(distances)
  graph = Graph.new

  distances.map { |d| d.split(' ') }.each do |d|
    one = d[0]
    two = d[2]
    distance = d[4].to_i
    graph.add_edge(one, two, distance)
    graph.add_edge(two, one, distance)
  end

  graph
end

test_graph = parse_graph(test_distances)
test_paths = test_graph.hamiltonian_paths
test_shortest = test_paths.min
test_longest = test_paths.max
puts "Test shortest #{test_shortest}" # 605
puts "Test longest #{test_longest}" # 982

graph = parse_graph(distances)
paths = graph.hamiltonian_paths
shortest = paths.min
longest = paths.max
puts "Shortest #{shortest}" # 141
puts "Longest #{longest}" # 736

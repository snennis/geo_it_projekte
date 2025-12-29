/// Represents a single location in the building (room, corridor, etc.)
class Room {
  final String id;
  final String name;
  final String description;

  Room({required this.id, required this.name, required this.description});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) => other is Room && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Represents a connection between two rooms with a description of the action
class Edge {
  final Room from;
  final Room to;
  final String description; // e.g. "durch die Tür in den Flur"
  final double weight; // for pathfinding, default 1

  Edge({
    required this.from,
    required this.to,
    required this.description,
    this.weight = 1.0,
  });
}

/// Represents the entire building as a graph
class Building {
  final String name;
  final Map<String, Room> rooms; // roomId -> Room
  final List<Edge> edges;

  Building({required this.name, required this.rooms, required this.edges});

  /// Get all edges from a specific room
  List<Edge> getEdgesFrom(Room room) {
    return edges.where((edge) => edge.from == room).toList();
  }

  /// Get a room by its ID
  Room? getRoomById(String id) {
    return rooms[id];
  }
}

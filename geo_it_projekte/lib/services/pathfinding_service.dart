import '../models/building_model.dart';

/// Service for finding shortest paths in the building
class PathfindingService {
  /// Finds the shortest path between two rooms using Dijkstra's algorithm
  /// Returns a list of edges representing the path, or null if no path exists
  static List<Edge>? findPath(Building building, Room start, Room goal) {
    if (start == goal) {
      return [];
    }

    final distances = <String, double>{};
    final previous = <String, String?>{};
    final unvisited = <String>{};

    // Initialize
    for (final room in building.rooms.values) {
      distances[room.id] = double.infinity;
      unvisited.add(room.id);
    }
    distances[start.id] = 0;

    while (unvisited.isNotEmpty) {
      // Find unvisited node with smallest distance
      String? current;
      double smallestDistance = double.infinity;

      for (final roomId in unvisited) {
        if (distances[roomId]! < smallestDistance) {
          current = roomId;
          smallestDistance = distances[roomId]!;
        }
      }

      if (current == null || smallestDistance == double.infinity) {
        break; // Unreachable
      }

      if (current == goal.id) {
        return _reconstructPath(building, start.id, goal.id, previous);
      }

      unvisited.remove(current);

      final currentRoom = building.getRoomById(current)!;
      for (final edge in building.getEdgesFrom(currentRoom)) {
        final neighbor = edge.to.id;
        if (!unvisited.contains(neighbor)) continue;

        final alt = distances[current]! + edge.weight;
        if (alt < distances[neighbor]!) {
          distances[neighbor] = alt;
          previous[neighbor] = current;
        }
      }
    }

    return null; // No path found
  }

  /// Reconstructs the path from previous pointers
  static List<Edge> _reconstructPath(
    Building building,
    String startId,
    String goalId,
    Map<String, String?> previous,
  ) {
    final path = <Edge>[];
    String? current = goalId;

    while (current != null && current != startId) {
      final prev = previous[current];
      if (prev == null) break;

      final fromRoom = building.getRoomById(prev)!;
      final toRoom = building.getRoomById(current)!;

      // Find the edge between prev and current
      final edge = building.edges.firstWhere(
        (e) => e.from == fromRoom && e.to == toRoom,
      );

      path.insert(0, edge);
      current = prev;
    }

    return path;
  }
}

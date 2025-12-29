import 'package:flutter/material.dart';
import 'models/building_model.dart';
import 'models/dummy_building.dart';
import 'services/pathfinding_service.dart';
import 'widgets/building_map.dart';

void main() {
  runApp(const GeoITApp());
}

class GeoITApp extends StatelessWidget {
  const GeoITApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gebäude Navigation',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const NavigationScreen(),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late Building building;
  Room? selectedStartRoom;
  Room? selectedTargetRoom;
  List<Edge>? currentPath;
  int currentStepIndex = 0;

  @override
  void initState() {
    super.initState();
    building = DummyBuilding.createBuilding();
  }

  void _startNavigation() {
    if (selectedStartRoom == null || selectedTargetRoom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte Start- und Zielraum auswählen')),
      );
      return;
    }

    final path = PathfindingService.findPath(
      building,
      selectedStartRoom!,
      selectedTargetRoom!,
    );

    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kein Weg zum Ziel gefunden')),
      );
      return;
    }

    setState(() {
      currentPath = path;
      currentStepIndex = 0;
    });
  }

  void _confirmStep() {
    if (currentPath == null) return;

    if (currentStepIndex < currentPath!.length - 1) {
      setState(() {
        currentStepIndex++;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('🎉 Ziel erreicht!')));
      setState(() {
        currentPath = null;
        currentStepIndex = 0;
      });
    }
  }

  void _resetNavigation() {
    setState(() {
      currentPath = null;
      currentStepIndex = 0;
      selectedStartRoom = null;
      selectedTargetRoom = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Indoor Navigation'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: currentPath == null
            ? _buildSelectionScreen()
            : _buildNavigationScreen(),
      ),
    );
  }

  Widget _buildSelectionScreen() {
    final rooms = building.rooms.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Gebäude Navigation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ihr aktueller Raum',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                DropdownButton<Room>(
                  isExpanded: true,
                  value: selectedStartRoom,
                  hint: const Text('Raum auswählen'),
                  items: rooms
                      .map(
                        (room) => DropdownMenuItem(
                          value: room,
                          child: Text(room.name),
                        ),
                      )
                      .toList(),
                  onChanged: (room) {
                    setState(() {
                      selectedStartRoom = room;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Zielraum',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                DropdownButton<Room>(
                  isExpanded: true,
                  value: selectedTargetRoom,
                  hint: const Text('Raum auswählen'),
                  items: rooms
                      .map(
                        (room) => DropdownMenuItem(
                          value: room,
                          child: Text(room.name),
                        ),
                      )
                      .toList(),
                  onChanged: (room) {
                    setState(() {
                      selectedTargetRoom = room;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _startNavigation,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Navigation starten',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationScreen() {
    if (currentPath == null || currentPath!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Sie haben Ihr Ziel erreicht!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _resetNavigation,
              child: const Text('Neue Navigation'),
            ),
          ],
        ),
      );
    }

    final currentEdge = currentPath![currentStepIndex];
    final totalSteps = currentPath!.length;
    final progressPercent = (currentStepIndex + 1) / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BuildingMap(
          building: building,
          currentRoom: selectedStartRoom,
          targetRoom: selectedTargetRoom,
          currentPath: currentPath,
          currentStepIndex: currentStepIndex,
        ),
        Card(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Schritt ${currentStepIndex + 1} von $totalSteps',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progressPercent,
                  minHeight: 8,
                  backgroundColor: Colors.blue[200],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nächster Schritt:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  currentEdge.description,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Von: ',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  currentEdge.from.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nach: ',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  currentEdge.to.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _confirmStep,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
          ),
          child: const Text(
            'Schritt bestätigt',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: _resetNavigation,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Navigation abbrechen',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

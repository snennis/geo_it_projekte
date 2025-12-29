import 'building_model.dart';

/// Creates dummy building data for testing
class DummyBuilding {
  static Building createBuilding() {
    // Create rooms
    final raum101 = Room(id: '101', name: 'Raum 101', description: 'Büro 1');
    final raum102 = Room(id: '102', name: 'Raum 102', description: 'Büro 2');
    final raum103 = Room(
      id: '103',
      name: 'Raum 103',
      description: 'Konferenzraum',
    );
    final raum201 = Room(id: '201', name: 'Raum 201', description: 'Büro 3');
    final raum202 = Room(id: '202', name: 'Raum 202', description: 'Büro 4');
    final raum210 = Room(id: '210', name: 'Raum 210', description: 'Lagerraum');

    final flurEG = Room(
      id: 'F1',
      name: 'Flur EG',
      description: 'Erdgeschoss Flur',
    );
    final flur1 = Room(
      id: 'F2',
      name: 'Flur 1. OG',
      description: '1. Obergeschoss Flur',
    );
    final treppen = Room(
      id: 'S1',
      name: 'Treppenhaus',
      description: 'Haupttreppenhaus',
    );

    // Create rooms map
    final rooms = {
      raum101.id: raum101,
      raum102.id: raum102,
      raum103.id: raum103,
      raum201.id: raum201,
      raum202.id: raum202,
      raum210.id: raum210,
      flurEG.id: flurEG,
      flur1.id: flur1,
      treppen.id: treppen,
    };

    // Create edges (connections)
    final edges = [
      // Ground floor connections
      Edge(
        from: raum101,
        to: flurEG,
        description: 'Gehe aus Raum 101 durch die Tür in den Flur',
      ),
      Edge(from: flurEG, to: raum101, description: 'Gehe zurück in Raum 101'),
      Edge(
        from: raum102,
        to: flurEG,
        description: 'Gehe aus Raum 102 durch die Tür in den Flur',
      ),
      Edge(from: flurEG, to: raum102, description: 'Gehe zurück in Raum 102'),
      Edge(
        from: raum103,
        to: flurEG,
        description: 'Gehe aus dem Konferenzraum in den Flur',
      ),
      Edge(
        from: flurEG,
        to: raum103,
        description: 'Gehe zurück in den Konferenzraum',
      ),

      // Staircase connection
      Edge(from: flurEG, to: treppen, description: 'Gehe in das Treppenhaus'),
      Edge(from: treppen, to: flurEG, description: 'Verlasse das Treppenhaus'),
      Edge(
        from: treppen,
        to: flur1,
        description: 'Gehe die Treppen hinauf zum 1. Obergeschoss',
      ),
      Edge(
        from: flur1,
        to: treppen,
        description: 'Gehe zurück zum Treppenhaus',
      ),

      // First floor connections
      Edge(
        from: raum201,
        to: flur1,
        description: 'Gehe aus Raum 201 in den Flur',
      ),
      Edge(from: flur1, to: raum201, description: 'Gehe zurück in Raum 201'),
      Edge(
        from: raum202,
        to: flur1,
        description: 'Gehe aus Raum 202 in den Flur',
      ),
      Edge(from: flur1, to: raum202, description: 'Gehe zurück in Raum 202'),
      Edge(
        from: raum210,
        to: flur1,
        description: 'Gehe aus dem Lagerraum in den Flur',
      ),
      Edge(
        from: flur1,
        to: raum210,
        description: 'Gehe zurück in den Lagerraum',
      ),
    ];

    return Building(name: 'Beispiel Gebäude', rooms: rooms, edges: edges);
  }
}

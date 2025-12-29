# Indoor Navigation App 🗺️

Eine Flutter-Anwendung für Echtzeit-Navigation in Gebäuden. Die App zeigt einen Gebäudegrundriss, findet den kürzesten Weg zwischen Räumen und führt Benutzer schrittweise zum Ziel.

## Features ✨

- **Gebäudegrundriss-Visualisierung**: Visueller Grundriss mit allen Räumen und Verbindungen
- **Intelligente Navigation**: Dijkstra-Algorithmus zur Berechnung des kürzesten Weges
- **Schrittweise Anleitung**: Benutzer bestätigt jeden abgeschlossenen Schritt
- **Farbcodierte Wegverfolgung**: 
  - 🔵 Blau = Aktueller Raum
  - 🟢 Grün = Zielraum
  - 🟠 Orange = Zukünftige Schritte
  - 🟢 Grüne Linien = Absolvierte Schritte
- **Benutzerfreundliche UI**: Dropdown-Menüs zur Auswahl von Start- und Zielraum
- **Echtzeit-Feedback**: Progress-Anzeige und visuelle Rückmeldungen

## Projekt-Struktur 📁

```
lib/
├── main.dart                    # Haupteingabepunkt und UI
├── models/
│   ├── building_model.dart     # Datenmodelle (Room, Edge, Building)
│   └── dummy_building.dart     # Demo-Gebäudedaten
├── services/
│   └── pathfinding_service.dart # Dijkstra-Pathfinding
└── widgets/
    └── building_map.dart        # Gebäudekarten-Visualization
```

## Datenmodell 📊

### Room
Repräsentiert einen Raum oder Ort im Gebäude.
```dart
Room(
  id: '101',
  name: 'Raum 101',
  description: 'Büro 1'
)
```

### Edge
Verbindung zwischen zwei Räumen mit Beschreibung.
```dart
Edge(
  from: raum101,
  to: flurEG,
  description: 'Gehe aus Raum 101 durch die Tür in den Flur',
  weight: 1.0  // Für Pathfinding
)
```

### Building
Graph-Struktur mit Räumen und Verbindungen.
```dart
Building(
  name: 'Beispiel Gebäude',
  rooms: { 'id': Room, ... },
  edges: [ Edge, ... ]
)
```

## Demo-Gebäude 🏢

Das Demo-Gebäude enthält:
- **Erdgeschoss (EG)**:
  - Raum 101, 102, 103 (Büros/Konferenzraum)
  - Flur EG
  - Treppenhaus

- **1. Obergeschoss (OG)**:
  - Raum 201, 202 (Büros)
  - Raum 210 (Lagerraum)
  - Flur 1. OG

## Installation & Ausführung 🚀

### Voraussetzungen
- Flutter SDK installiert
- Dart SDK (kommt mit Flutter)

### Schritte

1. **Repository klonen**
   ```bash
   git clone https://github.com/snennis/geo_it_projekte.git
   cd geo_it_projekte/geo_it_projekte
   ```

2. **Dependencies installieren**
   ```bash
   flutter pub get
   ```

3. **App starten**
   ```bash
   flutter run
   ```

   Alternativ für macOS:
   ```bash
   flutter run -d macos
   ```

## Verwendung 📱

1. **Startbildschirm**: Wählen Sie Ihren aktuellen Raum aus der Dropdown-Liste
2. **Zielauswahl**: Wählen Sie den Zielraum aus
3. **Navigation starten**: Tippen Sie auf "Navigation starten"
4. **Folgen Sie den Schritten**: 
   - Die App zeigt den nächsten Schritt an
   - Führen Sie den Schritt durch
   - Tippen Sie auf "Schritt bestätigt"
5. **Ziel erreicht**: Die App bestätigt, wenn Sie am Ziel angekommen sind

## Pathfinding-Algorithmus 🔍

Die App verwendet **Dijkstra's Algorithmus**, um den kürzesten Weg zwischen zwei Räumen zu finden:

1. Initialisiert alle Distanzen mit ∞ (außer Startknoten = 0)
2. Besucht iterativ den nächsten unbesuchten Knoten mit kleinster Distanz
3. Aktualisiert Nachbarn mit optimalen Distanzen
4. Bricht ab, wenn das Ziel erreicht ist
5. Rekonstruiert den Pfad aus den Vorgängern

**Komplexität**: O((V + E) log V) mit Binär-Heap

## Technologie-Stack 🛠️

- **Framework**: Flutter
- **Sprache**: Dart
- **Visualisierung**: Canvas (CustomPaint)
- **Architektur**: MVC (Model-View-Controller)

## Erweiterungsmöglichkeiten 🔮

- [ ] Echte Gebäudedaten aus JSON/API laden
- [ ] GPS/Indoor Positioning System Integration
- [ ] Echtzeit-Positionsverfolgung
- [ ] Multiple Etagen-Navigation
- [ ] Barrierfreiheits-Features
- [ ] Mehrsprachige UI
- [ ] Offline-Kartenspeicherung
- [ ] Schrittzähler-Integration
- [ ] Echtzeit-Verkehrsdaten
- [ ] WebGL-basierte 3D-Visualisierung

## Tests 🧪

```bash
flutter test
```

## Lizenz 📄

Dieses Projekt ist Teil des Semesterprojekts für GeoIT.

## Autor 👨‍💻

Dennis - 2025

---

**Viel Erfolg beim Routing!** 🧭

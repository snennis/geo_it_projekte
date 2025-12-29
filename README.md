# geo_it_projekte - Indoor Navigation App 🗺️

Gruppenarbeit für ein Hochschulprojekt: Eine Flutter-Anwendung für Echtzeit-Navigation in Gebäuden.

## Übersicht

Diese App zeigt einen Gebäudegrundriss, berechnet den kürzesten Weg zwischen Räumen und führt Benutzer schrittweise zum Ziel mit Echtzeit-Feedback.

## Features ✨

- **Gebäudegrundriss-Visualisierung**: Interaktiver Grundriss mit allen Räumen und Verbindungen
- **Intelligente Navigation**: Dijkstra-Algorithmus zur Berechnung des kürzesten Weges
- **Schrittweise Anleitung**: Benutzer bestätigt jeden abgeschlossenen Schritt
- **Farbcodierte Wegverfolgung**: 
  - 🔵 Blau = Aktueller Raum
  - 🟢 Grün = Zielraum & absolvierte Schritte
  - 🟠 Orange = Zukünftige Schritte
- **Benutzerfreundliche UI**: Dropdown-Menüs zur Auswahl von Start- und Zielraum
- **Echtzeit-Feedback**: Progress-Anzeige und visuelle Rückmeldungen

## Projekt-Struktur 📁

```
geo_it_projekte/
├── README.md (diese Datei)
└── geo_it_projekte/               # Flutter-Projektordner
    ├── lib/
    │   ├── main.dart              # Haupteingabepunkt und UI
    │   ├── models/
    │   │   ├── building_model.dart    # Room, Edge, Building Klassen
    │   │   └── dummy_building.dart    # Demo-Gebäudedaten
    │   ├── services/
    │   │   └── pathfinding_service.dart # Dijkstra-Pathfinding
    │   └── widgets/
    │       └── building_map.dart       # Canvas-Visualization
    ├── test/
    ├── pubspec.yaml               # Dependencies
    └── README.md                  # Technische Dokumentation
```

## Quick Start 🚀

### Voraussetzungen
- Flutter SDK
- Dart SDK (kommt mit Flutter)

### Installation
```bash
cd geo_it_projekte
flutter pub get
flutter run
```

## Datenmodell 📊

Die App basiert auf einer Graph-Struktur:

- **Rooms**: Räume/Orte im Gebäude
- **Edges**: Verbindungen zwischen Räumen mit Beschreibungen
- **Building**: Graph aus Räumen und Kanten

### Demo-Gebäude
- 2 Geschosse (Erdgeschoss + 1. Obergeschoss)
- 9 Räume/Orte
- Vollständig verbundenes Graph-Netzwerk

## Technologie-Stack 🛠️

| Komponente | Technologie |
|-----------|-------------|
| Framework | Flutter |
| Sprache | Dart |
| Visualisierung | Canvas/CustomPaint |
| Pathfinding | Dijkstra-Algorithmus |
| Architektur | MVC-Pattern |

## Pathfinding-Algorithmus 🔍

**Dijkstra's Shortest Path Algorithm**
- Findet optimal kürzeste Wege zwischen Räumen
- Zeitkomplexität: O((V + E) log V)
- Initialisiert alle Distanzen, besucht iterativ nächste Knoten mit kleinster Distanz
- Rekonstruiert Pfad aus Vorgänger-Pointers

## Benutzer-Anleitung 📱

1. **Start-Bildschirm**: Wählen Sie Ihren aktuellen Raum
2. **Zielauswahl**: Wählen Sie den Zielraum aus
3. **Navigation starten**: Tippen Sie auf "Navigation starten"
4. **Folgen Sie Anweisungen**: 
   - App zeigt nächsten Schritt mit Beschreibung
   - Führen Sie Schritt durch
   - Tippen Sie auf "Schritt bestätigt"
5. **Fertig**: App bestätigt Zielankuft

## Entwicklung 💻

### Code-Qualität
```bash
flutter analyze
```

### Tests ausführen
```bash
flutter test
```

### Build
```bash
flutter build macos    # macOS
flutter build web      # Web
flutter build apk      # Android
```

## Erweiterungsmöglichkeiten 🔮

- [ ] Echte Gebäudedaten von API/JSON laden
- [ ] GPS/Indoor Positioning System Integration
- [ ] Multiple Gebäude unterstützen
- [ ] Echtzeit-Positionsverfolgung
- [ ] 3D-Gebäudevisualisierung
- [ ] Offline-Kartenspeicherung
- [ ] Mehrsprachige Benutzeroberfläche
- [ ] Barrierefreiheits-Features

## Git-Workflow 🔄

```bash
# Änderungen vornehmen
git add .
git commit -m "feat: Beschreibung"
git push origin main
```

## Lizenz 📄

Hochschulprojekt - GeoIT

## Team 👥

Dennis

---

**Weitere Informationen**: Siehe [geo_it_projekte/README.md](geo_it_projekte/README.md) für technische Details

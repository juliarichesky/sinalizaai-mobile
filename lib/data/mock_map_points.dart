import 'package:flutter/material.dart';

enum MapPointKind { trafficLight, flood }

class MapPoint {
  const MapPoint({
    required this.name,
    required this.kind,
    required this.status,
    required this.flow,
    required this.position,
  });

  final String name;
  final MapPointKind kind;
  final String status;
  final String flow;
  final Offset position;
}

const mockMapPoints = [
  MapPoint(
    name: 'Semáforo Av. Paulista',
    kind: MapPointKind.trafficLight,
    status: 'Liberado',
    flow: 'Fluxo normal',
    position: Offset(0.52, 0.19),
  ),
  MapPoint(
    name: 'Semáforo Rua Augusta',
    kind: MapPointKind.trafficLight,
    status: 'Atenção',
    flow: 'Fluxo intenso',
    position: Offset(0.78, 0.40),
  ),
  MapPoint(
    name: 'Semáforo Rua da Consolação',
    kind: MapPointKind.trafficLight,
    status: 'Liberado',
    flow: 'Fluxo normal',
    position: Offset(0.68, 0.72),
  ),
  MapPoint(
    name: 'Alagamento',
    kind: MapPointKind.flood,
    status: 'Alerta',
    flow: 'Risco de inundação',
    position: Offset(0.38, 0.58),
  ),
];

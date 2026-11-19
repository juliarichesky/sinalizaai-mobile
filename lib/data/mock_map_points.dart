import 'package:flutter/material.dart';

enum MapPointKind { trafficLight, flood }

class MapPoint {
  const MapPoint({
    required this.name,
    required this.kind,
    required this.status,
    required this.flow,
    required this.position,
    this.address,
    this.changeTime,
    this.intersection,
    this.operationMode,
    this.lastUpdated,
    this.imageAsset,
  });

  final String name;
  final MapPointKind kind;
  final String status;
  final String flow;
  final Offset position;
  final String? address;
  final String? changeTime;
  final String? intersection;
  final String? operationMode;
  final String? lastUpdated;
  final String? imageAsset;
}

const mockMapPoints = [
  MapPoint(
    name: 'Semáforo Av. Paulista',
    kind: MapPointKind.trafficLight,
    status: 'Liberado',
    flow: 'Fluxo normal',
    position: Offset(0.52, 0.19),
    address: 'Av. Paulista, 1573',
    changeTime: '32s',
    operationMode: 'Dados demonstrativos',
  ),
  MapPoint(
    name: 'Semáforo Rua Augusta',
    kind: MapPointKind.trafficLight,
    status: 'Atenção',
    flow: 'Fluxo intenso',
    position: Offset(0.78, 0.40),
    address: 'Rua Augusta, 1200',
    operationMode: 'Dados demonstrativos',
  ),
  MapPoint(
    name: 'Semáforo Rua da Consolação',
    kind: MapPointKind.trafficLight,
    status: 'Liberado',
    flow: 'Fluxo normal',
    position: Offset(0.68, 0.72),
    address: 'Rua da Consolação, 900',
    changeTime: '18s',
    operationMode: 'Dados demonstrativos',
  ),
  MapPoint(
    name: 'Alagamento',
    kind: MapPointKind.flood,
    status: 'Alerta',
    flow: 'Risco de inundação',
    position: Offset(0.38, 0.58),
  ),
];

class Shelter {
  const Shelter({
    required this.id,
    required this.name,
    required this.distanceMeters,
    required this.isCovered,
    required this.isAccessible,
    this.hasRating = false,
  });

  final String id;
  final String name;
  final int distanceMeters;
  final bool isCovered;
  final bool isAccessible;
  final bool hasRating;

  String get formattedDistance {
    if (distanceMeters >= 1000) {
      final kilometers = distanceMeters / 1000;
      return '${kilometers.toStringAsFixed(1).replaceAll('.', ',')} km';
    }
    return '$distanceMeters m';
  }
}

// Dados exclusivamente demonstrativos, sem disponibilidade em tempo real.
const mockShelters = [
  Shelter(
    id: 'av-paulista',
    name: 'Abrigo Av. Paulista',
    distanceMeters: 350,
    isCovered: true,
    isAccessible: true,
  ),
  Shelter(
    id: 'consolacao',
    name: 'Abrigo Consolação',
    distanceMeters: 750,
    isCovered: true,
    isAccessible: true,
  ),
  Shelter(
    id: 'augusta',
    name: 'Abrigo Augusta',
    distanceMeters: 1200,
    isCovered: false,
    isAccessible: true,
  ),
];

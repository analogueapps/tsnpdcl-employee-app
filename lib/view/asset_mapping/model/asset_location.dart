class AssetLocation {
  final String assetType;
  final String assetCode;
  final double latitude;
  final double longitude;
  final double accuracy;

  AssetLocation({
    required this.assetType,
    required this.assetCode,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
  });
}

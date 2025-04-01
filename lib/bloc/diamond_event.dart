abstract class DiamondEvent {}

class LoadDiamonds extends DiamondEvent {}

class FilterDiamonds extends DiamondEvent {
  final double caratFrom;
  final double caratTo;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final String? sortBy;

  FilterDiamonds({
    required this.caratFrom,
    required this.caratTo,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    this.sortBy,
  });
}
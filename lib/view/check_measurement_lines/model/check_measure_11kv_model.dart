class PoleItem {
  final String title;
  bool isSelected;
  int? selectedQty;

  PoleItem({required this.title, this.isSelected = false, this.selectedQty});

  @override
  String toString() {
    return 'PoleItem(title: $title, isSelected: $isSelected, selectedQty: $selectedQty)';
  }
}
class Common{
  String? _title;
  bool? _isSelected;

  String? get title => _title;

  bool? get isSelected => _isSelected;


  set setIsSelected(bool value) => _isSelected = value;

  Common({required title, required isSelected}){
    _title = title;
    _isSelected = isSelected;
  }

  // Common.fromJson(Map<String,dynamic>)
}
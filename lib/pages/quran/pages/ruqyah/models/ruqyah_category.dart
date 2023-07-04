class RuqyahCategory {
  int? _categoryId;
  String? _categoryName;
  String? _noOfDua;
  String? _imageUrl;

  int? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get imageUrl => _imageUrl;
  String? get noOfDua => _noOfDua;

  RuqyahCategory(
      {required categoryId,
      required categoryName,
      required noOfDua,
      required imageUrl,
      required orderBy}) {
    _categoryId = categoryId;
    _categoryName = categoryName;
    _noOfDua = noOfDua;
    _imageUrl = imageUrl;
  }

  RuqyahCategory.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _noOfDua = json['number_of_duas'];
    _imageUrl = json['image_url'];
  }
}

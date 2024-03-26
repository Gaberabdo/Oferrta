class CategoryModel {
  String? image;
  String? categoryName;
  bool? subCat;
  bool? isSelected;

  CategoryModel({
    this.image,
    this.categoryName,
    this.subCat,
    this.isSelected = false,
  });

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    categoryName = json!['categoryName'];
    image = json['image'];
    subCat = json['subCat'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': categoryName,
      'image': image,
      'subCat': subCat,
    };
  }
}

const String collectionCategory = 'categories';
const String categoryFieldCategoryId = 'categoryId';
const String categoryFieldCategoryName = 'categoryName';
const String categoryFieldProductCount = 'productCount';

class CategoryModel {
  String? categoryId;
  String categoryName;
  num productCount;

  CategoryModel({
    this.categoryId,
    required this.categoryName,
    this.productCount = 0,
  });

//: implement map key constants,toMap, fromMap
  Map<String, dynamic> toMap() => <String, dynamic>{
        categoryFieldCategoryId: categoryId,
        categoryFieldCategoryName: categoryName,
        categoryFieldProductCount: productCount,
      };

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
        categoryId: map[categoryFieldCategoryId],
        categoryName: map[categoryFieldCategoryName],
        productCount: map[categoryFieldProductCount],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;
}

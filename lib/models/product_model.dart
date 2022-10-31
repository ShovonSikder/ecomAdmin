const String collectionProduct = 'products';
const String productFieldId = 'productId';
const String productFieldName = 'productName';
const String productFieldCategory = 'category';
const String productFieldShortDescription = 'shortDescription';
const String productFieldLongDescription = 'longDescription';
const String productFieldSalePrice = 'salePrice';
const String productFieldStock = 'stock';
const String productFieldProductDiscount = 'productDiscount';
const String productFieldThumbnailImageUrl = 'thumbnailImageUrl';
const String productFieldAdditionalImages = 'additionalImage';
const String productFieldAvailable = 'available';
const String productFieldFeatured = 'featured';

class ProductModel {
  String? productId;
  String productName;
  String category;
  String? shortDescription;
  String? longDescription;
  num salePrice;
  num stock;
  num productDiscount;
  String thumbnailImageUrl;
  List<String>? additionalImages;
  bool available;
  bool featured;

  ProductModel({
    this.productId,
    required this.productName,
    required this.category,
    this.shortDescription,
    this.longDescription,
    required this.salePrice,
    required this.stock,
    this.productDiscount = 0,
    required this.thumbnailImageUrl,
    this.additionalImages,
    required this.available,
    this.featured = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productFieldId: productId,
      productFieldName: productName,
      productFieldCategory: category,
      productFieldShortDescription: shortDescription,
      productFieldLongDescription: longDescription,
      productFieldSalePrice: salePrice,
      productFieldStock: stock,
      productFieldProductDiscount: productDiscount,
      productFieldThumbnailImageUrl: thumbnailImageUrl,
      productFieldAdditionalImages: additionalImages,
      productFieldAvailable: available,
      productFieldFeatured: featured,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        productId: map[productFieldId],
        productName: map[productFieldName],
        category: map[productFieldCategory],
        salePrice: map[productFieldSalePrice],
        stock: map[productFieldStock],
        thumbnailImageUrl: map[productFieldThumbnailImageUrl],
        available: map[productFieldAvailable],
        additionalImages: map[productFieldAdditionalImages] != null
            ? map[productFieldAdditionalImages] as List<String>
            : null,
        featured: map[productFieldFeatured],
        longDescription: map[productFieldLongDescription],
        shortDescription: map[productFieldShortDescription],
        productDiscount: map[productFieldProductDiscount],
      );
}

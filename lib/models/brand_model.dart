class BrandModel {
  int? id;
  String? name, images, type, createdAt, updatedAt;

  BrandModel(
      {this.id,
      this.name,
      this.images,
      this.type,
      this.createdAt,
      this.updatedAt});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      images: json['images'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

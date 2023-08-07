class CategoryModel {
  int id;
  String description;
  String icon;
  String color;
  String type;

  CategoryModel({required this.id, required this.description, required this.icon, required this.color, required this.type});

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id'] ?? 0, description: map['description'] ?? '', icon: map['icon'] ?? '', color: map['color'] ?? '', type: map['type'] ?? '');
  }

  static Map<String, dynamic> toMap(CategoryModel category) {
    return <String, dynamic>{
      'id': category.id,
      'description': category.description,
      'icon': category.icon,
      'color': category.color,
      'type': category.type,
    };
  }
}

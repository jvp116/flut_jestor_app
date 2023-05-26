import 'package:flut_jestor_app/models/type_model.dart';

class CategoryModel {
  int id;
  String description;
  String icon;
  String color;
  TypeModel type;

  CategoryModel({required this.id, required this.description, required this.icon, required this.color, required this.type});

  static Map<String, dynamic> toMap(CategoryModel category) {
    return <String, dynamic>{
      'id': category.id,
      'description': category.description,
      'icon': category.icon,
      'color': category.color,
      'type': TypeModel.toMap(category.type),
    };
  }
}

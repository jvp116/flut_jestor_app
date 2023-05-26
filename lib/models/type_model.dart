class TypeModel {
  int id;
  String code;
  String description;

  TypeModel({required this.id, required this.code, required this.description});

  static Map<String, dynamic> toMap(TypeModel type) {
    return <String, dynamic>{
      'id': type.id,
      'code': type.code,
      'description': type.description,
    };
  }
}

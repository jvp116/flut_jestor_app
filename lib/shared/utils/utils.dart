import 'package:flut_jestor_app/models/category_model.dart';
import 'package:flutter/material.dart';

const String basePath = "http://localhost:8080/api/v1";
// 10.0.2.2

// Colors
const Color blueAccent = Color.fromRGBO(23, 93, 145, 0.5);
const Color blue = Color(0xFF175D91);
const Color blueLight = Color(0xFF00A5CF);

const Color greenAccent = Color(0xFF25A539);
const Color green = Color(0xFF196E19);
const Color greenLight = Color(0xFF6BC83D);

const Color yellowAccent = Color(0xFFC46B0F);
const Color yellow = Color(0xFFCCB801);

const Color purple = Color(0xFF4E196E);
const Color purpleLight = Color(0xFF7F6BB3);

const Color red = Color(0xFFD10202);

const Color brown = Color(0xFF7E4409);

List<CategoryModel> listCategories = <CategoryModel>[
  CategoryModel(id: 1, description: 'Alimentação', icon: 'food', color: 'D10202', type: 'S'),
  CategoryModel(id: 2, description: 'Bônus', icon: 'gift', color: '00A5CF', type: 'E'),
  CategoryModel(id: 3, description: 'Compras', icon: 'shopping_cart', color: '4E196E', type: 'S'),
  CategoryModel(id: 4, description: 'Educação', icon: 'study', color: '7F6BB3', type: 'S'),
  CategoryModel(id: 5, description: 'Lazer', icon: 'vacation', color: 'CCB801', type: 'S'),
  CategoryModel(id: 6, description: 'Moradia', icon: 'home', color: 'C46B0F', type: 'S'),
  CategoryModel(id: 7, description: 'Outras entradas', icon: 'others', color: '175D91', type: 'E'),
  CategoryModel(id: 8, description: 'Outras saídas', icon: 'others', color: '175D91', type: 'S'),
  CategoryModel(id: 9, description: 'Pet', icon: 'pet', color: '7E4409', type: 'S'),
  CategoryModel(id: 10, description: 'Renda', icon: 'money', color: '196E19', type: 'E'),
  CategoryModel(id: 11, description: 'Rendimentos', icon: 'growth_curve', color: '25A539', type: 'E'),
  CategoryModel(id: 12, description: 'Saúde', icon: 'heart', color: '25A539', type: 'S'),
  CategoryModel(id: 13, description: 'Transporte', icon: 'car', color: '00A5CF', type: 'S'),
  CategoryModel(id: 14, description: 'Vendas', icon: 'shopping_bag', color: 'D10202', type: 'E'),
];

class Utils {
  SnackBar snackBarError(String text) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
  }

  SnackBar snackBarSuccess(String text) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: green,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
  }
}

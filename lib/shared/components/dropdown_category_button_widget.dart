import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class DropDownCategoryButtonWidget extends StatefulWidget {
  const DropDownCategoryButtonWidget({super.key});

  @override
  State<DropDownCategoryButtonWidget> createState() => _DropDownCategoryButtonWidgetState();
}

// List listCategories = [
//   CategoryModel(id: 1, description: 'Alimentação', icon: 'food', color: 'D10202', type: 'S'),
//   CategoryModel(id: 2, description: 'Bônus', icon: 'gift', color: '00A5CF', type: 'E'),
//   CategoryModel(id: 3, description: 'Compras', icon: 'shopping_cart', color: '4E196E', type: 'S'),
//   CategoryModel(id: 4, description: 'Educação', icon: 'study', color: '7F6BB3', type: 'S'),
//   CategoryModel(id: 5, description: 'Lazer', icon: 'vacation', color: 'CCB801', type: 'S'),
//   CategoryModel(id: 6, description: 'Moradia', icon: 'home', color: 'C46B0F', type: 'S'),
//   CategoryModel(id: 7, description: 'Outras entradas', icon: 'others', color: '175D91', type: 'E'),
//   CategoryModel(id: 8, description: 'Outras saídas', icon: 'others', color: '175D91', type: 'S'),
//   CategoryModel(id: 9, description: 'Pet', icon: 'pet', color: '7E4409', type: 'S'),
//   CategoryModel(id: 10, description: 'Renda', icon: 'money', color: '196E19', type: 'E'),
//   CategoryModel(id: 11, description: 'Rendimentos', icon: 'growth_curve', color: '25A539', type: 'E'),
//   CategoryModel(id: 12, description: 'Saúde', icon: 'heart', color: '25A539', type: 'S'),
//   CategoryModel(id: 13, description: 'Transporte', icon: 'car', color: '00A5CF', type: 'S'),
//   CategoryModel(id: 14, description: 'Vendas', icon: 'shopping_bag', color: 'D10202', type: 'E'),
// ];

List<String> listCategories = <String>[
  'Alimentação',
  'Bônus',
  'Compras',
  'Educação',
  "Lazer",
  "Moradia",
  "Outras entradas",
  "Outras saídas",
  "Pet",
  "Renda",
  "Rendimentos",
  "Saúde",
  "Transporte",
  "Vendas"
];
String? dropdownValue = 'Alimentação';

class _DropDownCategoryButtonWidgetState extends State<DropDownCategoryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return DropdownButton<String>(
            menuMaxHeight: 200,
            borderRadius: BorderRadius.circular(10),
            hint: const Text("Selecione uma categoria"),
            value: dropdownValue,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: blue, size: 36),
            underline: Container(height: 1, color: const Color.fromRGBO(23, 93, 145, 0.25)),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: listCategories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

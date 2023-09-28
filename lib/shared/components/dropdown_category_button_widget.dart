import 'package:flut_jestor_app/models/category_model.dart';
import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class DropDownCategoryButtonWidget extends StatefulWidget {
  final FinancialRecordController financialRecordController;

  const DropDownCategoryButtonWidget({super.key, required this.financialRecordController});

  @override
  State<DropDownCategoryButtonWidget> createState() => _DropDownCategoryButtonWidgetState();
}

class _DropDownCategoryButtonWidgetState extends State<DropDownCategoryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButton<CategoryModel>(
        menuMaxHeight: 200,
        hint: const Text("Selecione uma categoria"),
        value: widget.financialRecordController.selectedCategory,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: blue, size: 36),
        underline: Container(height: 1.5, color: const Color.fromRGBO(23, 93, 145, 0.25)),
        onChanged: (CategoryModel? newValue) {
          setState(() {
            widget.financialRecordController.selectedCategory = newValue!;
          });
        },
        items: listCategories.map((CategoryModel value) {
          return DropdownMenuItem<CategoryModel>(
            value: value,
            child: Text(value.description),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/models/category_model.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/stores/financial_record_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class FinancialRecordController extends ChangeNotifier {
  late FinancialRecordStore? store;
  var state;

  final formKeyNewFinancialRecord = GlobalKey<FormState>();
  var valueController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  final TextEditingController dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController descriptionController = TextEditingController();

  final formKeyEditFinancialRecord = GlobalKey<FormState>();
  TextEditingController categoryEditController = TextEditingController();
  var valueEditController = MoneyMaskedTextController();
  TextEditingController dateEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();

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

  late CategoryModel selectedCategory = listCategories.first;

  initialize(FinancialRecordStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createRecord() async {
    double value = UtilBrasilFields.converterMoedaParaDouble(valueController.text);
    String description = descriptionController.text;
    String date = dateController.text;
    int month = DateTime.parse(formatDate(date)).month;

    int categoryId = selectedCategory.id;
    String type = selectedCategory.type;

    await store!.createRecord(value, description, date, month, categoryId, type);
    notifyListeners();
  }

  Future<void> editRecord(FinancialRecordModel financialRecord) async {
    double value = UtilBrasilFields.converterMoedaParaDouble(valueEditController.text);
    String date = dateEditController.text;
    String description = descriptionEditController.text;
    int month = DateTime.parse(formatDate(date)).month;
    String type = getTypeCategoryForEdit(categoryEditController.text);

    bool isEdited = await store!.editRecord(financialRecord.id, value, description, date, month, type);

    if (isEdited) {
      changeTotalMes(dateIsDifferent(financialRecord.date, date), value, financialRecord);
      changeListRecords(
          dateIsDifferent(financialRecord.date, date), value, financialRecord, formatDate(date), description, categoryEditController.text);
    }
    notifyListeners();
  }

  void changeListRecords(
      bool monthIsDifferent, double value, FinancialRecordModel financialRecord, String date, String description, String categoryDescription) {
    if (monthIsDifferent) {
      state.data.financialRecords.removeAt(recoverIndex(financialRecord.id));
    } else {
      state.data.financialRecords.insert(
          recoverIndex(financialRecord.id), getEditedRecord(financialRecord, value, formatDate(date), description, categoryEditController.text));
      state.data.financialRecords.removeAt(recoverIndex(financialRecord.id) + 1);
    }
  }

  void changeTotalMes(bool monthIsDifferent, double value, FinancialRecordModel financialRecord) {
    if (monthIsDifferent) {
      state.data.totalMes -= financialRecord.value;
    } else {
      state.data.totalMes = state.data.totalMes + (value - financialRecord.value);
    }
  }

  bool dateIsDifferent(String oldDate, String newDate) {
    String oldMonth = oldDate.split('-')[1];
    String newMonth = newDate.split('/')[1];

    String oldYear = oldDate.split('-')[2];
    String newYear = newDate.split('/')[2];

    return (oldMonth != newMonth) || (oldYear != newYear);
  }

  int recoverIndex(int id) {
    for (var obj in state.data.financialRecords) {
      if (obj.id == id) {
        return state.data.financialRecords.indexOf(obj);
      }
    }
    return 0;
  }

  FinancialRecordModel getEditedRecord(
      FinancialRecordModel oldFinancialRecord, double value, String date, String description, String categoryDescription) {
    late CategoryModel categoryModel;
    for (var category in listCategories) {
      if (category.description == categoryDescription) {
        categoryModel = category;
      }
    }

    FinancialRecordModel editedRecord =
        FinancialRecordModel(id: oldFinancialRecord.id, value: value, date: date, description: description, category: categoryModel);
    return editedRecord;
  }

  Future<void> deleteRecord(FinancialRecordModel financialRecord) async {
    bool isDeleted = await store!.deleteRecord(financialRecord.id);

    if (isDeleted) {
      state.data.totalMes - financialRecord.value;
      state.data.financialRecords.remove(financialRecord);
    }
    notifyListeners();
  }

  String processValue(String value) {
    value = (value);
    return value;
  }

  String getDate(DateTime date) {
    return DateFormat("EEEE',' d MMM y", "pt_BR").format(date);
  }

  String formatDate(String date) {
    String dia = date.split('/')[0];
    String mes = date.split('/')[1];
    String ano = date.split('/')[2];

    return '$ano-$mes-$dia';
  }

  String getTypeCategoryForEdit(String categoryDescription) {
    for (var category in listCategories) {
      if (category.description == categoryDescription) {
        return category.type;
      }
    }

    return '';
  }

  TextEditingController getCategoryForEdit(String category) {
    categoryEditController = TextEditingController(text: category);
    return categoryEditController;
  }

  MoneyMaskedTextController getValueForEdit(double value) {
    valueEditController = MoneyMaskedTextController(initialValue: value, decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
    return valueEditController;
  }

  TextEditingController getDateForEdit(String date) {
    dateEditController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.parse(date)));
    return dateEditController;
  }

  TextEditingController getDescriptionForEdit(String description) {
    descriptionEditController = TextEditingController(text: description);
    return descriptionEditController;
  }
}

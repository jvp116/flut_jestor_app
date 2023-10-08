import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/models/category_model.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flut_jestor_app/stores/financial_record_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class FinancialRecordController extends ChangeNotifier {
  late FinancialRecordStore? store;
  var state;

  double totalMes = 0;
  List<FinancialRecordModel> list = [];

  final formKeyNewFinancialRecord = GlobalKey<FormState>();
  var valueController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  TextEditingController dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController descriptionController = TextEditingController();

  final formKeyEditFinancialRecord = GlobalKey<FormState>();
  TextEditingController categoryEditController = TextEditingController();
  var valueEditController = MoneyMaskedTextController();
  TextEditingController dateEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();

  late CategoryModel selectedCategory = listCategories.first;

  initialize(FinancialRecordStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  void fetchRecords(String type) {
    list = state.financialRecords.where((record) {
      switch (record.category.type) {
        case "E":
          record.category.type = 'ENTRADA';
          break;
        case "S":
          record.category.type = 'SAIDA';
          break;
        default:
      }
      return record.category.type == type;
    }).toList();
  }

  void setTotalMes(List<FinancialRecordModel> financialRecords, String type) {
    for (var record in financialRecords) {
      if (record.category.type.contains(type)) {
        totalMes += record.value;
      }
    }
  }

  Future<void> createRecord() async {
    double value = UtilBrasilFields.converterMoedaParaDouble(valueController.text);
    String description = descriptionController.text;
    String date = dateController.text;
    int month = DateTime.parse(formatDate(date)).month;
    int year = DateTime.parse(formatDate(date)).year;

    int categoryId = selectedCategory.id;
    String type = selectedCategory.type;

    bool isCreated = await store!.createRecord(value, description, date, month, year, categoryId, type);
    if (isCreated) {}

    notifyListeners();
  }

  Future<void> editRecord(FinancialRecordModel financialRecord) async {
    double value = UtilBrasilFields.converterMoedaParaDouble(valueEditController.text);
    String date = dateEditController.text;
    String description = descriptionEditController.text;
    int month = DateTime.parse(formatDate(date)).month;
    int year = DateTime.parse(formatDate(date)).year;
    String type = getTypeCategoryForEdit(categoryEditController.text);

    bool isEdited = await store!.editRecord(financialRecord.id, value, description, date, month, year, type);

    if (isEdited) {
      if (dateIsDifferent(financialRecord.date, date)) {
        totalMes -= financialRecord.value;
        list.remove(financialRecord);
        state.financialRecords.removeAt(recoverIndex(financialRecord.id));
      } else {
        totalMes += (value - financialRecord.value);
        state.financialRecords
            .insert(recoverIndex(financialRecord.id), getEditedRecord(financialRecord, value, date, description, categoryEditController.text));
        state.financialRecords.removeAt(recoverIndex(financialRecord.id) + 1);

        list = state.financialRecords;
        list.sort((FinancialRecordModel a, FinancialRecordModel b) => b.date.compareTo(a.date));
        fetchRecords(type == 'E' ? 'ENTRADA' : 'SAIDA');
      }
    }
    notifyListeners();
  }

  bool dateIsDifferent(String oldDate, String newDate) {
    String oldMonth = oldDate.split('-')[1];
    String newMonth = newDate.split('/')[1];

    String oldYear = oldDate.split('-')[0];
    String newYear = newDate.split('/')[2];

    return (oldMonth != newMonth) || (oldYear != newYear);
  }

  int recoverIndex(int id) {
    for (var obj in state.financialRecords) {
      if (obj.id == id) {
        return state.financialRecords.indexOf(obj);
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

    return FinancialRecordModel(id: oldFinancialRecord.id, value: value, date: formatDate(date), description: description, category: categoryModel);
  }

  Future<void> deleteRecord(FinancialRecordModel financialRecord) async {
    int month = DateTime.parse(financialRecord.date).month;
    int year = DateTime.parse(financialRecord.date).year;

    bool isDeleted = await store!.deleteRecord(financialRecord.id, financialRecord.category.type, month, year);

    if (isDeleted) {
      totalMes -= financialRecord.value;
      list.remove(financialRecord);
      state.financialRecords.removeAt(recoverIndex(financialRecord.id));
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

  String formatDateForEdit(String date) {
    String dia = date.split('-')[2];
    String mes = date.split('-')[1];
    String ano = date.split('-')[0];

    return '$dia/$mes/$ano';
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

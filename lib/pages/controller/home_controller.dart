import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/models/chart_data_model.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final formKeyPassword = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPressed = true;
  bool isOut = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  List<ChartData> getChartData(List<FinancialRecordModel> financialRecords) {
    financialRecords = filterListRecords(financialRecords);
    List<ChartData> listChartData = [];

    double valueAlimentacao = 0;
    double valueCompras = 0;
    double valueEducacao = 0;
    double valueLazer = 0;
    double valueMoradia = 0;
    double valuePet = 0;
    double valueSaude = 0;
    double valueTransporte = 0;
    double valueOutrasSaidas = 0;

    for (var record in financialRecords) {
      switch (record.category.description) {
        case alimentacao:
          valueAlimentacao += record.value;
          break;
        case compras:
          valueCompras += record.value;
          break;
        case educacao:
          valueEducacao += record.value;
          break;
        case lazer:
          valueLazer += record.value;
          break;
        case moradia:
          valueMoradia += record.value;
          break;
        case pet:
          valuePet += record.value;
          break;
        case saude:
          valueSaude += record.value;
          break;
        case transporte:
          valueTransporte += record.value;
          break;
        case outrasSaidas:
          valueOutrasSaidas += record.value;
          break;
        default:
      }
    }

    if (valueAlimentacao != 0) {
      listChartData.add(ChartData(alimentacao, valueAlimentacao, red));
    }
    if (valueCompras != 0) {
      listChartData.add(ChartData(compras, valueCompras, purple));
    }
    if (valueEducacao != 0) {
      listChartData.add(ChartData(educacao, valueEducacao, purpleLight));
    }
    if (valueLazer != 0) {
      listChartData.add(ChartData(lazer, valueLazer, yellow));
    }
    if (valueMoradia != 0) {
      listChartData.add(ChartData(moradia, valueMoradia, yellowAccent));
    }
    if (valuePet != 0) {
      listChartData.add(ChartData(pet, valuePet, brown));
    }
    if (valueSaude != 0) {
      listChartData.add(ChartData(saude, valueSaude, green));
    }
    if (valueTransporte != 0) {
      listChartData.add(ChartData(transporte, valueTransporte, blueLight));
    }
    if (valueOutrasSaidas != 0) {
      listChartData.add(ChartData(outrasSaidas, valueOutrasSaidas, blue));
    }

    return listChartData;
  }

  List<FinancialRecordModel> filterListRecords(List<FinancialRecordModel> financialRecords) {
    return financialRecords.where((record) {
      switch (record.category.type) {
        case "S":
          record.category.type = 'SAIDA';
          break;
        default:
      }
      return record.category.type == 'SAIDA';
    }).toList();
  }

  Future<bool> logout(UserService service, String? accessToken) async {
    isOut = await service.logout(accessToken);
    return isOut;
  }

  Future<bool> delete(UserService service, String email) async {
    return await service.delete(email);
  }

  Future<bool> updatePassword(UserService service, String email, String newPassword) async {
    return await service.updatePassword(email, newPassword);
  }

  String getTotalMes(List<FinancialRecordModel> financialRecords) {
    double totalMes = 0;

    for (var record in financialRecords) {
      switch (record.category.type) {
        case "E":
          record.category.type = 'ENTRADA';
          break;
        case "S":
          record.category.type = 'SAIDA';
          break;
        default:
      }

      if (record.category.type.contains('ENTRADA')) {
        totalMes += record.value;
      } else {
        totalMes -= record.value;
      }
    }

    return UtilBrasilFields.obterReal(totalMes, moeda: false);
  }
}

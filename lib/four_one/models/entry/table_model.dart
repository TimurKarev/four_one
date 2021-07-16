import 'package:four_one/four_one/models/big_table_model.dart';

class TableModel {
  List<BigTableModel> rowList;

  TableModel({required this.rowList});

  double get debt {
    double retVal = 0.0;
    if (rowList.isEmpty) {
      return retVal;
    }
    rowList.forEach((model) {
      retVal += model.debt;
    });
    return retVal;
  }

  num getClientDebt(String client, {bool exclude = false}) {
    num retVal = 0;

    rowList.forEach((project) {
      if (!exclude) {
        if (project.client == client) {
          retVal += project.debt;
        }
      } else {
        if (project.client != client) {
          retVal += project.debt;
        }
      }
    });
    return retVal;
  }

  double get futureIncome {
    double retVal = 0.0;
    if (rowList.isEmpty) {
      return retVal;
    }
    rowList.forEach((model) {
      retVal += model.futurePayment;
    });
    return retVal;
  }

  num getClientFutureIncome(String client, {bool exclude = false}) {
    num retVal = 0;
    rowList.forEach((project) {
      if (!exclude) {
        if (project.client == client) {
          retVal += project.futurePayment;
        }
      } else {
        if (project.client != client) {
          retVal += project.futurePayment;
        }
      }
    });
    return retVal;
  }
}
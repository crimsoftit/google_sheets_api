import 'package:flutter/foundation.dart';
import 'package:google_sheets_api/api/sheets/creds/creds.dart';
import 'package:google_sheets_api/models/inv_model.dart';
import 'package:google_sheets_api/models/txn_model.dart';
import 'package:gsheets/gsheets.dart';

class InvSheetsApi {
  static const gsheetCredentials = Creds.credentials;
  static const spreadsheetId = '1IuGj1y8ddCTW4zVEhqeh1M8QLOiOgJyPYcgB9Ma5F24';
  static final gsheets = GSheets(gsheetCredentials);
  static Worksheet? invSheet, txnsSheet;

  static Future init() async {
    try {
      final spreadsheet = await gsheets.spreadsheet(spreadsheetId);

      invSheet = await getWorkSheet(
        spreadsheet,
        title: 'InventorySheet',
      );

      txnsSheet = await getWorkSheet(
        spreadsheet,
        title: "TxnsSheet",
      );

      final invHeaders = InvModel.getHeaders();
      invSheet!.values.insertRow(1, invHeaders);
      if (kDebugMode) {
        print('INVENTORY SHEET HEADERS SET!!');
      }

      final txnsHeaders = TxnModel.getHeaders();
      if (txnsSheet != null) {
        txnsSheet!.values.insertRow(
          1,
          txnsHeaders,
        );
      }
    } catch (e) {
      //ScaffoldMessenger.of(context).
      if (kDebugMode) {
        print('gsheet api init error: $e');
      }
    }
  }

  static Future<Worksheet?> getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future addInvData(List<Map<String, dynamic>> rowList) async {
    if (invSheet == null) return;

    invSheet!.values.map.appendRows(rowList);
  }

  static Future addTxnsData(List<Map<String, dynamic>> txns) async {
    if (txnsSheet == null) return;
    txnsSheet!.values.map.appendRows(txns);
  }
}

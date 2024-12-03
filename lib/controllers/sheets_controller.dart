import 'package:get/get.dart';
import 'package:google_sheets_api/api/sheets/inv_sheets_api.dart';
import 'package:google_sheets_api/models/inv_model.dart';
import 'package:google_sheets_api/models/txn_model.dart';

class SheetsController extends GetxController {
  static SheetsController get instance {
    return Get.find();
  }

  void saveInvData() async {
    final invItemForSave = {
      InvModel.itemId: 1,
      InvModel.itemName: 'royco',
      InvModel.itemQty: 20,
      InvModel.itemBp: 10.00,
    };

    await InvSheetsApi.addInvData([invItemForSave]);
  }

  void saveTxnsData() async {
    final newTxn = {
      TxnModel.txnId: 1,
      TxnModel.txnName: 'royco',
      TxnModel.txnQty: 10,
      TxnModel.txnAmount: 100.0,
    };

    await InvSheetsApi.addTxnsData([newTxn]);
  }
}

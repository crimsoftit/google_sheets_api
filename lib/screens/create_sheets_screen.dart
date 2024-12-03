import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheets_api/controllers/sheets_controller.dart';
import 'package:google_sheets_api/screens/widgets/btn_widget.dart';

class CreateSheetsScreen extends StatelessWidget {
  const CreateSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sheetsController = Get.put(SheetsController());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CBtnWidget(
                btnTxt: 'save inventory',
                onClicked: () async {
                  sheetsController.saveInvData();
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
              CBtnWidget(
                btnTxt: 'save txns',
                onClicked: () async {
                  sheetsController.saveTxnsData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

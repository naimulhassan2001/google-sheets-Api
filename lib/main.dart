import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sheet/controller/user_controller.dart';
import 'package:google_sheet/model/user_model.dart';
import 'package:google_sheet/services/sheet_service.dart';

import 'view/screen/user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: UserScreen(),
    );
  }
}

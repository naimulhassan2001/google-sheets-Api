import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sheet/model/user_model.dart';
import 'package:google_sheet/services/sheet_service.dart';

class UserController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List users = [];

  getSheetData() async {
    var data = await SheetsApi.userSheet!.values.allRows();

    data.removeAt(0);

    users.clear();
    for (var user in data) {
      users.add(UserModel.fromList(user));
      print(user[0]);
    }
    update();

    print(data.runtimeType);
    print(users);
  }

  static UserController get instance => Get.put(UserController());

  insert(List<Map<String, dynamic>> user) async {
    await SheetsApi.userSheet!.values.map.appendRows(user);
  }

  delete(int index) async {
    UserModel user = users[index];
    print(user.email);
    int dara = await SheetsApi.userSheet!.values.rowIndexOf(user.email);
    print(dara);
    if (dara == -1) return;

    await SheetsApi.userSheet!.deleteRow(dara);
    getSheetData();
  }

  addData() async {
    var data = await SheetsApi.userSheet!.values.allRows();
    final user = UserModel(
        id: (data.length + 1).toString(),
        name: nameController.text,
        email: emailController.text,
        isBeginner: "false");

    await insert([user.toJson()]);
    await getSheetData();
    nameController.clear();
    emailController.clear();
    Get.back();
  }

  @override
  void onInit() {
    getSheetData();
    super.onInit();
  }
}

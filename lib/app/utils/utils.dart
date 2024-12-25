import 'package:bs23_boilerplate/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final DateFormat outputFormat = DateFormat(kDateFormat);
  return outputFormat.format(dateTime);
}

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void displayLoading(
    {var value = "Please wait...", bool isHideKeyboard = true}) {
  if (isHideKeyboard) closeSoftKeyBoard();
  EasyLoading.show(status: value);
}

void dismissLoading() {
  EasyLoading.dismiss();
}

void showMessage(String? value, {bool isError = false, bool isInfo = false}) {
  if (isError) {
    dismissLoading();
    EasyLoading.showError("$value");
  } else if (isInfo) {
    EasyLoading.showInfo("$value");
  } else {
    EasyLoading.showSuccess("$value");
  }
}

bool getFileType(String? fileName) {
  bool isSvg = fileName!.split('.').last == "svg" ? true : false;
  return isSvg;
}

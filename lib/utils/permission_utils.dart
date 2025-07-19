import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

import 'dialog.dart';

class Utils {
  static void toast(String msg) {


    Toast.show(msg,
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red);

  }
}

class PermissionUtil {
  /// 安卓权限
  static List<Permission> androidPermissions = <Permission>[
    // 在这里添加需要的权限
    Permission.storage
  ];

  /// ios权限
  static List<Permission> iosPermissions = <Permission>[
    // 在这里添加需要的权限
    Permission.storage
  ];

  static Future<Map<Permission, PermissionStatus>> requestAll() async {
    if (Platform.isIOS) {
      return await iosPermissions.request();
    }
    return await androidPermissions.request();
  }

  static Future<Map<Permission, PermissionStatus>> request(
      Permission permission) async {
    final List<Permission> permissions = <Permission>[permission];
    return await permissions.request();
  }

  static bool isDenied(Map<Permission, PermissionStatus> result) {
    var isDenied = false;
    result.forEach((key, value) {
      if (value == PermissionStatus.denied) {
        isDenied = true;
        return;
      }
    });
    return isDenied;
  }

  static void showDeniedDialog(BuildContext context) {
    HDialog.show(
        context: context,
        title: 'Permission Denied',
        content: 'Please allow permissions for downloading certificate!',
        options: <DialogAction>[
          DialogAction(text: '去设置', onPressed: () => openAppSettings())
        ]);
  }

  /// 检查权限
  static Future<bool> checkGranted(Permission permission) async {
    PermissionStatus storageStatus = await permission.status;
    if (storageStatus == PermissionStatus.granted) {
      //已授权
      return true;
    } else {
      //拒绝授权
      return false;
    }
  }
}

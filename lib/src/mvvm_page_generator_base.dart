import 'dart:io';

import 'package:mvvm_page_generator/src/FilesGenerator/files_generator.dart';

class MVVMPageGenerator {
  //declaring variables
  String? className, path;

  //class constructor
  MVVMPageGenerator({this.className, this.path = 'lib'});

  /// the functions which generates the files
  void generatePages() {
    //if name is vaild
    if (verifyClassName() && verifyPath()) {
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        FilesGenerator.makeFolder(
          className![0].toUpperCase() + className!.substring(1),
          workingDirectory: path!,
        ).then((value) {
          FilesGenerator.generateService(
            className!,
            workingDirectory: path! +
                "/" +
                className![0].toUpperCase() +
                className!.substring(1),
          );
          FilesGenerator.generateViewModel(
            className!,
            workingDirectory: path! +
                "/" +
                className![0].toUpperCase() +
                className!.substring(1),
          );
          FilesGenerator.generateView(
            className!,
            workingDirectory: path! +
                "/" +
                className![0].toUpperCase() +
                className!.substring(1),
          );
        });
      } else {
        throw 'Error not Supported Platform';
      }
    }
  }

  /// the function which validates the name
  bool verifyClassName() {
    if (className == null) {
      throw 'Error Class name should be specifed';
    } else if (className!.isEmpty) {
      throw 'Error Class name should not be empty';
    } else if (!RegExp(r'^[a-zA-Z0-9]{4,10}$').hasMatch(className!)) {
      throw 'Error Class name should not have symbols';
    } else {
      return true;
    }
  }

  /// the function which validates the path
  bool verifyPath() {
    if (path == null) {
      throw 'Error Path should be specifed';
    } else if (path!.isEmpty) {
      throw 'Error Path should not be empty';
    } else {
      return true;
    }
  }
}

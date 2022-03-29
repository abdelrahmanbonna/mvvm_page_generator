import 'dart:io';

import 'package:mvvm_page_generator/src/FilesGenerator/files_generator.dart';

class MVVMPageGenerator {
  //declaring variables
  String className, path;

  //class constructor
  MVVMPageGenerator({required this.className, this.path = 'lib'});

  /// the functions which generates the files
  void generatePages() {
    //if name is vaild
    if (verifyClassName()) {
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        //Make the main folder
        FilesGenerator.makeFolder(
          className[0].toUpperCase() + className.substring(1),
          workingDirectory: path.isEmpty ? 'lib' : path,
        ).then((res) {
          if (res) {
            //Generate service
            FilesGenerator.generateService(
              className,
              workingDirectory: path.isNotEmpty
                  ? '$path/${className[0].toUpperCase() + className.substring(1)}'
                  : 'lib/${className[0].toUpperCase() + className.substring(1)}',
            );
            //Generate ViewModel
            FilesGenerator.generateViewModel(
              className,
              workingDirectory: path.isNotEmpty
                  ? '$path/${className[0].toUpperCase() + className.substring(1)}'
                  : 'lib/${className[0].toUpperCase() + className.substring(1)}',
            );
            //Generate View
            FilesGenerator.generateView(
              className,
              workingDirectory: path.isNotEmpty
                  ? '$path/${className[0].toUpperCase() + className.substring(1)}'
                  : 'lib/${className[0].toUpperCase() + className.substring(1)}',
            );
          }
        });
      } else {
        throw 'Error not Supported Platform';
      }
    }
  }

  /// the function which validates the name
  bool verifyClassName() {
    if (className.isEmpty) {
      throw 'Error Class name should not be empty';
    } else if (!RegExp(r'^[a-zA-Z0-9]{2,50}$').hasMatch(className)) {
      throw 'Error Class name should not have symbols';
    } else {
      return true;
    }
  }
}

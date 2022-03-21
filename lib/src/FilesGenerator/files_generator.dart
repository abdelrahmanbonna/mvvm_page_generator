import 'dart:async';

import 'package:file/local.dart';
import 'package:shell/shell.dart';

abstract class FilesGenerator {
  static Future<bool> makeFolder(
    String name, {
    bool ignoreError = false,
    bool dontDrain = false,
    String workingDirectory = '/lib/',
  }) async {
    try {
      final _shell = Shell(workingDirectory: workingDirectory);
      var cdCmd = await _shell.start(
        'mkdir',
        arguments: [
          name,
        ],
      );

      if (!dontDrain) await cdCmd.stderr.drain();
      return true;
    } on Exception catch (_, e) {
      print('Error in file making');
      if (!ignoreError) print(e);
      return false;
    }
  }

  static Future<bool> goToFolder(
    String path, {
    bool ignoreError = false,
    bool dontDrain = false,
    String workingDirectory = '/lib/',
  }) async {
    try {
      final _shell = Shell(workingDirectory: workingDirectory);
      var cdCmd = await _shell.start(
        'cd',
        arguments: [
          path,
        ],
      );

      if (!dontDrain) await cdCmd.stderr.drain();
      return true;
    } on Exception catch (_, e) {
      print('Error file not found');
      if (!ignoreError) print(e);
      return false;
    }
  }

  static Future<bool> generateService(
    String className, {
    String workingDirectory = '/lib/',
  }) async {
    try {
      final _shell = Shell(workingDirectory: workingDirectory);
      final _fileSys = const LocalFileSystem();
      var echo = await _shell.start(
        'echo',
        arguments: [
          "class ${className[0].toUpperCase() + className.substring(1)}Service {}",
        ],
      );
      echo.stdout.writeToFile(
          _fileSys.file("$workingDirectory/${className}_service.dart"));
      await echo.stderr.drain();
      return true;
    } on Exception catch (_, e) {
      print(e);
      return false;
    }
  }

  static Future<bool> generateViewModel(
    String className, {
    String workingDirectory = '/lib/',
  }) async {
    try {
      final _shell = Shell(workingDirectory: workingDirectory);
      final _fileSys = const LocalFileSystem();

      var echo = await _shell.start(
        'echo',
        arguments: [
          "import 'package:pmvvm/view_model.dart';\nclass ${className[0].toUpperCase() + className.substring(1)}ViewModel extends ViewModel {}",
        ],
      );
      echo.stdout.writeToFile(
          _fileSys.file("$workingDirectory/${className}_viewmodel.dart"));
      await echo.stderr.drain();
      return true;
    } on Exception catch (_, e) {
      print(e);
      return false;
    }
  }

  static Future<bool> generateView(
    String className, {
    bool oldPmvvm = false,
    String workingDirectory = '/lib/',
  }) async {
    try {
      final _shell = Shell(workingDirectory: workingDirectory);
      final _fileSys = const LocalFileSystem();

      var echo = await _shell.start(
        'echo',
        arguments: [
          "import 'package:flutter/material.dart';\n"
              "import 'package:pmvvm/pmvvm.dart';\n"
              "import '${className}_viewmodel.dart';\n"
              "class ${className[0].toUpperCase() + className.substring(1)} extends StatelessWidget {"
              "\n const ${className[0].toUpperCase() + className.substring(1)}({Key? key}) : super(key: key);\n"
              "@override\n"
              "Widget build(BuildContext context) {\n"
              " return MVVM(view: (${!oldPmvvm ? "" : "context, viewModel"}) => ${className[0].toUpperCase() + className.substring(1)}View(),\n"
              "viewModel: ${className[0].toUpperCase() + className.substring(1)}ViewModel(),); \n"
              " } \n"
              "}\n"
              "class ${className[0].toUpperCase() + className.substring(1)}View extends HookView<${className[0].toUpperCase() + className.substring(1)}ViewModel> {\n"
              "${className[0].toUpperCase() + className.substring(1)}View({Key? key}) : super(key: key, reactive: true); \n"
              "@override \n"
              "Widget render(BuildContext context, ${className[0].toUpperCase() + className.substring(1)}ViewModel viewModel) { \n"
              " throw 'Error page not emplemented'; \n }\n"
              "}",
        ],
      );
      echo.stdout.writeToFile(
          _fileSys.file("$workingDirectory/${className}_view.dart"));
      await echo.stderr.drain();
      return true;
    } on Exception catch (_, e) {
      print(e);
      return false;
    }
  }
}

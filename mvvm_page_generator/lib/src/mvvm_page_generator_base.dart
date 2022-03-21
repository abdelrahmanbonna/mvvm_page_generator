import 'dart:io';

class MVVMPageGenerator {
  String? className, path;
  MVVMPageGenerator({this.className, this.path});
  void generatePages() {
    if (verifyClassName() && verifyPath()) {
      if (Platform.isLinux) {
        //make sh script work here
        
      } else if (Platform.isMacOS) {
        //make sh script work here
      } else if (Platform.isWindows) {
        //make ps1 script work here
      } else {
        throw 'Error not Supported Platform';
      }
    }
  }

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

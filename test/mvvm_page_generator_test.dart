import 'dart:io';
import 'package:mvvm_page_generator/mvvm_page_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Verifications group of tests', () {
    var obj = MVVMPageGenerator(className: 'home', path: '/HomePages/');

    test('Testing if verifyClassName function works fine', () {
      assert(obj.verifyClassName() == true);
    });

    test('Testing if verifyPath function works fine', () {
      assert(obj.verifyPath() == true);
    });
  });

  group('Generators group of tests', () {
    var obj = MVVMPageGenerator(className: 'home', path: 'lib');
    obj.generatePages();
    test('Testing if view is created', () async {
      assert(await File('lib/Home/home_view.dart').exists());
    });
    test('Testing if viewModel is created', () async {
      assert(await File('lib/Home/home_viewmodel.dart').exists());
    });
    test('Testing if service is created', () async {
      assert(await File('lib/Home/home_service.dart').exists());
    });
  });
}

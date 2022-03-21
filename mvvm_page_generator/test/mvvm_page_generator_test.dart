import 'package:mvvm_page_generator/mvvm_page_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Verifications group of tests', () {
    var obj = MVVMPageGenerator(className: 'home', path: '/HomePages/');

    test('Testing if verifyClassName function works fine', () {
      assert(obj.verifyClassName() == true);
    });
  });

  group('Generators group of tests', () {
    test('Testing if files generates', () {
      //TODO test generators here
      
    });
  });
}

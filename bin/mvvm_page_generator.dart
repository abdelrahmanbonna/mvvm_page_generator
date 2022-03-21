import 'package:args/args.dart';
import 'package:mvvm_page_generator/mvvm_page_generator.dart';

const className = 'className';
const path = 'path';
const help = 'help';

final argParser = ArgParser()
  ..addOption(
    className,
    abbr: 'c',
    help: 'Sets the name of the page.',
    mandatory: true,
  )
  ..addOption(
    path,
    abbr: 'p',
    help: 'Sets the page path.',
    mandatory: false,
  )
  ..addFlag(
    help,
    abbr: 'h',
    help: 'Shows help.',
    negatable: false,
  );

void main(List<String> arguments) async {
  try {
    final results = argParser.parse(arguments);
    if (results[help] || results.arguments.isEmpty) {
      print(argParser.usage);
      return;
    }

    var sourceGenerator = MVVMPageGenerator(
      className: results[className],
      path: results[path],
    );
    sourceGenerator.generatePages();
  } on FormatException catch (e) {
    print(e.message);
    print('---------------------------');
    print(argParser.usage);
  }
}

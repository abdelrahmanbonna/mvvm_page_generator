#!/bin/bash
foo=$1;
name="$(tr '[:lower:]' '[:upper:]' <<< ${foo:0:1})${foo:1}";

# making dir
echo "$name page is being generated....";
mkdir $name;
cd $1;
touch $1_view.dart;
touch $1_viewmodel.dart;
touch $1_service.dart;

# gen service
echo "$1_service.dart file is being generated....";
echo "class ${name}Service {}">>$1_service.dart;

# gen viewmodel
echo "$1_viewmodel.dart file is being generated....";
echo "import 'package:pmvvm/view_model.dart';\n">> $1_viewmodel.dart;
echo "class ${name}ViewModel extends ViewModel {}">> $1_viewmodel.dart;

# gen view
echo "$1_service.dart file is being generated....";
echo "import 'package:flutter/material.dart';\nimport 'package:pmvvm/pmvvm.dart';\nimport '$1_viewmodel.dart';\n" >> $1_view.dart;
echo "class $name extends StatelessWidget {" >> $1_view.dart;
echo "\n const $name({Key? key}) : super(key: key);\n" >> $1_view.dart;
echo "@override\n" >> $1_view.dart;
echo "Widget build(BuildContext context) {\n return MVVM(view: (context, viewModel) => ${name}View(),viewModel: ${name}ViewModel(),); \n } \n" >> $1_view.dart;
echo "}\n" >> $1_view.dart;
echo "class ${name}View extends HookView<${name}ViewModel> {\n" >> $1_view.dart;
echo "${name}View({Key? key}) : super(key: key, reactive: true); \n" >> $1_view.dart;
echo "@override \n" >> $1_view.dart;
echo "Widget render(BuildContext context, ${name}ViewModel viewModel) { \n throw 'Error page not emplemented'; \n }\n" >> $1_view.dart;
echo "}" >> $1_view.dart;

import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class OperatorGenerator extends GeneratorForAnnotation<OperationAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classBuffer = StringBuffer();
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    classBuffer.writeln('class ${element.name}Impl extends ${element.name} {');

    final bool addition = annotation.read('addition').boolValue;
    final bool subraction = annotation.read('subraction').boolValue;
    final bool multiplication = annotation.read('multiplication').boolValue;
    final bool divison = annotation.read('divison').boolValue;

    if (addition == true)
      classBuffer.writeln('int  add (int a ,int b) => a + b   ;');
    if (subraction == true)
      classBuffer.writeln('int  sub (int a ,int b) => a - b   ;');
    if (multiplication == true)
      classBuffer.writeln('int  mul (int a ,int b) => a * b   ;');
    if (divison == true)
      classBuffer.writeln('int  div (int a ,int b) => a / b   ;');

    classBuffer.writeln('}');

    return classBuffer.toString();
  }
}

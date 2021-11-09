// import 'package:analyzer/dart/element/element.dart';
// import 'package:annotations/annotations.dart';
// import 'package:build/src/builder/build_step.dart';
// import 'package:source_gen/source_gen.dart';
//
// import 'model_visitor.dart';
//
// class DefaultGenerator extends GeneratorForAnnotation<DefaultValue> {
//   @override
//   String generateForAnnotatedElement(
//       Element element, ConstantReader annotation, BuildStep buildStep) {
//     final classBuffer = StringBuffer();
//     final visitor = ModelVisitor();
//     element.visitChildren(visitor);
//     classBuffer.writeln('class ${element.name}Impl extends ${element.name} {');
//     final int value = annotation.read('a').intValue;
//     classBuffer.writeln('@override');
//     classBuffer.writeln('int get a=> $value;');
//     classBuffer.writeln('}');
//     return classBuffer.toString();
//   }
// }

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  // 2
  String className;
  final fields = <String, dynamic>{};
  final metaData = <String, dynamic>{};

  // 3
  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    // 4
    className = elementReturnType.replaceFirst('*', '');
  }

  // 5
  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();
    // 7
    fields[element.name] = elementType.replaceFirst('*', '');
    metaData[element.name] = element.metadata;
  }
}

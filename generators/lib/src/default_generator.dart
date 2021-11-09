import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class DefaultGenerator extends GeneratorForAnnotation<DefaultClass> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classBuffer = StringBuffer();
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    classBuffer
        .writeln('class ${element.name}OpImpl extends ${element.name} {');
    _generateSetters(element as ClassElement, annotation, classBuffer);
    classBuffer.writeln('}');
    return classBuffer.toString();
  }

  String _generateSetters(ClassElement element, ConstantReader annotation,
      StringBuffer classBuffer) {
    for (final f in element.accessors) {
      if (f.metadata.isEmpty) {
        return null;
      }
      final annotate = f.DefaultValueAnnotation;
      if (f.isGetter) {
        final value =
            annotate.computeConstantValue().getField('value').toIntValue();

        classBuffer.writeln('@override');
        classBuffer.writeln("${f.type.returnType} get ${f.name} => $value;");
      }
    }
  }
}

extension _ElementAnnotationUtils on ElementAnnotation {
  bool get isDefaultValue {
    var displayString =
        computeConstantValue().type.getDisplayString(withNullability: false);
    return isConstantEvaluated && displayString == '$DefaultValue';
  }
}

extension _PropertyAccessorElementUtils on PropertyAccessorElement {
  ElementAnnotation get DefaultValueAnnotation => metadata.firstWhere(
        (e) => e.isDefaultValue,
        orElse: () => null,
      );
}

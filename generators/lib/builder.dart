import 'package:build/build.dart';
import 'package:generators/src/operators_generators.dart';
import 'package:source_gen/source_gen.dart';

Builder generateOperation(BuilderOptions options) =>
    SharedPartBuilder([OperatorGenerator()], 'operators_generator');

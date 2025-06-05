import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static const String apiKey = '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';
}
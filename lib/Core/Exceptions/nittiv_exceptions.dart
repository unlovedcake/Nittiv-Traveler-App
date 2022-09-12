// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class NittivException implements Exception {}

class NittivAuthException implements NittivException {
  final String? message;
  const NittivAuthException({
    this.message,
  });
}

class NittivCommonException implements NittivException {
  final String? message;
  const NittivCommonException({
    this.message,
  });
}

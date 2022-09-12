// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class NittivFailure {
  const NittivFailure();
}

class NittivAuthFailure extends NittivFailure {
  final String message;
  const NittivAuthFailure({
    required this.message,
  });
}

class OTPSendingFailure extends NittivFailure {
  final String message;
  const OTPSendingFailure({
    required this.message,
  });
}


class PostFailure extends NittivFailure {
  final String message; 
  const PostFailure({
    required this.message,
  });
}

class NittivCommonFailure extends NittivFailure {
  final String message;
  NittivCommonFailure({
    required this.message,
  });
}

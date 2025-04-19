sealed class NotionErrorException implements Exception {
  static const String object = 'error';
  final int status;
  final String code;
  final String message;

  const NotionErrorException({
    required this.status,
    required this.code,
    required this.message,
  });

  /// JSONレスポンスがエラーオブジェクトかどうかを判定
  static bool isErrorResponse(Map<String, dynamic> json) {
    return json['object'] == object;
  }

  factory NotionErrorException.fromJson(Map<String, dynamic> json) {
    if (!isErrorResponse(json)) {
      throw const FormatException('Invalid error response');
    }

    final status = json['status'] as int;
    final code = json['code'] as String;
    final message = json['message'] as String;

    return switch (status) {
      400 => NotionValidationException(code: code, message: message),
      404 => NotionInvalidException(code: code, message: message),
      _ => NotionUnknownException(
          status: status,
          code: code,
          message: message,
        ),
    };
  }
}

/// tokenが無効になった場合など
class NotionInvalidException extends NotionErrorException {
  const NotionInvalidException({required String code, required String message})
      : super(status: 404, code: code, message: message);
}

/// プロパティ名が変更になっている場合など
class NotionValidationException extends NotionErrorException {
  const NotionValidationException(
      {required String code, required String message})
      : super(status: 400, code: code, message: message);
}

/// 想定外のエラー
class NotionUnknownException extends NotionErrorException {
  const NotionUnknownException({
    required int status,
    required String code,
    required String message,
  }) : super(status: status, code: code, message: message);
}

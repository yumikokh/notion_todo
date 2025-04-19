import 'package:flutter_test/flutter_test.dart';
import 'package:tanzaku_todo/src/common/error.dart';

void main() {
  group('NotionErrorException', () {
    test('isErrorResponseはエラーオブジェクトを正しく判定できる', () {
      final errorJson = {
        'object': 'error',
        'status': 400,
        'code': 'validation_error',
        'message': 'Validation error',
      };

      final nonErrorJson = {
        'object': 'page',
        'id': 'page-id',
      };

      expect(NotionErrorException.isErrorResponse(errorJson), true);
      expect(NotionErrorException.isErrorResponse(nonErrorJson), false);
    });

    test('fromJsonでNotionValidationExceptionが正しく生成される', () {
      final errorJson = {
        'object': 'error',
        'status': 400,
        'code': 'validation_error',
        'message': 'Validation error',
      };

      final exception = NotionErrorException.fromJson(errorJson);

      expect(exception, isA<NotionValidationException>());
      expect(exception.status, 400);
      expect(exception.code, 'validation_error');
      expect(exception.message, 'Validation error');
    });

    test('fromJsonでNotionInvalidExceptionが正しく生成される', () {
      final errorJson = {
        'object': 'error',
        'status': 404,
        'code': 'object_not_found',
        'message': 'Object not found',
      };

      final exception = NotionErrorException.fromJson(errorJson);

      expect(exception, isA<NotionInvalidException>());
      expect(exception.status, 404);
      expect(exception.code, 'object_not_found');
      expect(exception.message, 'Object not found');
    });

    test('fromJsonでNotionUnknownExceptionが正しく生成される', () {
      final errorJson = {
        'object': 'error',
        'status': 500,
        'code': 'internal_server_error',
        'message': 'Internal server error',
      };

      final exception = NotionErrorException.fromJson(errorJson);

      expect(exception, isA<NotionUnknownException>());
      expect(exception.status, 500);
      expect(exception.code, 'internal_server_error');
      expect(exception.message, 'Internal server error');
    });

    test('エラーでないJSONを渡すとFormatExceptionがスローされる', () {
      final nonErrorJson = {
        'object': 'page',
        'id': 'page-id',
      };

      expect(() => NotionErrorException.fromJson(nonErrorJson),
          throwsA(isA<FormatException>()));
    });
  });
}

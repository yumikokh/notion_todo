import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tanzaku_todo/src/helpers/date.dart';

void main() {
  late DateHelper dateHelper;

  setUpAll(() async {
    await initializeDateFormatting();
  });

  setUp(() {
    dateHelper = DateHelper();
  });

  group('DateHelper - formatDateForTitle', () {
    test('日本語フォーマット', () {
      final date = DateTime(2024, 1, 1);
      final result = dateHelper.formatDateForTitle(date, locale: 'ja');
      expect(result, '1月1日 (月)');
    });

    test('英語フォーマット', () {
      final date = DateTime(2024, 1, 1);
      final result = dateHelper.formatDateForTitle(date, locale: 'en');
      expect(result, 'Mon, Jan 1');
    });

    test('韓国語フォーマット', () {
      dateHelper.setup('ko');
      final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
      expect(result, '3월15일 (금)');
    });

    test('中国語フォーマット', () {
      dateHelper.setup('zh');
      final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
      expect(result, '3月15日 周五');
    });

    test('スペイン語フォーマット', () {
      dateHelper.setup('es');
      final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
      expect(result, 'vie. 15 mar.');
    });

    test('フランス語フォーマット', () {
      dateHelper.setup('fr');
      final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
      expect(result, 'ven. 15 mars');
    });

    test('ドイツ語フォーマット', () {
      dateHelper.setup('de');
      final result = dateHelper.formatDateForTitle(DateTime(2024, 3, 15));
      expect(result, 'Fr., 15. März');
    });
  });
}
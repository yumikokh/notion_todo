import 'package:freezed_annotation/freezed_annotation.dart';
import 'property.dart';

part 'database_page.freezed.dart';

@freezed
abstract class DatabasePage with _$DatabasePage {
  const factory DatabasePage({
    required String id,
    required String title,
    required String url,
    required List<Property> properties,
  }) = _DatabasePage;
}

import 'package:freezed_annotation/freezed_annotation.dart';

import 'property.dart';

part 'database.freezed.dart';

@freezed
abstract class Database with _$Database {
  const factory Database({
    required String id,
    required String name,
    String? icon,
    required String url,
    required List<Property> properties,
  }) = _Database;
}

import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor openConnection(String name) {
  return WebDatabase(name);
}

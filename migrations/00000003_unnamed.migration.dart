import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration3 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_MobileTrajet", [SchemaColumn("id_trajetMobile", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("depart", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("fin", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("distance", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("date", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("vehicule", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("type", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
    database.addColumn("_MobileTrajet", SchemaColumn.relationship("operateur", ManagedPropertyType.bigInteger, relatedTableName: "_Operateur", relatedColumnName: "id_op", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}

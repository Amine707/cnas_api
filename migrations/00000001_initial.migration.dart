import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
     database.createTable(SchemaTable("_Operateur", [
  SchemaColumn("id_op", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
  SchemaColumn("nom", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
  SchemaColumn("prenom", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
  SchemaColumn("tel", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
  SchemaColumn("email", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
  SchemaColumn("date_naissance", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
  ],
  ));


  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final List<Map> reads = [
      {
        'nom': 'hakim',
        'prenom': 'Eric',
        'tel': '09088',
        'email': 'h@g.com',
        'date_naissance': '06/2004'
      },
      {
        'nom': 'massi',
        'prenom': 'Eric',
        'tel': '09088',
        'email': 'h@g.com',
        'date_naissance': '06/2004'
      },
      {
        'nom': 'mobi',
        'prenom': 'Eric',
        'tel': '09088',
        'email': 'h@g.com',
        'date_naissance': '06/2004'
      }
    ];

    for (final read in reads) {
      await database.store.execute(
          'INSERT INTO _Read (nom, prenom, tel, email, date_naissance) VALUES (@nom, @prenom, @tel, @email, @date_naissance)',
          substitutionValues: {
            'nom': read['nom'],
            'prenom': read['prenom'],
            'tel': read['tel'],
            'email': read['email'],
            'date_naissance': read['date_naissance'],
          });
    }
  }
}

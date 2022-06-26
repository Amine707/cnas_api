import 'package:cnas_api/cnas_api.dart';

import 'Client_model.dart';

enum Type_vehicule {
  leger,
  lourd
}

class Operateur extends ManagedObject<_Operateur> implements _Operateur {
  String get detail => '$nom  $prenom';
}

class _Operateur {
  @primaryKey
  int id_op;

  @Column()
  String nom;

  @ Column()
  String prenom;

  @ Column()
  String tel;

  @ Column()
  String email;

  @ Column()
  String adresse;

  @ Column()
  DateTime date_naissance;

  @ Column()
  String liste_vehicules;

  ManagedSet<Client> clients;
}

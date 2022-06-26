import 'package:cnas_api/cnas_api.dart';

import 'Client_model.dart';

class Reclamation extends ManagedObject<_Reclamation> implements _Reclamation {
  String get detail => '$date  $sujet';
}

class _Reclamation {
  @primaryKey
  int id_reclamation;

  @Column()
  DateTime date;

  @ Column()
  String sujet;

  @ Column()
  String contenu_reclamation;

  @Relate(#reclamations)
  Client client;
}

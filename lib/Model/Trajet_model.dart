import 'package:cnas_api/cnas_api.dart';

import 'Operateur_model.dart';
import 'Client_model.dart';
import 'Remboursement_model.dart';

enum Type_trajet {
  urgence,
  organise
}

class Trajet extends ManagedObject<_Trajet> implements _Trajet {
  String get detail => '$depart  $fin';
}

class _Trajet {
  @primaryKey
  int id_trajet;

  @Column()
  String depart;

  @ Column()
  String fin;

  @ Column()
  String distance;

  @ Column()
  DateTime date;

  @ Column()
  Type_vehicule vehicule;

  @ Column()
  Type_trajet type;

  @Relate(#trajets)
  Client client;

  Remboursement remboursement;
}

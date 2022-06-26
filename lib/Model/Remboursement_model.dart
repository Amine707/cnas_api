import 'package:cnas_api/cnas_api.dart';

import 'Trajet_model.dart';

enum Etat {
  en_cours,
  accepte,
  refuse
}

class Remboursement extends ManagedObject<_Remboursement> implements _Remboursement {
  String get detail => '$trajet  $date_depot';
}

class _Remboursement {
  @primaryKey
  int id_remboursement;

  @ Column()
  DateTime date_depot;

  @ Column()
  Etat etat;

  @ Column()
  String facture;

  @Relate(#remboursement)
  Trajet trajet;

}

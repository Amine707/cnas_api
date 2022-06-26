import 'package:cnas_api/cnas_api.dart';

import 'Operateur_model.dart';
import 'Reclamation_model.dart';
import 'Trajet_model.dart';

class Client extends ManagedObject<_Client> implements _Client {
  String get detail => '$nom  $prenom';
}

class _Client {
  @primaryKey
  int id_client;

  @Column()
  String nom;

  @ Column()
  String prenom;

  @ Column()
  String tel;

  @ Column()
  DateTime date_naissance;

  @ Column()
  String adresse;

  @Relate(#clients)
  Operateur operateur;

  ManagedSet<Reclamation> reclamations;

  ManagedSet<Trajet> trajets;

}

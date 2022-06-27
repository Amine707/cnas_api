import 'package:cnas_api/cnas_api.dart';

import 'Operateur_model.dart';
import 'Trajet_model.dart';


class MobileTrajet extends ManagedObject<_MobileTrajet> implements _MobileTrajet {
  String get detail => '$depart  $fin';
}

class _MobileTrajet {
  @primaryKey
  int id_trajetMobile;

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

  @Relate(#trajetsMobiles)
  Operateur operateur;
}

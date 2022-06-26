import 'package:cnas_api/cnas_api.dart';

class Administrateur extends ManagedObject<_Administrateur> implements _Administrateur {
  String get detail => '$user_name  $password';
}

class _Administrateur {
  @primaryKey
  int id_admin;

  @Column()
  String user_name;

  @ Column()
  String password;

  @ Column()
  String tel;

  @ Column()
  String email;

}


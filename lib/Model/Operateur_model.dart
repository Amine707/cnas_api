import 'package:cnas_api/cnas_api.dart';

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
  String date_naissance;
}

/// For reference
// class Read extends Serializable {
//   String title;
//   String author;
//   int year;

//   @override
//   Map<String, dynamic> asMap() => {
//         'title': title,
//         'author': author,
//         'year': year,
//       };

//   @override
//   void readFromMap(Map<String, dynamic> requestBody) {
//     title = requestBody['title'] as String;
//     author = requestBody['author'] as String;
//     year = requestBody['year'] as int;
//   }
// }

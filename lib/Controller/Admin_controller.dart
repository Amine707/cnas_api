import 'package:cnas_api/Model/Administrateur_model.dart';
import 'package:cnas_api/cnas_api.dart';

class AdministrateurController extends ResourceController {

  AdministrateurController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllAdministrateur() async {
    final adminQuery = Query<Administrateur>(context);
    return Response.ok(await adminQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getAdministrateur(@Bind.path('id') int id) async {
    final adminQuery = Query<Administrateur>(context)
      ..where((Administrateur) => Administrateur.id_admin).equalTo(id);
    final admin = await adminQuery.fetchOne();

    if (admin == null) {
      return Response.notFound(body: 'Administrateur non trouvé.');
    }
    return Response.ok(admin);
  }

  @Operation.post()
  Future<Response> createNewAdministrateur(@Bind.body() Administrateur body) async {
    final adminQuery = Query<Administrateur>(context)..values = body;
    print('AdminQuery created : $body');
    try {
      final insertedAdmin = await adminQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("Administrateur inséré");
  }

  @Operation.put('id')
  Future<Response> updatedAdministrateur(@Bind.path('id') int id,@Bind.body() Administrateur body) async {
    final adminQuery = Query<Administrateur>(context)
      ..values = body
      ..where((Administrateur) => Administrateur.id_admin).equalTo(id);

    try {
      final updatedQuery = await adminQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'Administrateur non trouvé.');
      }

      return Response.ok("Administrateur modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedAdministrateur(@Bind.path('id') int id) async {
    final adminQuery = Query<Administrateur>(context)
      ..where((read) => read.id_admin).equalTo(id);

    final int deleteCount = await adminQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Administrateur non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount Administrateur Supprimés.');
  }
}

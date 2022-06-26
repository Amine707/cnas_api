import 'package:cnas_api/Model/Reclamation_model.dart';
import 'package:cnas_api/cnas_api.dart';

class ReclamationController extends ResourceController {

  ReclamationController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllReclamation() async {
    final recQuery = Query<Reclamation>(context);
    return Response.ok(await recQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getReclamation(@Bind.path('id') int id) async {
    final recQuery = Query<Reclamation>(context)
      ..where((Reclamation) => Reclamation.id_reclamation).equalTo(id);
    final rec = await recQuery.fetchOne();

    if (rec == null) {
      return Response.notFound(body: 'Reclamation non trouvé.');
    }
    return Response.ok(rec);
  }

  @Operation.post()
  Future<Response> createNewReclamation(@Bind.body() Reclamation body) async {
    final recQuery = Query<Reclamation>(context)..values = body;
    print('recQuery created : $body');
    try {
      final insertedrec = await recQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("Reclamation inséré");
  }

  @Operation.put('id')
  Future<Response> updatedReclamation(@Bind.path('id') int id,@Bind.body() Reclamation body) async {
    final recQuery = Query<Reclamation>(context)
      ..values = body
      ..where((Reclamation) => Reclamation.id_reclamation).equalTo(id);

    try {
      final updatedQuery = await recQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'Reclamation non trouvé.');
      }

      return Response.ok("Reclamation modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedReclamation(@Bind.path('id') int id) async {
    final recQuery = Query<Reclamation>(context)
      ..where((read) => read.id_reclamation).equalTo(id);

    final int deleteCount = await recQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Reclamation non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount Reclamation Supprimés.');
  }
}

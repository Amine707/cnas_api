import 'package:cnas_api/Model/Trajet_model.dart';
import 'package:cnas_api/cnas_api.dart';

class TrajetController extends ResourceController {

  TrajetController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllTrajet() async {
    final trajetQuery = Query<Trajet>(context);
    return Response.ok(await trajetQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getTrajet(@Bind.path('id') int id) async {
    final trajetQuery = Query<Trajet>(context)
      ..where((Trajet) => Trajet.id_trajet).equalTo(id);
    final trajet = await trajetQuery.fetchOne();

    if (trajet == null) {
      return Response.notFound(body: 'Trajet non trouvé.');
    }
    return Response.ok(trajet);
  }

  @Operation.post()
  Future<Response> createNewTrajet(@Bind.body() Trajet body) async {
    final trajetQuery = Query<Trajet>(context)..values = body;
    print('AdminQuery created : $body');
    try {
      final insertedAdmin = await trajetQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("Trajet inséré");
  }

  @Operation.put('id')
  Future<Response> updatedTrajet(@Bind.path('id') int id,@Bind.body() Trajet body) async {
    final trajetQuery = Query<Trajet>(context)
      ..values = body
      ..where((Trajet) => Trajet.id_trajet).equalTo(id);

    try {
      final updatedQuery = await trajetQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'Trajet non trouvé.');
      }

      return Response.ok("Trajet modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedTrajet(@Bind.path('id') int id) async {
    final trajetQuery = Query<Trajet>(context)
      ..where((read) => read.id_trajet).equalTo(id);

    final int deleteCount = await trajetQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Trajet non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount Trajet Supprimés.');
  }
}

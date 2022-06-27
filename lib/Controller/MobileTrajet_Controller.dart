import 'package:cnas_api/Model/MobileTrajet_model.dart';
import 'package:cnas_api/cnas_api.dart';

class MobileTrajetController extends ResourceController {

  MobileTrajetController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllMobileTrajet() async {
    final trajetQuery = Query<MobileTrajet>(context);
    return Response.ok(await trajetQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getMobileTrajet(@Bind.path('id') int id) async {
    final trajetQuery = Query<MobileTrajet>(context)
      ..where((MobileTrajet) => MobileTrajet.id_trajetMobile).equalTo(id);
    final trajet = await trajetQuery.fetchOne();

    if (trajet == null) {
      return Response.notFound(body: 'MobileTrajet non trouvé.');
    }
    return Response.ok(trajet);
  }

  @Operation.post()
  Future<Response> createNewMobileTrajet(@Bind.body() MobileTrajet body) async {
    final trajetQuery = Query<MobileTrajet>(context)..values = body;
    print('AdminQuery created : $body');
    try {
      final insertedAdmin = await trajetQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("MobileTrajet inséré");
  }

  @Operation.put('id')
  Future<Response> updatedMobileTrajet(@Bind.path('id') int id,@Bind.body() MobileTrajet body) async {
    final trajetQuery = Query<MobileTrajet>(context)
      ..values = body
      ..where((MobileTrajet) => MobileTrajet.id_trajetMobile).equalTo(id);

    try {
      final updatedQuery = await trajetQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'MobileTrajet non trouvé.');
      }

      return Response.ok("MobileTrajet modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedMobileTrajet(@Bind.path('id') int id) async {
    final trajetQuery = Query<MobileTrajet>(context)
      ..where((read) => read.id_trajetMobile).equalTo(id);

    final int deleteCount = await trajetQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'MobileTrajet non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount MobileTrajet Supprimés.');
  }
}

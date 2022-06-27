import 'package:cnas_api/Model/Remboursement_model.dart';
import 'package:cnas_api/cnas_api.dart';

class RemboursementController extends ResourceController {

  RemboursementController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllRemboursement() async {
    final remQuery = Query<Remboursement>(context);
    return Response.ok(await remQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getRemboursement(@Bind.path('id') int id) async {
    final remQuery = Query<Remboursement>(context)
      ..where((Remboursement) => Remboursement.id_remboursement).equalTo(id);
    final rem = await remQuery.fetchOne();

    if (rem == null) {
      return Response.notFound(body: 'Remboursement non trouvé.');
    }
    return Response.ok(rem);
  }

  @Operation.get('etat')
  Future<Response> getRemboursementEtat(@Bind.path('etat') String etat) async {
    var rem;
    if(etat==Etat.accepte.toString()){
      final remQuery = Query<Remboursement>(context)
        ..where((Remboursement) => Remboursement.etat).equalTo(Etat.accepte);
      rem = await remQuery.fetch();
    }else{
      final remQuery = Query<Remboursement>(context)
        ..where((Remboursement) => Remboursement.etat).equalTo(Etat.refuse);
      rem = await remQuery.fetch();
    }
    if (rem == null) {
      return Response.notFound(body: 'Remboursement non trouvé.');
    }
    return Response.ok(rem.length);
  }

  @Operation.post()
  Future<Response> createNewRemboursement(@Bind.body() Remboursement body) async {
    final remQuery = Query<Remboursement>(context)..values = body;
    print('remQuery created : $body');
    try {
      final insertedrem = await remQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("Remboursement inséré");
  }

  @Operation.put('id')
  Future<Response> updatedRemboursement(@Bind.path('id') int id,@Bind.body() Remboursement body) async {
    final remQuery = Query<Remboursement>(context)
      ..values = body
      ..where((Remboursement) => Remboursement.id_remboursement).equalTo(id);

    try {
      final updatedQuery = await remQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'Remboursement non trouvé.');
      }

      return Response.ok("Remboursement modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedRemboursement(@Bind.path('id') int id) async {
    final remQuery = Query<Remboursement>(context)
      ..where((Remboursement) => Remboursement.id_remboursement).equalTo(id);

    final int deleteCount = await remQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Remboursement non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount Remboursement Supprimés.');
  }
}

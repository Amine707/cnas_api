import 'package:cnas_api/Model/Operateur_model.dart';
import 'package:cnas_api/cnas_api.dart';

class OperateurController extends ResourceController {

  OperateurController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllOperateur() async {
    final readQuery = Query<Operateur>(context);
    return Response.ok(await readQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getOperateur(@Bind.path('id') int id) async {
    final opQuery = Query<Operateur>(context)
      ..where((operateur) => operateur.id_op).equalTo(id);
    final op = await opQuery.fetchOne();

    if (op == null) {
      return Response.notFound(body: 'Operateur non trouvé.');
    }
    return Response.ok(op);
  }

  @Operation.post()
  Future<Response> createNewOperateur(@Bind.body() Operateur body) async {
    final opQuery = Query<Operateur>(context)..values = body;
    print('opQuery created : $body');
    try {
      final insertedOp = await opQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("opperateur inséré");
  }

  @Operation.put('id')
  Future<Response> updatedOperateur(@Bind.path('id') int id,@Bind.body() Operateur body) async {
    final opQuery = Query<Operateur>(context)
      ..values = body
      ..where((operateur) => operateur.id_op).equalTo(id);

    try {
      final updatedQuery = await opQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'Operateur non trouvé.');
      }

      return Response.ok("opérateur modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedOperateur(@Bind.path('id') int id) async {
    final opQuery = Query<Operateur>(context)
      ..where((read) => read.id_op).equalTo(id);

    final int deleteCount = await opQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Operateur non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount Operateur Supprimés.');
  }
}

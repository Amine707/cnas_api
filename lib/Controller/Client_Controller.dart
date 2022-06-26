import 'package:cnas_api/Model/Client_model.dart';
import 'package:cnas_api/cnas_api.dart';

class ClientController extends ResourceController {

  ClientController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllClient() async {
    final clientQuery = Query<Client>(context);
    return Response.ok(await clientQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getClient(@Bind.path('id') int id) async {
    final clientQuery = Query<Client>(context)
      ..where((Client) => Client.id_client).equalTo(id);
    final client = await clientQuery.fetchOne();

    if (client == null) {
      return Response.notFound(body: 'Client non trouvé.');
    }
    return Response.ok(client);
  }

  @Operation.post()
  Future<Response> createNewClient(@Bind.body() Client body) async {
    final clientQuery = Query<Client>(context)..values = body;
    print('clientQuery created : $body');
    try {
      final insertedclient = await clientQuery.insert();
    } catch(e) {
      print(e);
    }

    return Response.ok("Client inséré");
  }

  @Operation.put('id')
  Future<Response> updatedClient(@Bind.path('id') int id,@Bind.body() Client body) async {
    final clientQuery = Query<Client>(context)
      ..values = body
      ..where((Client) => Client.id_client).equalTo(id);

    try {
      final updatedQuery = await clientQuery.updateOne().catchError((e) {
        print("Request error: $e");
      });

      if (updatedQuery == null) {
        return Response.notFound(body: 'Client non trouvé.');
      }

      return Response.ok("Client modifié");
    } catch(e) {
      print(e);
    }

  }

  @Operation.delete('id')
  Future<Response> deletedClient(@Bind.path('id') int id) async {
    final clientQuery = Query<Client>(context)
      ..where((read) => read.id_client).equalTo(id);

    final int deleteCount = await clientQuery.delete();

    if (deleteCount == 0) {
      return Response.notFound(body: 'Client non trouvé.');
    }
    return Response.ok('Deleted : $deleteCount Clients Supprimés.');
  }
}

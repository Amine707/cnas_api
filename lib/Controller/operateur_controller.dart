import 'package:cnas_api/cnas_api.dart';

List op = [
  {
    'title': 'Head First Design Patterns',
    'author': 'Eric Freeman',
    'year': 2004
  },
  {
    'title': 'Clean Code: A handbook of Agile Software Craftsmanship',
    'author': 'Robert C. Martin',
    'year': 2008
  },
  {
    'title': 'Code Complete: A Practical Handbook of Software Construction',
    'author': 'Steve McConnell',
    'year': 2004
  },
];

class OperateurController extends ResourceController {
  @Operation.get()
  Future<Response> getAllOperateur() async {
    return Response.ok(op);
  }

  @Operation.get('id')
  Future<Response> getOperateur(@Bind.path('id') int id) async {
    if (id < 0 || id > op.length - 1) {
      return Response.notFound(body: 'Operateur not found.');
    }
    return Response.ok(op[id]);
  }

  @Operation.post()
  Future<Response> createNewOperateur() async {
    final Map<String, dynamic> body = request.body.as();
    op.add(body);
    return Response.ok(body);
  }

  @Operation.put('id')
  Future<Response> updatedOperateur(@Bind.path('id') int id) async {
    if (id < 0 || id > op.length - 1) {
      return Response.notFound(body: 'Operateur not found.');
    }

    final Map<String, dynamic> body = request.body.as();
    op[id] = body;

    return Response.ok('Updated read.');
  }

  @Operation.delete('id')
  Future<Response> deletedOperateur(@Bind.path('id') int id) async {
    if (id < 0 || id > op.length - 1) {
      return Response.notFound(body: 'Item not found.');
    }
    op.removeAt(id);
    return Response.ok('Deleted operateur.');
  }
}

import 'Controller/operateur_controller.dart';
import 'cnas_api.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class CnasApiChannel extends ApplicationChannel {

  ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      'gpcvngsjgkjqly',
      '32dc82e05fb0f265979a63bd583d791be27b71b40a227a570dde7e1f36c726a2',
      'ec2-35-169-173-9.compute-1.amazonaws.com',
      5432,
      'dckgqgkuc4aipi',
       useSSL : true
    );

    context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router()

    ..route("/operateur/[:id]").link(() => OperateurController(context))

    //
    ..route('/').linkFunction((request) =>
    Response.ok('Hello, World!')..contentType = ContentType.html)

    //
    ..route('/client').linkFunction((request) async {
      final client = await File('client.html').readAsString();
      return Response.ok(client)..contentType = ContentType.html;
    });

    return router;
  }
}

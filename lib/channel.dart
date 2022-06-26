import 'package:cnas_api/Controller/Admin_controller.dart';
import 'package:cnas_api/Controller/Client_Controller.dart';
import 'package:cnas_api/Controller/Reclamation_Controller.dart';
import 'package:cnas_api/Controller/Remboursement_Controller.dart';
import 'package:cnas_api/Controller/Trajet_Controller.dart';

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
      'hsvpmbkb',
      'KMXRUFh7UOt2-RR1BS3nEuDM3S4xJYJ_',
      'tyke.db.elephantsql.com',
      5432,
      'hsvpmbkb'
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

    //controllers list
    ..route("/operateur/[:id]").link(() => OperateurController(context))
    ..route("/admin/[:id]").link(() => AdministrateurController(context))
    ..route("/client/[:id]").link(() => ClientController(context))
    ..route("/reclamation/[:id]").link(() => ReclamationController(context))
    ..route("/remboursement/[:id]").link(() => RemboursementController(context))
    ..route("/trajet/[:id]").link(() => TrajetController(context))

    //
    ..route('/').linkFunction((request) =>
    Response.ok('Hello, World!')..contentType = ContentType.html)

    //
    ..route('/client_doc').linkFunction((request) async {
      final client = await File('client.html').readAsString();
      return Response.ok(client)..contentType = ContentType.html;
    });

    return router;
  }
}

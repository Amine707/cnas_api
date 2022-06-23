import 'dart:io';
import 'dart:convert';

import 'package:ansicolor/ansicolor.dart';

AnsiPen green = new AnsiPen()..green(bold: true);
AnsiPen blue = new AnsiPen()..blue();
AnsiPen red = new AnsiPen()..red();

main(List<String> arguments) {
  int count = 0;
  bool debug = arguments.contains('--debug');
  String filename;
  Process lastProcess;
  filename = arguments.isNotEmpty ? arguments[0] : './main.dart';

  File file = new File(filename);

  if (!file.existsSync()) {
    print(red('File ${filename} not found.'));
    exit(1);
  }

  Directory parent = file.parent;

  startProcess() {
    if (lastProcess != null) {
      lastProcess.kill(ProcessSignal.sigkill);
    }

    Process.start('dart', [filename]).then((Process process) async {
      lastProcess = process;

      process.stdout.transform(utf8.decoder).listen((data) {
        print(data);
      });

      process.stderr.transform(utf8.decoder).listen((data) {
        print(data);
      });
    });
  }

  startProcess();

  parent
      .list(recursive: true, followLinks: false)
      .listen((FileSystemEntity entity) async {
    File test = File.fromUri(entity.uri);
    if (test.statSync().type == FileSystemEntityType.directory) return;

    count++;
    debug ? print(blue('[${count}] Watching on ${entity.path}...')) : null;
    Stream<FileSystemEvent> stream = entity.watch();
    await for (var event in stream) {
      print(green(
          '[${DateTime.now()}] >>> Found changes in ${event.path}. Reloading...'));
      startProcess();
    }
  });
}

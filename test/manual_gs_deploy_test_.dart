@TestOn("vm")
library tekartik_deploy.test.bin_dirdeploy_test;

import 'package:path/path.dart';
import 'package:process_run/cmd_run.dart';
import 'package:dev_test/test.dart';
import 'package:tekartik_deploy/gs_deploy.dart';
import 'package:fs_shim_test/test_io.dart';
import 'io_test_common.dart';

//String get _pubPackageRoot => getPubPackageRootSync(testDirPath);

class TestScript extends Script {}

String get testScriptPath => getScriptPath(TestScript);
String top = join(dirname(testScriptPath), 'out');
FileSystemTestContext ctx = newIoFileSystemContext(top);
FileSystem fs = ctx.fs;
main() {
  //defineTests(ctx);
  //useVMConfiguration();
  group('gsdeploy', () {
    test('deploy_1_file', () async {
      Directory top = await ctx.prepare();
      //Directory
      Directory dir = new Directory(join(top.path, 'dir'));
      File file = new File(join(dir.path, "file"));
      await file.create(recursive: true);
      await file.writeAsString("test", flush: true);

      String gsDst =
          "gs://gstest.tekartik.com/dev/tekartik_deploy/test/deploy_1_file";
      ProcessCmd cmd = gsDeployCmd(dir.path, gsDst);
      await runCmd(cmd
        ..connectStdout = true
        ..connectStdin = true
        ..connectStderr = true);
    });

    /*
    test('deploy_1_file', () async {
      Directory top = await ctx.prepare();
      //Directory
      Directory dir = new Directory(join(top.path, 'dir'));
      File file = new File(join(dir.path, "file"));
      await file.create(recursive: true);
      await file.writeAsString("test", flush: true);
      File deployYamlFile = new File(join(dir.path, "deploy.yaml"));
      await deployYamlFile.create();

      Directory dst = new Directory(join(top.path, 'dst'));

      await runCmd(
          dartCmd([dirdeployDartScript, deployYamlFile.path, dst.path]));
      //await runCmd(dartCmd([dirdeployDartScript, '--dir', dir.path, dst.path]));
      //print(processResultToDebugString(result));
    });

    test('dir', () async {
      Directory top = await ctx.prepare();
      //Directory
      Directory dir = new Directory(join(top.path, 'dir'));
      File file = new File(join(dir.path, "file"));
      await file.create(recursive: true);
      await file.writeAsString("test", flush: true);

      Directory dst = new Directory(join(top.path, 'dst'));

      await runCmd(dartCmd([dirdeployDartScript, "--dir", dir.path, dst.path]));
      //await runCmd(dartCmd([dirdeployDartScript, '--dir', dir.path, dst.path]));
      //print(processResultToDebugString(result));

      String filePath = join(dst.path, 'file');

      expect(await new File(filePath).readAsString(), "test");

      if (fs.supportsFileLink) {
        expect(await FileSystemEntity.isLink(filePath), isTrue);
      }
    });
    */
  });
}

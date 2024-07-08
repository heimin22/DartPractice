import 'dart:async';
import 'dart:io';

late int randomNumber;
late int chosenNumber;

List<String> websiteGames = [
  'http://surl.li/kwtwjv',
  'http://surl.li/pamdiw',
  'http://surl.li/gxkhsf',
  'http://surl.li/zrivel',
  'http://surl.li/riuuvp'
];

Map<int, String> randomMapping = {};

void main() {
  websiteRandomizer();
  websiteChooser();
}

void websiteRandomizer() {
  List<int> numbers = List.generate(5, (i) => i + 1)..shuffle();

  for (int i = 0; i < websiteGames.length; i++) {
    randomMapping[numbers[i]] = websiteGames[i];
  }
}

void websiteChooser() {
  int? choice;
  while (choice == null || !randomMapping.containsKey(choice)) {
    stdout.write("Pili ka ng number from 1 to 5: ");
    choice = int.tryParse(stdin.readLineSync()!);
    if (choice == null || !randomMapping.containsKey(choice)) {
      print('bawal yan lods, ulit ka.');
    }
  }

  String url = randomMapping[choice]!;

  int countDown = 3;

  print('Ang website na napili mo ay...\n');

  Timer.periodic(Duration(seconds: 1), (Timer timer) {
    if (countDown > 0) {
      countDown--;
      stdout.write('\r${countDown + 1}');
      stdout.flush();
    }
    else {
      timer.cancel();
      print('\n\npag yan bold maangas.');
      try {
        if (Platform.isWindows) {
          Process.run('cmd', ['/c', 'start', url]);
          print('bomba');
        }
        else if (Platform.isMacOS) {
          Process.run('open', [url]);
          print('bomba');
        }
        else if (Platform.isLinux) {
          Process.run('xdg-open', [url]);
          print('bomba');
        }
        else {
          print('Unsupported operating system');
          return;
        }
        // Timer(Duration(seconds: 2), () {
        //   repeatGame();
        // });
      }
      catch (e) {
        print('Error occured: $e');
      }
    }
  });
}

// void repeatGame() {
//   int? choice;
//
//   stdout.write('\nMaglalaro ka pa ba? (1 for kapag oo, 2 kapag hindi): ');
//   choice = int.tryParse(stdin.readLineSync()!);
//
//   if (choice == 1) {
//     main();
//   }
//   if (choice == 2) {
//     exit(0);
//   } else {
//     print('bawal yan pre');
//   }
// }

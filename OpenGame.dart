import 'dart:io';
import 'dart:math';

late int randomNumber;
late int chosenNumber;

List<String> websiteGames = [
  'https://i.pinimg.com/736x/c0/66/78/c066789311c873ac7a164d656d5911ae.jpg',
  'https://i.pinimg.com/564x/75/fc/c6/75fcc6b11ec2e2a2a6b7163e676c2764.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGNmAU3b41s55t9KmnBlN2PeUMtNe-C3bmsROChdZlddBEeNWeETfe3SU5D6NqF0q4RTg&usqp=CAU',
  'https://i.pinimg.com/originals/6b/fc/0d/6bfc0d953f2619c0b8bcfa8bad6c0e4b.gif',
  'https://www.xvideos.com/'
];


void main() {
  websiteRandomizer();
  print("Pili ka ng number from 1 to 5: ");
  websiteChooser();
}

void websiteRandomizer() {
  Map<int, String> randomMapping = {};
  List<int> numbers = List.generate(5, (i) => i + 1)..shuffle();

  for (int i = 0; i < websiteGames.length; i++) {
    randomMapping[numbers[i]] = websiteGames[i];
  }
}

void websiteChooser() {

}
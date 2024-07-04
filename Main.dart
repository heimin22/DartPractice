late final String name;
late final int yearBorn;
late final double favoriteNumber;

void main() {
  name = 'Fyke';
  yearBorn = 2004;
  favoriteNumber = 22.2;
  int intFaveNum = favoriteNumber.toInt();
  // List<String> nameLists = ['Fyke', 'Simon', 'V.', 'Tonel'];
  assert(yearBorn == 2004);

  if (name != null) {
    print('Name of the student: $name'
        + '\nBirth year: $yearBorn'
        + '\nFavorite number: $favoriteNumber'
        + '\nInteger favorite number: $intFaveNum');
  }
  else {
    print('Unknown student');
  }
}
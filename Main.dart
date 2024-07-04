void main() {
  String name = 'Fyke';
  int yearBorn = 2004;
  double favoriteNumber = 22.2;
  List<String> nameLists = ['Fyke', 'Simon', 'V.', 'Tonel'];
  assert(yearBorn == 2004);

  if (name != null) {
    print('Name of the student: $name'
        + '\nBirth year: $yearBorn'
        + '\nFavorite number: $favoriteNumber');
  }
  else {
    print('Unknown student');
  }
}
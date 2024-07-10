void main() {
  int x = 23, y = 21, z = 44, sum = x % y;
  print('Ito ay isang equation motherfucker (23 % 21): ${sum}\n'
      'Si 23 % 21 ba ay equals to 44? ${(sum == z) ? 'Oo naman equal siya sa 44'
          : (x + y != sum) ? 'Hindi pare kasi ang sagot niyan is: ${sum}' : 'Ewan ko pre kung anong sagot'}');
}
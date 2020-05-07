import 'dart:collection';

String convertIntToString(int intPrice) {
  String price = "";
  String rawPrice = intPrice.toString();
  Queue<String> queue = new Queue();
  for (var i = rawPrice.length - 1, count = 1; i >= 0; i -= 1, ++count) {
    queue.addFirst(rawPrice[i]);
    if (count % 3 == 0 && i != 0) {
      queue.addFirst('.');
    }
  }
  while (queue.isNotEmpty) {
    price += queue.removeFirst();
  }
  return price;
}

int convertStringToInt(String rawPrice) {
  String price = "";
  for (var i = 0; i < rawPrice.length; ++i) {
    if (rawPrice[i] != '.') price += rawPrice[i];
  }
  return int.parse(price);
}
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "home" : MessageLookupByLibrary.simpleMessage("Home page"),
    "order" : MessageLookupByLibrary.simpleMessage("Order"),
    "user" : MessageLookupByLibrary.simpleMessage("User"),
    "point": MessageLookupByLibrary.simpleMessage("Point(s)"),
    "barcode": MessageLookupByLibrary.simpleMessage("Barcodes"),
    "promotionHeadlines": MessageLookupByLibrary.simpleMessage("Prefered promotions"),
    "news": MessageLookupByLibrary.simpleMessage("News"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "promotion": MessageLookupByLibrary.simpleMessage("Promotion"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "drinkMenu": MessageLookupByLibrary.simpleMessage("Drink"),
    "accountInfo": MessageLookupByLibrary.simpleMessage("Account Info"),
    "addressManagement": MessageLookupByLibrary.simpleMessage("Address Management"),
    "paymentInfo": MessageLookupByLibrary.simpleMessage("Payment Info"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "notification": MessageLookupByLibrary.simpleMessage("Recieve notifications from Y.A.M.A"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Dark theme"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "hello": MessageLookupByLibrary.simpleMessage("Welcome to Y.A.M.A"),
    "login": MessageLookupByLibrary.simpleMessage("Let's login with us"),
    "loginGoogle": MessageLookupByLibrary.simpleMessage("Login with google"),
    "loginFacebook": MessageLookupByLibrary.simpleMessage("Login with facebook"),
    "newbie": MessageLookupByLibrary.simpleMessage("Newbie"),
    "gold": MessageLookupByLibrary.simpleMessage("Gold member"),
    "diamon": MessageLookupByLibrary.simpleMessage("Diamond member"),
    "platinum": MessageLookupByLibrary.simpleMessage("Platinum member"),
    "silver": MessageLookupByLibrary.simpleMessage("Silver member"),
    "milktea": MessageLookupByLibrary.simpleMessage("Bubble tea"),
    "coffee": MessageLookupByLibrary.simpleMessage("Coffee"),
    "ice": MessageLookupByLibrary.simpleMessage("Ice blended"),
    "cake": MessageLookupByLibrary.simpleMessage("Cake"),
    "best": MessageLookupByLibrary.simpleMessage("Best sellers"),
    "food": MessageLookupByLibrary.simpleMessage("Get more drink ..."),
    "pick": MessageLookupByLibrary.simpleMessage("Pick")
  };
}

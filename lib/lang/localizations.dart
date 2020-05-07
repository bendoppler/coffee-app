import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cafe_app/lang/lang_all.dart';

class AppLocalizations{
  static Future<AppLocalizations> load(Locale locale) {
    print('load' + 'app localizations');
    final String name =
    locale.countryCode == null ? locale.languageCode : 'vi';
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }
  static AppLocalizations of (BuildContext context){
    return Localizations.of<AppLocalizations>(
      context, AppLocalizations
    );
  }


  String get appTitle => "You Are My Angel";
  String get appSymbol => "Y.A.M.A";

  String get homePage{
    return Intl.message('Trang chủ', name: 'home');
  }

  String get order{
    return Intl.message('Đặt hàng', name: 'order');
  }

  String get user{
    return Intl.message('Người dùng', name: 'user');
  }

  String get appOrderTitle => "Đặt hàng online";

  String get point {
    return Intl.message("điểm", name: 'point');
  }

  String get barcode {
    return Intl.message('Tích điểm', name: 'barcode');
  }

  String get coupon => 'Coupon';

  String get promotions{
    return Intl.message('Các khuyến mãi có thể nhận', name: 'promotionHeadlines');
  }

  String get news{
    return Intl.message('Tin tức', name: 'news');
  }


  String get address{
    return Intl.message('Địa chỉ', name: 'address');
  }

  String get promotion{
    return Intl.message('Khuyến mãi', name: 'promotion');
  }

  String get time{
    return Intl.message('Thời gian', name: 'time');
  }

  String get drinkMenu{
    return Intl.message('Chọn thức uống', name: 'drinkMenu');
  }

  String get accountInfo{
    return Intl.message('Thông tin tài khoản', name: 'accountInfo');
  }

  String get addressManagement{
    return Intl.message('Quản lý địa chỉ nhận hàng', name: 'addressManagement');
  }

  String get paymentInfo{
    return Intl.message('Thông tin thanh toán', name: 'paymentInfo');
  }

  String get history{
    return Intl.message('Lịch sử', name: 'history');
  }

  String get settings{
    return Intl.message('Cài đặt', name: 'settings');
  }

  String get notifications{
    return Intl.message('Nhận thêm thông báo từ Y.A.M.A', name: 'notification');
  }

  String get darkTheme{
    return Intl.message('Giao diện tối', name: 'darkTheme');
  }

  String get logout{
    return Intl.message('Đăng xuất', name: 'logout');
  }

  String get hello{
    return Intl.message("Y.A.M.A chào bạn!", name: 'hello');
  }

  String get login{
    return Intl.message('Mình đăng nhập vào nào', name: 'login');
  }

  String get loginGoogle{
    return Intl.message('Đăng nhập với Google', name: 'loginGoogle');
  }

  String get loginFacebook{
    return Intl.message('Đăng nhập với Facebook', name: 'loginFacebook');
  }

  String get newbie{
    return Intl.message('Thành viên mới', name: 'newbie');
  }

  String get gold{
    return Intl.message('Thành viên vàng', name: 'gold');
  }

  String get silver{
    return Intl.message('Thành viên bạc', name: 'silver');
  }


  String get platinum{
    return Intl.message('Thành viên bạch kim', name: 'platinum');
  }

  String get milkTea{
    return Intl.message("Trà sữa", name: 'milktea');
  }

  String get coffee{
    return Intl.message("Cà phê", name: 'coffee');
  }

  String get ice{
    return Intl.message("Đá xay", name: 'ice');
  }

  String get cake{
    return Intl.message("Bánh", name: 'cake');
  }

  String get best{
    return Intl.message("Nổi bật", name:'best');
  }

  String get food{
    return Intl.message("Món gì đây nhỉ?", name: 'food');
  }

  String get pick{
    return Intl.message('Chọn', name: 'pick');
  }

  String get cart{
    return Intl.message('Giỏ hàng', name: 'Shopping cart');
  }
  
  String get deliveryAddress{
    return Intl.message('Địa chỉ giao hàng', name: 'delivery address');
  }

  String get paymentMethod{
    return Intl.message('Hình thức thanh toán', name: 'payment method');
  }

  String get noAddress{
    return Intl.message('Chưa có địa chỉ nào được thêm. Xin vui lòng thêm địa chỉ giao hàng',name: 'no address');
  }
  String get addAddress{
    return Intl.message("Thêm địa chỉ", name: 'add address');
  }
  String get addCreditCard{
    return Intl.message('Thêm thẻ tín dụng', name: 'add credit cards');
  }
  String get payWhenReceive{
    return Intl.message('Thanh toán khi nhận hàng',name: 'pay when recieve');
  }
  String get deliveryFee{
    return Intl.message('Phí vận chuyển', name: 'delivery fee');
  }
  String get total{
    return Intl.message('Tổng tiền', name: 'total');
  }
  String get orderConfirmation{
    return Intl.message('Xác nhận đơn hàng',name: 'order confirmation');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  const AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    print('load' + locale.toString());
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return true;
  }

  @override
  bool isSupported(Locale locale) {
    print('supported' + locale.languageCode);
    return ['en', 'vi'].contains(locale.languageCode);
  }
}
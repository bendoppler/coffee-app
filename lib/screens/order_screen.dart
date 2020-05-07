import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/blocs/category_bloc.dart';
import 'package:cafe_app/blocs/order_bloc.dart';
import 'package:cafe_app/requests/order_request.dart';
import 'package:cafe_app/widgets/address.dart';
import 'package:cafe_app/widgets/order_scrollview.dart';
import 'package:cafe_app/widgets/promotion.dart';
import 'package:cafe_app/widgets/time.dart';
import 'package:cafe_app/widgets/utils/snack_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget{

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  CategoryBloc _categoryBloc;
  OrderBloc _orderBloc;
  @override
  void initState() {
    _categoryBloc = CategoryBloc();
    _orderBloc = OrderBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dialog orderDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Container(
        height: 292.0,
        width: 313.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Mã đơn hàng của bạn là 1000000001',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Nhân viên sẽ gọi và xác nhận đơn hàng trong giây lát. Bạn có thể theo dõi trạng thái đơn hàng qua mục ‘Đơn hàng’",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Color(0xff939393)
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8.0)
              ),
              width: 250,
              height: 40,
              child: RaisedButton(
                color: Colors.amber,
                onPressed: (){
                  //TODO: go to screen follow order delivery
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    'Theo dõi đơn hàng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                  width: 2.0,
                  color: Colors.amber,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: RaisedButton(
                color: Colors.white,
                onPressed: (){
                  _orderBloc.deleteOrder();
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    return BlocProvider<OrderBloc>(
      bloc: _orderBloc,
      child: BlocProvider<CategoryBloc>(
        bloc: _categoryBloc,
        child: StreamBuilder<OrderRequest>(
          stream: _orderBloc.orderRequestStream,
          builder: (context, snapshot) {
            if(snapshot.data != null && snapshot.hasData && snapshot.data.result == '200'){
              WidgetsBinding.instance.addPostFrameCallback((_)=>{
                showDialog(context: context, builder: (BuildContext context)=>orderDialog)
              });
            }else if(snapshot.data != null && snapshot.hasData && snapshot.data.result != '200'){
              WidgetsBinding.instance.addPostFrameCallback((_)=>showErrorSnackbar(
                context,
                message: "Đặt hàng không thành công. Xin vui lòng thử lại",
                duration: Duration(seconds: 4)));
            }
            return Container(
              color: Theme
                .of(context)
                .brightness == Brightness.light
                ? Colors.white
                : Color(0xFF303030),
              constraints: BoxConstraints.expand(),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AddressWidget(_orderBloc),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0, bottom: 16.0),
                        child: Row(
                          children: <Widget>[
                            PromotionWidget(),
                            Container(
                              height: 1.0,
                              width: 12.0,
                              color: Colors.transparent,
                            ),
                            TimeWidget()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: OrderScrollview(),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  @override
  void dispose() {
    _categoryBloc?.dispose();
    _orderBloc?.dispose();
    super.dispose();
  }
}
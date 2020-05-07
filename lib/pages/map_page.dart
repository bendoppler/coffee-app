import 'package:cafe_app/blocs/application_bloc.dart';
import 'package:cafe_app/blocs/bloc_provider.dart';
import 'package:cafe_app/configurations/general.dart';
import 'package:cafe_app/lang/localizations.dart';
import 'package:cafe_app/widgets/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
class MapScreen extends StatefulWidget {
  final mapScreenScaffoldKey = GlobalKey<ScaffoldState>();
  final orderBloc;
  MapScreen({@required this.orderBloc});
  @override
  State<StatefulWidget> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController _mapController;
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  MapType _currentMapType = MapType.normal;
  Marker _selectedMarker;
  Set<Marker> _markers = new Set();
  GoogleMapsPlaces _places;

  @override
  void initState(){
    _places = GoogleMapsPlaces(apiKey: GOOGLE_MAP_KEY);
    print("place: "+_places.toString());
    _getLocation().then((position) {
      if(position!=null)
        widget.orderBloc.userLocationSink.add(new LatLng(position.latitude, position.longitude));
    });
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _selectedMarker = widget.orderBloc.getMarker();
      if(_selectedMarker!=null){
        _markers.clear();
        _markers.add(_selectedMarker);
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_selectedMarker.position, 16.0)
        );
      }
    });
  }



  Future<LatLng> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
      return new LatLng(currentLocation.latitude, currentLocation.longitude);
    } catch (e) {
      currentLocation = null;
      return null;
    }

  }
  void updateMarker(Marker marker) {
    setState((){
      _markers.clear();
      _selectedMarker = marker;
      _markers.add(marker);
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedMarker.position, 16.0)
      );
    });
  }
  Future<Null> displayPrediction(Prediction p) async {
    print('Updating marker...');
    if (p != null) {
      // get detail (lat/lng)
      _places.getDetailsByPlaceId(p.placeId).then((detail){
        print("place detail: "+ detail.result.id);
        final lat = detail.result.geometry.location.lat;
        final lng = detail.result.geometry.location.lng;
        updateMarker(
          new Marker(
            markerId: MarkerId(p.placeId),
            position: new LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: p.description
            ),
            icon: BitmapDescriptor.defaultMarker
          )
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<LatLng>(
                  initialData: _center,
                  stream: widget.orderBloc.userLocationStream,
                  builder: (context, snapshot){
                    print("location: " + snapshot.data.toString());
                    if(snapshot.data == null){
                      WidgetsBinding.instance.addPostFrameCallback((_)=>showErrorSnackbar(
                        context,
                        message: "Could not get user location",
                        duration: Duration(seconds: 4)));
                      return GoogleMap(
                        mapType: _currentMapType,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 16.0,
                        ),
                        markers: _markers,
                      );
                    }else{
                      return GoogleMap(
                        mapType: _currentMapType,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: snapshot.data,
                          zoom: 16.0,
                        ),
                        markers: _markers,
                      );
                    }
                  }
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 54.0, left: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black87,
                          ),
                          onPressed: (){
                            _applicationBloc.themeSink.add(
                              ThemeData(
                                primaryColor: Colors.amber
                              )
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: RaisedButton(
                              onPressed: () async{
                                _applicationBloc.themeSink.add(
                                  ThemeData(
                                    primaryColor: Colors.white
                                  )
                                );
                                Prediction p = await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: GOOGLE_MAP_KEY,
                                  language: 'vi',
                                  components: [
                                    Component(Component.country, "vn")
                                  ]
                                );
                                _applicationBloc.themeSink.add(
                                  ThemeData(
                                    primaryColor: Colors.amber
                                  )
                                );
                                await displayPrediction(p);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 18.0),
                                child: Text(
                                  _selectedMarker == null
                                    ? AppLocalizations.of(context).address
                                    : _selectedMarker
                                      .infoWindow.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                )
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                              color:
                              Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Color(0xFF424242),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 36.0, right: 16.0, left: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        widget.orderBloc.addMarker(_selectedMarker);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Xác nhận', style: Theme.of(context).textTheme.button.apply(
                          color: Colors.black87
                        )),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}

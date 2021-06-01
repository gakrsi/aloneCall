import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearYouMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: GetBuilder<HomeController>(
      builder:(_controller)=> Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('Near You',style: Styles.white16.copyWith(fontWeight: FontWeight.bold,fontSize: 20),),
                actions: [
                  IconButton(icon: const Icon(Icons.more_vert,color: Colors.white,), onPressed: (){
                    onMapVisible(_controller);
                  })
                ],
              ),
              body: Stack(
                  children: <Widget>[
                    Positioned(
                      top:0,
                      child: Container(
                        width: Dimens.screenWidth,
                        height: Dimens.thirty,
                        color: Colors.black45,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on,color: Colors.white,),
                            SizedBox(width: Dimens.ten,),
                            Text('${_controller.city}, ${_controller.country}',style: Styles.white16,)
                          ],
                        ),
                      ),
                    ),
                    // Google Map widget
                    Opacity(
                      opacity: _controller.isMapLoading ? 0 : 1,
                      child: GoogleMap(
                          mapType: MapType.none,
                          mapToolbarEnabled: true,
                          zoomGesturesEnabled: true,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          zoomControlsEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(_controller.lat, _controller.long),
                            zoom: _controller.currentZoom,
                          ),
                          markers: _controller.markers,
                          onMapCreated: (controller) => _controller.onMapCreated(controller),
                          onCameraMove: (position) => _controller.updateMarkers(position.zoom),
                        ),
                    ),
                    // Map loading indicator
                    Opacity(
                      opacity: _controller.isMapLoading ? 1 : 0,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    Positioned(
                      top:0,
                      child: Container(
                        width: Dimens.screenWidth,
                        height: Dimens.thirty,
                        color: Colors.black45,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on,color: Colors.white,),
                            SizedBox(width: Dimens.ten,),
                            Text('${_controller.city}, ${_controller.country}',style: Styles.white16,)
                          ],
                        ),
                      ),
                    ),
                    // Map markers loading indicator
                    if (_controller.areMarkersLoading)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                            elevation: 2,
                            color: Colors.grey.withOpacity(0.9),
                            child: const Padding(
                              padding:  EdgeInsets.all(4),
                              child: Text(
                                'Loading',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
      ),
    )
  );

  void onMapVisible(HomeController con){
    Get.bottomSheet<dynamic>(
        Container(
          color: Colors.white,
          height: Dimens.ninetyTwo,
          width: Dimens.screenWidth,
          child: ListTile(
            title:  Text('Visibility',style: Styles.black18,),
            subtitle: Text(con.textValue),
            trailing: Transform.scale(
                scale: 2,
                child: Switch(
                  onChanged: con.toggleSwitch,
                  value: con.isSwitched,
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.yellow,
                  inactiveThumbColor: Colors.redAccent,
                  inactiveTrackColor: Colors.orange,
                )
            ),
          ),

    ));
  }
}

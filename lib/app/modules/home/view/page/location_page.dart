import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

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
              body: StreamBuilder(
                  stream: Repository().nearYou(_controller.model.city),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                          children: List.generate(
                              4,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: Dimens.screenWidth,
                                  height: Dimens.fifty,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetConstants.loading,
                                          fit: BoxFit.cover)),
                                ),
                              )));
                    }
                    return ListView(
                        children: snapshot.data.docs
                            .map((DocumentSnapshot document) {
                          var model = ProfileModel.fromJson(
                              document.data() as Map<String, dynamic>);
                          var distance = Geolocator.distanceBetween(_controller.lat,_controller.long,model.lat,model.long)/1000;
                          if(model.uid == Repository().uid){
                            return const SizedBox();
                          }
                          return InkWell(
                            onTap: () {
                              RoutesManagement.goToOthersProfileDetail(model);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: Dimens.screenWidth,
                                height: Dimens.fifty,
                                child: Row(
                                  children: [
                                    Container(
                                      height: Dimens.fifty,
                                      width: Dimens.fifty,
                                      decoration: BoxDecoration(
                                          color: ColorsValue.lightGreyColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimens.fifty)),
                                      child: circularPhoto(
                                          imageUrl:
                                          model.profileImageUrl[0] as String),
                                    ),
                                    SizedBox(
                                      width: Dimens.ten,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(model.name,
                                                  style: Styles.blackBold16),
                                              Text(
                                                  ', ${DateTime.now().year - int.parse(model.dob.substring(0, 4))}',
                                                  style: Styles.blackBold16),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${model.city}, ',
                                                style: Styles.grey14,
                                              ),
                                              Text(
                                                '${model.country}, ',
                                                style: Styles.grey14,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    const Spacer(),
                                    Text('${distance.ceilToDouble()} Km')
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList());
                  })
      ),
    )
  );
  // Widget stack() => Stack(
  //   children: <Widget>[
  //     // Google Map widget
  //     _controller.lat == 0.0 ?Container():Opacity(
  //       opacity: _controller.isMapLoading ? 0 : 1,
  //       child: GoogleMap(
  //         mapType: MapType.normal,
  //         mapToolbarEnabled: true,
  //         zoomGesturesEnabled: true,
  //         myLocationButtonEnabled: true,
  //         myLocationEnabled: true,
  //         zoomControlsEnabled: true,
  //         initialCameraPosition: CameraPosition(
  //           target: LatLng(_controller.lat, _controller.long),
  //           zoom: _controller.currentZoom,
  //         ),
  //         markers: _controller.markers,
  //         onMapCreated: (controller) => _controller.onMapCreated(controller),
  //         onCameraMove: (position) => _controller.updateMarkers(position.zoom),
  //       ),
  //     ),
  //     // Map loading indicator
  //     Opacity(
  //       opacity: _controller.isMapLoading ? 1 : 0,
  //       child: const Center(child: CircularProgressIndicator()),
  //     ),
  //     Positioned(
  //       top:0,
  //       child: Container(
  //         width: Dimens.screenWidth,
  //         height: Dimens.thirty,
  //         color: Colors.black45,
  //         child: Row(
  //           children: [
  //             const Icon(Icons.location_on,color: Colors.white,),
  //             SizedBox(width: Dimens.ten,),
  //             Text('${_controller.city}, ${_controller.country}',style: Styles.white16,)
  //           ],
  //         ),
  //       ),
  //     ),
  //     // Map markers loading indicator
  //     if (_controller.areMarkersLoading)
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Align(
  //           alignment: Alignment.topCenter,
  //           child: Card(
  //             elevation: 2,
  //             color: Colors.grey.withOpacity(0.9),
  //             child: const Padding(
  //               padding:  EdgeInsets.all(4),
  //               child: Text(
  //                 'Loading',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //   ],
  // );
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

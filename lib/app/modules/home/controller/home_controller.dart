import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/modules/home/view/home_view.dart';
import 'package:alonecall/app/modules/home/view/local_widget/profile_edit_dialog.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  /// Current index in [HomeView]
  int currentTab = 0;

  final List<BottomNavigationBarItem> tab = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ' '),
  ];

  void changeTab(int index) {
    currentTab = index;
    update();
  }


  ///#########################################################################################################################
  int profileCurrentTab = 0 ;

  void changeProfileTab(int index){
    profileCurrentTab = index;
    update();
  }
  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }
  void showEditProfileDialog() {
    closeDialog();
    Get.bottomSheet<void>(
      ProfileEditDialog(model: model,),
    );
  }
















  ///#########################################################################################################################



  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  ProfileModel model = ProfileModel();

  @override
  void onInit() async {
   var data = await Repository().getProfile();
    print(data);
    model = ProfileModel.fromJson(data);
    super.onInit();
  }

  TextEditingController nameController = TextEditingController();

  final CommonService _commonService = Get.find();

  List<String> genderList = <String>['Male','Female','Gay','Lesbian'];
  List<String> countryList = <String> ['India','Nepal','Bhutan','Pakistan'];
  List<String> languageList = <String>['English', 'Hindi', 'Bengali', 'Marathi', 'Telugu', 'Tamil', 'Gujarati', 'Urdu', 'Kannada', 'Odia (Oriya)', 'Malayalam', 'Punjabi', 'Bodo', 'Dogri', 'Kashmiri', 'Konkani', 'Maithili', 'Manipuri', 'Nepali', 'Sanskrit', 'Santali Language', 'Sindhi', 'Assamese'];


  void showGenderBottomSheet(){
    Get.bottomSheet<void>(
        Container(
          height: 150,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: List.generate(genderList.length, (index) => InkWell(
                  onTap: (){
                    model.gender = genderList[index];
                    update();
                    Utility.closeBottomSheet();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(30),
                        color: model.gender == genderList[index]?ColorsValue.primaryColor:Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          )
                        ]
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
                        child: Text(genderList[index],style: Styles.grey16,)
                    ),
                  ),
                ))
            ),
          ),
        ),
        backgroundColor: Colors.white
    );
  }
  void showLanguageBottomSheet(){
    Get.bottomSheet<void>(
        Container(
          height: 400,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(languageList.length, (index) => InkWell(
                    onTap: (){
                      model.lang = languageList[index];
                      update();
                      Utility.closeBottomSheet();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(30),
                          color: model.lang == languageList[index]?ColorsValue.primaryColor:Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ]
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
                          child: Text(languageList[index],style: Styles.grey16,)
                      ),
                    ),
                  ))
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white
    );
  }
  void showCountryBottomSheet(){
    Get.bottomSheet<void>(
        Container(
          height: 200,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(countryList.length, (index) => InkWell(
                    onTap: (){
                      model.country = countryList[index];
                      update();
                      Utility.closeBottomSheet();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(30),
                          color: model.country == countryList[index]?ColorsValue.primaryColor:Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ]
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
                          child: Text(countryList[index],style: Styles.grey16,)
                      ),
                    ),
                  ))
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white
    );
  }

  /// Shows a bottom sheet with gallery and camera option
  /// for the user to choose from where the image must be picked.
  // void getImage() {
  //   print('get image function called');
  //   Get.bottomSheet<void>(
  //     ListView(
  //       shrinkWrap: true,
  //       primary: false,
  //       children: [
  //         ListTile(
  //           leading: const Icon(
  //             Icons.image,
  //           ),
  //           title: Text(
  //             'gallery',
  //             style: Styles.black18,
  //           ),
  //           onTap: () {
  //             getImageUrlFromGallery();
  //             Utility.closeBottomSheet();
  //           },
  //         ),
  //         ListTile(
  //           leading: const Icon(
  //             Icons.camera,
  //           ),
  //           title: Text(
  //             'camera',
  //             style: Styles.black18,
  //           ),
  //           onTap: () {
  //             getImageUrlFromCamera();
  //             Utility.closeBottomSheet();
  //           },
  //         ),
  //       ],
  //     ),
  //     backgroundColor: Colors.white,
  //   );
  // }

  /// Update the image url which is selected by the user.
  void updateImageUrl(String imageUrl) {
    if (imageUrl.isNotEmpty) {
      print(imageUrl);
      // this.imageUrl = imageUrl;
      // enableSubmitButton();
    }
  }

  // /// Get image from gallery.
  // void getImageUrlFromGallery() async {
  //   updateImageUrl(await _commonService.getImageFromGallery());
  // }
  //
  // /// Get image from camera.
  // void getImageUrlFromCamera() async {
  //   print('get image from camera called');
  //   updateImageUrl(await _commonService.getImageFromCamera());
  // }

  /// Upload User data Firebase
  void validateAndSubmit(){
    if(nameController.text.isNotEmpty && model.gender != null && model.country != null && model.lang != null && model.dob != null){
      model.name = nameController.text;
      // ignore: cascade_invocations
      model.uid = Repository().currentUser();
      updatePageStatus(PageStatus.loading);
      Repository().createProfile(model).whenComplete(()=> updatePageStatus(PageStatus.idle));
    }
    else{
      Utility.showError('Enter All field');
    }
  }

  /// Update the page status
  /// [pageStatus] : the new page status.
  void updatePageStatus(PageStatus pageStatus) {
    this.pageStatus = pageStatus;
    update();
  }
}
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController<void>{
  @override
  void onInit() {
    if(Repository().isUserLogin()){
      Utility.printDLog('USER IS ONLINE');
      Repository().makeUserOnline();
    }
    super.onInit();
  }
  @override
  void onDetached() {
    Utility.printDLog('USER IS DETACHED');
    Repository().makeUserOffline();
  }

  @override
  void onInactive() {
    Utility.printDLog('USER IS INACTIVE');
    Repository().makeUserOffline();
  }

  @override
  void onPaused() {
    Utility.printDLog('USER IS PAUSED');
    Repository().makeUserOffline();
  }

  @override
  void onResumed() {
    Utility.printDLog('USER IS RESUMED');
    Repository().makeUserOnline();
  }

}
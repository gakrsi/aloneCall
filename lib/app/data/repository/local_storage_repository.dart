import 'package:hive/hive.dart';

class LocalRepository {

  var box = Hive.box<dynamic>('wallet');

  void addCoin(int coin, int audioCoin) {
    box..put('coin', coin)..put('audio_coin', audioCoin);
  }

  void update(int coin) {
    box.put('coin', coin);
  }

  void updateAudioCoin(int coin){
    box.put('audio_coin', coin);
  }

  int getCoin() => box.get('coin') as int;
  int getAudioCoin() => box.get('audio_coin') as int;
}

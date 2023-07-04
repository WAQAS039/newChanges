import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/models/azkar.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:vibration/vibration.dart';

class TasbeehProvider extends ChangeNotifier{
  final List<Azkar> _tasbeehList = [
    Azkar("سُبْحَانَ ٱللَّٰهِ", "subhanallah"),
    Azkar("ٱلْحَمْدُ لِلَّٰهِ", "alhamulillah"),
    Azkar("اللّٰهُ أَكْبَر", "allah_hu_akbar"),];
  List<Azkar> get tasbeehList => _tasbeehList;
  final List<int> _counterList = [33,34,41,100];
  List<int> get counterList => _counterList;
  int _currentCounter = 33;
  int get currentCounter => _currentCounter;
  bool _isVibrate = true;
  bool get isVibrate => _isVibrate;

  bool _isCustomTasbeeh = false;
  bool get isCustomTasbeeh => _isCustomTasbeeh;
  int _currentTabeeh = 0;
  int get currentTabeeh => _currentTabeeh;
  int _selectedCounter = 0;
  int get selectedCounter => _selectedCounter;
  int _counter = 0;
  int get counter => _counter;
  bool error = false;
  void setError(bool e){
    error = e;
    notifyListeners();
  }

  void setIsCustomTasbeeh() {
    _currentTabeeh = -1;
    _isCustomTasbeeh = true;
    _counter = 0;
    // setSelectedCounter(2);
    notifyListeners();
  }

  void setCurrentTasbeeh(int current){
    _isCustomTasbeeh = false;
    _currentTabeeh = current;
    // resetCustomCounter();
    if(current == 2){
      _currentCounter = 34;
      setSelectedCounter(1);
    }else{
      setSelectedCounter(0);
      _currentCounter = 33;
    }
    notifyListeners();
  }


  void setSelectedCounter(int counter){
    _selectedCounter = counter;
    _counter = 0;
    if(counter != -1){
      _currentCounter = _counterList[counter];
    }
    notifyListeners();
  }

  void increaseCounter()async{
    _counter++;
    if(_counter == currentCounter){
      _counter = 0;
      await playSound();
      if(currentCounter == 33){
        if(_currentTabeeh == 0){
          setCurrentTasbeeh(1);
        }else if(_currentTabeeh == 1){
          setCurrentTasbeeh(2);
        }
      }
    }
    notifyListeners();
  }

  void setCustomCounter(int counter,BuildContext context,AppColorsProvider appColors){
    if(counter != 0){
      _currentCounter = counter;
      int index = _counterList.indexWhere((element) => element == counter);
      if(index != -1){
        setSelectedCounter(index);
      }else{
        setSelectedCounter(-1);
      }
      notifyListeners();
    }
  }

  void reset() async{
    _currentCounter = 33;
    _currentTabeeh = 0;
    _counter = 0;
    setCurrentTasbeeh(0);
    notifyListeners();
  }

  playSound() async{
    bool? isAvailable = await Vibration.hasVibrator() ?? false;
    if (isAvailable && _isVibrate) {
      Vibration.vibrate();
    }
  }

  setIsVibrate(){
    _isVibrate = !_isVibrate;
    notifyListeners();
  }

  // void resetCounter(){
  //   _counter = 0;
  //   notifyListeners();
  // }
}
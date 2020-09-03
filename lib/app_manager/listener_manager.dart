
import 'dart:async';

class ListenerManager{


  static StreamController<Map> _loginManageListener =
  new StreamController.broadcast();//登录监听
  static StreamController _packetcaptureListener =
  new StreamController.broadcast();//抓包监听
  static Map<Function, StreamSubscription> listeners = {};


  //抓包广播
  static void packetcapture(String code){
    _packetcaptureListener.add(code);
  }

  //添加抓包监听
  static void addPacketcaptureListener(
      void onData(String code)) {
    listeners[onData] = _packetcaptureListener.stream.listen(onData);
  }


  //登录成功广播
  static void login(Map<String,Object> map){
    _loginManageListener.add(map);
  }


  //添加加登录监听
  static void addLoginManageListener(
      void onLogin(Map notification)) {
    listeners[onLogin] = _loginManageListener.stream.listen(onLogin);
  }

  //取消监听
  static void removeListener(void onData(dynamic data)) {
    StreamSubscription listener = listeners[onData];
    if (listener == null) return;
    listener.cancel();
    listeners.remove(onData);
  }


}
import 'dart:async';
import 'package:uni_links/uni_links.dart';

//设置抓包
class Packetcapture {

  static StreamController _packetcaptureListener =
  new StreamController.broadcast();//抓包监听
  static Map<Function, StreamSubscription> _listeners = {};

  //这两个数据根据你自己的项目修改
  static String scheme = "scheme://";
  static String mode = "debug";


  //设置自己的scheme
  static setConfig({
    String schemeConfig,
    String modeConfig
}){
    scheme = schemeConfig;
    mode = modeConfig;
  }

  //通过topsports://设置抓包代理
  static Future<Null> initUniLinks({Function callBack}) async {
    print('------获取参数--------');
    try{
      //app没有打开时获取link
      String link = await getInitialLink();
      if (link != null && link.contains(scheme)) {
        setNetworkAgent(link);
      }
    }catch(e){}

    //app打开时获取link
    getLinksStream().listen((String link) {
      link = Uri.decodeComponent(link);
      if (link.contains(scheme)) {
        setNetworkAgent(link,callBack:callBack );
      }
      // Parse the link and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }

  static setNetworkAgent(String link,{Function callBack}) {
    print('=======link:$link============');
    String type = getTypeStr(link);

    if (type == mode) {
      String param = link.replaceAll("$scheme$type?", "");
      Map dict = getUrlParams(param);
      //设置抓包代理
      String host = dict["host"];
      String port = dict["port"] ?? "8888";

      if(callBack!=null){
        callBack(host,port);
      }
      packetcapture("");
    }
  }

  static String getTypeStr(String link) {
    List params = link.split("?");
    String typeStr = params[0];
    typeStr = typeStr.replaceAll(scheme, "");
    return typeStr;
  }

//url参数转map
  static Map getUrlParams(String paramStr) {
    Map map = Map();
    List params = paramStr.split("&");
    for (int i = 0; i < params.length; i++) {
      String str = params[i];
      List arr = str.split("=");
      map[arr[0]] = arr[1];
    }
    return map;
  }


  //抓包广播
  static void packetcapture(String code){
    _packetcaptureListener.add(code);
  }

  //添加抓包监听
  static void addPacketcaptureListener(
      void onData(String code)) {
    _listeners[onData] = _packetcaptureListener.stream.listen(onData);
  }

  //取消监听
  static void removeListener(void onData(dynamic data)) {
    StreamSubscription listener = _listeners[onData];
    if (listener == null) return;
    listener.cancel();
    _listeners.remove(onData);
  }

}
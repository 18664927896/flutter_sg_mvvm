
import 'package:flutter_sg_mvvm/listener_manager/listener_manager.dart';
import 'package:flutter_sg_mvvm/network/network.dart';
import 'package:uni_links/uni_links.dart';

class Packetcapture {

  //通过topsports://设置抓包代理
  static Future<Null> initUniLinks() async {
    print('------获取参数--------');
    try{
      //app没有打开时获取link
      String link = await getInitialLink();
      if (link != null && link.contains("scheme://")) {
        setNetworkAgent(link);
      }
    }catch(e){}

    //app打开时获取link
    getLinksStream().listen((String link) {
      link = Uri.decodeComponent(link);
      if (link.contains("scheme://")) {
        setNetworkAgent(link);
      }
      // Parse the link and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }

  static setNetworkAgent(String link) {
    print('=======link:$link============');
    String type = getTypeStr(link);

    if (type == "debug") {
      String param = link.replaceAll("scheme://$type?", "");
      Map dict = getUrlParams(param);
      //设置抓包代理
      String host = dict["host"];
      String port = dict["port"];
      Network.setHttpProxy(host, port == null ? "8888" : port);
      ListenerManager.packetcapture("");
    }
  }

  static String getTypeStr(String link) {
    List params = link.split("?");
    String typeStr = params[0];
    typeStr = typeStr.replaceAll("scheme://", "");
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

}
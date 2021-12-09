class Config {
  /// 正式环境
  static  String BASE_URL = 'https://xxx.xxx.xxx.cn/app';
  static int configType = 2;//0开发，1测试，2正式 3培训


//  初始化配置
  Config.initConfig(){
    switch (Config.configType) {
      case 0://开发环境

        break;
      case 1://测试环境

        break;
      case 2:

        break;
      case 3://培训环境

        break;
    }

  }

}

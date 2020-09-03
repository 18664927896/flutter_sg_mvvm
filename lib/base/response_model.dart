class ResponseModel {
  final int _code;//：1正常 -1：未登录 -2：挤下线
  final int _bizCode;//业务码
  final int _errorCode;//错误码
  final String _errorMsg;//错误提示
  final dynamic _data;//数据主体
  final String _bizMsg;//业务提示

  int get code => _code;
  int get bizCode => _bizCode;
  int get errorCode => _errorCode;
  String get errorMsg => _errorMsg;
  String get bizMsg => _bizMsg;
  dynamic get data => _data;

  ResponseModel.fromJSON(Map<String, dynamic> json)
      : _code = int.tryParse(json['code']?.toString() ?? ''),
        _bizCode = json['bizCode'] ?? 0,
        _errorCode = json['errorCode']?? 0,
        _errorMsg = json['errorMsg'] ?? '',
        _data = json['data'],
        _bizMsg = json['bizMsg'];
}

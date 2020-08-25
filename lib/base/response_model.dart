class ResponseModel {
  final int _code;
  final int _bizCode;
  final int _errorCode;
  final String _errorMsg;
  final dynamic _data;
  final String _bizMsg;

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

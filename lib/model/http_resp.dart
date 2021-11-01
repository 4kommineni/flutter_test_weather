class HttpResponse {
  int code;
  dynamic msg;

  HttpResponse({required this.code, required this.msg});

  factory HttpResponse.fromJson(Map<String, dynamic> data) {
    return HttpResponse(code: data['code'], msg: data['msg']);
  }
}

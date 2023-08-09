class BadResponseModel {
  BadResponseModel({
    required this.statusCode,
    required this.success,
    required this.errorMessage,
  });

  int statusCode;
  bool success;
  String errorMessage;

  factory BadResponseModel.fromJson(Map<String, dynamic> json) =>
      BadResponseModel(
        statusCode:
            json['statusCode'] != null ? json['statusCode'] as int : 401,
        success: json['success'] != null ? json['success'] as bool : false,
        errorMessage: json['errorMessage'] ??
            json['message'] ??
            'Oops! Error occurred, please try again.',
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'errorMessage': errorMessage,
      };
}

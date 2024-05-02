import 'package:json_annotation/json_annotation.dart';
part 'MarketVisitResponse.g.dart';

@JsonSerializable()
class MarketVisitResponse {
  String questionCode;
  String response;
  String type;

  MarketVisitResponse(this.type, this.questionCode, this.response);

  String getQuestionCode() {
    return questionCode;
  }

  String getType() {
    return type;
  }

  String getResponse() {
    return response;
  }

  factory MarketVisitResponse.fromJson(Map<String, dynamic> json) => _$MarketVisitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketVisitResponseToJson(this);
}

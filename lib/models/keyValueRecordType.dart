import 'package:equatable/equatable.dart';


class KeyValueRecordType extends Equatable {
  String key;
  String value;

  KeyValueRecordType({this.key, this.value});

  @override
  List<Object> get props => [key, value];
}
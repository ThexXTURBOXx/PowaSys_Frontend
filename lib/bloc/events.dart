import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  final List _props;

  const DataEvent([this._props = const []]);

  @override
  List<Object> get props => _props as List<Object>;
}

class FetchData extends DataEvent {}

import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}

class FetchData extends DataEvent {
  const FetchData();

  @override
  List<Object?> get props => [];
}

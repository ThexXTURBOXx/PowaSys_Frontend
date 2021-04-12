import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotFetched extends DataState {}

class Fetching extends DataState {}

class FetchedData extends DataState {}

class FetchError extends DataState {}

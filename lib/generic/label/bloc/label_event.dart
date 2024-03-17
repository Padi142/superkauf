part of 'label_bloc.dart';

abstract class LabelEvent extends Equatable {
  const LabelEvent();

  @override
  List<Object> get props => [];
}

class SearchLabel extends LabelEvent {
  final String query;
  const SearchLabel({
    required this.query,
  });
}

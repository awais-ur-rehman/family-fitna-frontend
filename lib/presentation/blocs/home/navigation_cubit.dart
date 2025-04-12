import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Navigation state
class NavigationState extends Equatable {
  final int tabIndex;

  const NavigationState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

// Navigation cubit
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(tabIndex: 0));

  void changeTab(int index) {
    emit(NavigationState(tabIndex: index));
  }
}
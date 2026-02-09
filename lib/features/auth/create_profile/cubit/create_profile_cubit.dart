import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit() : super(const CreateProfileState());

  void nextPage() {
    emit(state.copyWith(activePage: state.activePage + 1));
  }

  void previousPage() {
    emit(state.copyWith(activePage: state.activePage - 1));
  }
}

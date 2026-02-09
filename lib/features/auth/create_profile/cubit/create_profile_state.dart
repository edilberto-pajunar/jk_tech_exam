part of 'create_profile_cubit.dart';

class CreateProfileState extends Equatable {
  final int activePage;

  const CreateProfileState({this.activePage = 0});

  CreateProfileState copyWith({int? activePage}) {
    return CreateProfileState(activePage: activePage ?? this.activePage);
  }

  @override
  List<Object> get props => [activePage];
}

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/blocs/profile/profile_event.dart';
import 'package:form_app/blocs/profile/profile_state.dart';
import 'package:form_app/network/rest_client.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final RestClient _client;

  ProfileBloc()
      : _client = RestClient(Dio()),
        super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _client.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

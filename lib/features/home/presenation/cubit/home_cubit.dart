import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/data/home_api_service.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/models/users.dart';
import 'package:flutter_rest_api_bloc_clean_arch/features/home/presenation/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeApiService _homeApiService = HomeApiService();
  Future<dynamic> getUsers() async {
    try {
      await _homeApiService.getUsers().then((users) {
        if (users.isNotEmpty) {
          emit(HomeSuccess(data: users));
          return users;
        }
      });
    } on HttpException catch (e) {
      emit(HomeFailure(message: e.toString()));
    } on SocketException catch (e) {
      emit(HomeFailure(message: e.toString()));
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
      return Future.error(e.toString());
    }
    return state.props;
  }
}

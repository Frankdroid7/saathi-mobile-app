import 'package:dio/src/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/features/goal/domain/goal_model.dart';
import 'package:saathi/features/goal/domain/unsplash_image_model.dart';

import '../../../utils/api_call_enum.dart';
import '../data/goal_repository_impl.dart';

var goalServiceStateNotifierProvider =
    StateNotifierProvider<GoalService, ApiCallEnum>(
        (ref) => GoalService(ref.read(goalRepoImplProvider)));

class GoalService extends StateNotifier<ApiCallEnum> implements GoalRepoImpl {
  final GoalRepoImpl goalRepoImpl;
  GoalService(this.goalRepoImpl) : super(ApiCallEnum.idle);

  String? errMsg;
  String? actionType;
  @override
  Future<bool> createGoal(GoalModel goalModel) async {
    state = ApiCallEnum.loading;

    goalRepoImpl.createGoal(goalModel).then((value) {
      state = ApiCallEnum.success;
    }).catchError((e) {
      errMsg = e.toString();

      state = ApiCallEnum.error;
    });

    return state == ApiCallEnum.success;
  }

  @override
  Future<bool> deleteGoal(String id) async {
    state = ApiCallEnum.loading;

    goalRepoImpl.deleteGoal(id).then((value) {
      actionType = 'Goal Deleted';
      state = ApiCallEnum.success;
    }).catchError((e) {
      errMsg = e.toString();
      state = ApiCallEnum.error;
    });
    return state == ApiCallEnum.success;
  }

  @override
  Future<List<GoalModel>> getGoalList() {
    return goalRepoImpl.getGoalList();
  }

  @override
  Future<GoalModel?> getSingleGoal(String id) async {
    return goalRepoImpl.getSingleGoal(id);
  }

  @override
  Future<bool> updateGoal(GoalModel goalModel) async {
    state = ApiCallEnum.loading;

    goalRepoImpl.updateGoal(goalModel).then((value) {
      actionType = 'Goal Updated';

      state = ApiCallEnum.success;
    }).catchError((e) {
      errMsg = e.toString();

      state = ApiCallEnum.error;
    });

    return state == ApiCallEnum.success;
  }

  @override
  Future<List<UnsplashImageModel>> getUnsplashImageModel(
      {required String query}) {
    throw UnimplementedError();
  }
}

var getUnsplashImagesFuture =
    FutureProvider.family<List<UnsplashImageModel>, String>((ref, q) =>
        ref.read(goalRepoImplProvider).getUnsplashImageModel(query: q));

var getGoalListFuture = FutureProvider.autoDispose(
    (ref) => ref.read(goalServiceStateNotifierProvider.notifier).getGoalList());

var getSingleGoalFuture = FutureProvider.autoDispose.family<GoalModel?, String>(
    (ref, id) =>
        ref.read(goalServiceStateNotifierProvider.notifier).getSingleGoal(id));

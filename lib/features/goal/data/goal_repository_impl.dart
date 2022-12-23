import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/constants/api_constants.dart';
import 'package:saathi/features/goal/domain/goal_model.dart';

import '../domain/unsplash_image_model.dart';
import 'goal_repository.dart';

var goalRepoImplProvider = Provider((ref) => GoalRepoImpl());
var goalStateProvider = StateProvider<GoalModel>((ref) => GoalModel.empty());

class GoalRepoImpl extends GoalRepo {
  final Dio _dio = Dio();

  @override
  Future<List<UnsplashImageModel>> getUnsplashImageModel(
      {required String query}) async {
    try {
      Response response = await _dio.get(
        '${ApiConstants.unsplashBaseUrl}/search/photos',
        options: Options(
          headers: {
            'Authorization':
                'Client-ID ucD7aGvObHAes6TZJFtLFmdYUYrQ9HargoJF32C_y0s'
          },
        ),
        queryParameters: {
          'query': query,
          'per_page': 20,
        },
      );

      List responseList = response.data['results'] as List;
      return responseList.map((e) => UnsplashImageModel.fromJson(e)).toList();
    } on DioError catch (e) {
      throw ('Something went wrong, please try again.');
    }
  }

  @override
  Future<bool> createGoal(GoalModel goalModel) async {
    try {
      print('create goal json -> ${goalModel.toJson()}');

      Response response =
          await _dio.post(ApiConstants.createGoal, data: goalModel.toJson());

      return response.statusCode == 200;
    } on DioError catch (e) {
      print('CREATE GOAL ERROR -> ${e}');
      throw ('Something went wrong, please try again.');
    }
  }

  @override
  Future<bool> deleteGoal(String id) async {
    try {
      Response response = await _dio
          .delete('${ApiConstants.deleteGoal}/$id', data: {"active": false});

      return response.statusCode == 200;
    } on DioError catch (e) {
      throw ('Something went wrong, please try again.');
    }
  }

  @override
  Future<List<GoalModel>> getGoalList() async {
    try {
      Response response = await _dio.get(ApiConstants.getGoalList);

      print(response.data);
      List responseList = response.data;
      return responseList.map((e) => GoalModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e.toString());
      throw ('Something went wrong, please try again.');
    }
  }

  @override
  Future<GoalModel?> getSingleGoal(String id) async {
    try {
      Response response = await _dio.get('${ApiConstants.getSingleGoal}/$id');

      return GoalModel.fromJson(response.data);
    } on DioError catch (e) {
      print('GET SINGLE GOAL ERROR -> ${e}');

      throw ('Something went wrong, please try again.');
    }
  }

  @override
  Future<bool> updateGoal(GoalModel goalModel) async {
    try {
      Response response = await _dio.put(
          '${ApiConstants.updateGoal}/${goalModel.id}',
          data: goalModel.toJson());

      return response.statusCode == 200;
    } on DioError catch (e) {
      print('UPDATE GOAL ERROR -> ${e}');
      throw ('Something went wrong, please try again.');
    }
  }
}

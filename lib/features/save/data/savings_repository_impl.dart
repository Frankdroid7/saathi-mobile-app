import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/constants/api_constants.dart';
import 'package:saathi/features/save/data/savings_repository.dart';
import 'package:saathi/features/save/domain/savings_model.dart';

var savingsRepoImplProvider = Provider((ref) => SavingsRepoImpl());

class SavingsRepoImpl extends SavingsRepository {
  final Dio _dio = Dio();

  @override
  Future<bool> addSavings({required SavingsModel savingsModel}) async {
    try {
      Response response = await _dio.put(
          '${ApiConstants.addSavings}/${savingsModel.goalId}',
          data: savingsModel.toJson());

      return response.statusCode == 200;
    } on DioError catch (e) {
      throw ('Something went wrong, please try again: $e');
    }
  }

  @override
  Future<bool> withdrawSavings({required SavingsModel savingsModel}) async {
    try {
      Response response = await _dio.put(
          '${ApiConstants.withdrawSavings}/${savingsModel.goalId}',
          data: savingsModel.toJson());

      return response.statusCode == 200;
    } on DioError catch (e) {
      throw ('Something went wrong, please try again');
    }
  }

  @override
  Future<SavingsModel?> getSavings() async {
    throw UnimplementedError();
    // try {
    //   Response response = await _dio.get(ApiConstants.getSavings);
    //
    //   return SavingsModel.fromJson(response.data);
    // } on DioError catch (e) {
    //   throw ('Something went wrong, please try again');
    // }
  }
}

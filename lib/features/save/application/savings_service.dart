import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/features/goal/application/goal_service.dart';
import 'package:saathi/features/save/data/savings_repository_impl.dart';
import 'package:saathi/features/save/domain/savings_model.dart';
import 'package:saathi/utils/api_call_enum.dart';

var savingsServiceStateNotifierProvider =
    StateNotifierProvider<SavingsService, ApiCallEnum>(
        (ref) => SavingsService(ref.read(savingsRepoImplProvider), ref));

class SavingsService extends StateNotifier<ApiCallEnum>
    implements SavingsRepoImpl {
  SavingsService(this.savingsRepoImpl, this.ref) : super(ApiCallEnum.idle);
  Ref ref;
  SavingsRepoImpl savingsRepoImpl;

  @override
  Future<bool> addSavings({required SavingsModel savingsModel}) async {
    state = ApiCallEnum.loading;

    bool savingsAdded;
    try {
      savingsAdded =
          await savingsRepoImpl.addSavings(savingsModel: savingsModel);
      if (savingsAdded) {
        ref.read(goalServiceStateNotifierProvider.notifier).actionType =
            'Savings Added';
        state = ApiCallEnum.success;
      } else {
        state = ApiCallEnum.error;
      }
    } catch (e) {
      savingsAdded = false;
      state = ApiCallEnum.error;
      throw (e.toString());
    }

    return savingsAdded;
  }

  @override
  Future<SavingsModel?> getSavings() async {
    state = ApiCallEnum.loading;

    SavingsModel? savingsModel = await savingsRepoImpl.getSavings();

    if (savingsModel != null) {
      state = ApiCallEnum.success;
    } else {
      state = ApiCallEnum.error;
    }

    return savingsModel;
  }

  @override
  Future<bool> withdrawSavings({required SavingsModel savingsModel}) async {
    state = ApiCallEnum.loading;

    bool savingsWithdrawn;

    try {
      savingsWithdrawn =
          await savingsRepoImpl.withdrawSavings(savingsModel: savingsModel);
      if (savingsWithdrawn) {
        ref.read(goalServiceStateNotifierProvider.notifier).actionType =
            'Savings Withdrawn';

        state = ApiCallEnum.success;
      } else {
        state = ApiCallEnum.error;
      }
    } catch (e) {
      savingsWithdrawn = false;
      state = ApiCallEnum.error;
      throw (e.toString());
    }

    return savingsWithdrawn;
  }
}

var getSavingsFuture = FutureProvider.autoDispose((ref) async =>
    ref.read(savingsServiceStateNotifierProvider.notifier).getSavings());

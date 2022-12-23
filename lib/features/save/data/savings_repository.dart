import '../domain/savings_model.dart';

abstract class SavingsRepository {
  Future<SavingsModel?> getSavings();
  Future<bool> addSavings({required SavingsModel savingsModel});
  Future<bool> withdrawSavings({required SavingsModel savingsModel});
}

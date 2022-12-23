import '../domain/goal_model.dart';
import '../domain/unsplash_image_model.dart';

abstract class GoalRepo {
  Future<List<GoalModel>> getGoalList();
  Future<GoalModel?> getSingleGoal(String id);
  Future<bool> deleteGoal(String id);
  Future<bool> updateGoal(GoalModel goalModel);
  Future<bool> createGoal(GoalModel goalModel);
  Future<List<UnsplashImageModel>> getUnsplashImageModel(
      {required String query});
}

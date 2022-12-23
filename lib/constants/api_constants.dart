class ApiConstants {
  static const unsplashBaseUrl = 'https://api.unsplash.com/';
  static const baseUrl =
      'https://2rr84qcsei.execute-api.us-west-2.amazonaws.com';

  //Goals
  static const createGoal = '$baseUrl/goals/create';
  static const updateGoal = '$baseUrl/goals';
  static const deleteGoal = '$baseUrl/goals';
  static const getSingleGoal = '$baseUrl/goals';
  static const getGoalList = '$baseUrl/goals';

  //Savings
  static const addSavings = '$baseUrl/goals/add-savings';
  static const withdrawSavings = '$baseUrl/goals/withdraw-savings';
}

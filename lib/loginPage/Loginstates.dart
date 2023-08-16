

abstract class SoicalLoginStates{}

class IntialState extends SoicalLoginStates{}

class SoicalLoginStatesLoadingState extends SoicalLoginStates{}
class SoicalLoginStatesSuccesState extends SoicalLoginStates{
final String uId;
SoicalLoginStatesSuccesState(this.uId);
}
class SoicalLoginStatesErrorState extends SoicalLoginStates{
  final String Error;
  SoicalLoginStatesErrorState(this.Error);
}



class SoicalLoginPassVisabilityState extends SoicalLoginStates{}
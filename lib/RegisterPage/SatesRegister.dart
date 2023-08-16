



abstract class SoicalRedisterStates{}

class SoicalRegisterStatesIntialState extends SoicalRedisterStates{}

class SoicalRegisterStatesLoadingState extends SoicalRedisterStates{}

class SoicalRegisterStatesSuccesState extends SoicalRedisterStates{}

class SoicalRegisterStatesErrorState extends SoicalRedisterStates{
  final String Error;
  SoicalRegisterStatesErrorState(this.Error);
}


class SoicalCreateUserStatesSuccesState extends SoicalRedisterStates{
  final String id;
  SoicalCreateUserStatesSuccesState(this.id);
}

class SoicalCreateUserStatesErrorState extends SoicalRedisterStates{
  final String Error;
  SoicalCreateUserStatesErrorState(this.Error);
}



class SoicalRegisterPassVisabilityState extends SoicalRedisterStates{}
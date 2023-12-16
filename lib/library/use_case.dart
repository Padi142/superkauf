abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UnitUseCase<Type> {
  Future<Type> call();
}

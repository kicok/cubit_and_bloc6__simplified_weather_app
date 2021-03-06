import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCubitObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType}, $change');
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError ${cubit.runtimeType}, $error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}

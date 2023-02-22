
import 'package:cubit_movies/movie/shared/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.goHome}) : super(SplashLoading()){
    detrmineLocation();
  }
  final void Function() goHome;

  Future<void> detrmineLocation()async{
    await futureDelayed();
    goHome();
  }
}

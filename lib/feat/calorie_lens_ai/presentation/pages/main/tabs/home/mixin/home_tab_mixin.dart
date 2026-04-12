import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeTabMixin on State<HomeTab> {
  @override
  void initState() {
    super.initState();
    // Sayfa ilk açıldığında veriyi yükle
    // (Eğer MainCubit lazy:false ise buna gerek kalmayabilir ama garanti olsun)
    final cubit = context.read<MainCubit>();
    if (cubit.state is MainInitial) {
      cubit.loadMainScreenData();
    }
  }
}

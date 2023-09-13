import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domitransp/core/presentation/bloc/home_bloc.dart';
import 'package:domitransp/core/presentation/widgets/home.dart';
import 'package:domitransp/widgets/loading_animate.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is HomeLoading){
            return CustomLoadingAnimation();
          }
          return Home();
        },
      ),
    );
  }}
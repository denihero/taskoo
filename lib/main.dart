import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taskoo/app.dart';
import 'package:taskoo/bloc_observer.dart';

void main() {
  runApp(
      BlocOverrides.runZoned(() {
        return const App();
      },
        blocObserver: SimpleBlocObserver(),
      )
  );
}


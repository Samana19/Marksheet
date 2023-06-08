import '/view/result_view.dart';

import '../view/add_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Riverpod state management- module marking',
        initialRoute: '/',
        routes: {
          '/': (context) => const AddUserView(),
          '/result': (context) => const ResultView(),
        },
      ),
    ),
  );
}

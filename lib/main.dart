import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_crud_app/app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:supabase_crud_app/app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:supabase_crud_app/app/features/product/presentation/bloc/product_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wxksbaodynxbuxqozxsp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind4a3NiYW9keW54YnV4cW96eHNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg4NDUyODMsImV4cCI6MjAxNDQyMTI4M30.r3OMiGKrbL4I6rSX9L8k7Lvuq9sQ-ZWj1MMCU-eC6cw',
  );
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        )
      ],
      child: MaterialApp(
        title: 'SupaBase',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          useMaterial3: true,
        ),
        home: const DashboardPage(),
      ),
    );
  }
}

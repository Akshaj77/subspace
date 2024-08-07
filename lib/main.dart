import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:subspace/blocs/bloc/bloglist_bloc.dart';
import 'package:subspace/data/bloglist.dart';
import 'package:subspace/screens/bloglist_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  final Box<Blog> boxBlog =  await Hive.openBox<Blog>('blogs');
  runApp(MyApp(boxBlog: boxBlog,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.boxBlog});

  final Box<Blog> boxBlog;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("here");
    return BlocProvider(
      create: (context) => BloglistBloc(dio: Dio(),blogBox: boxBlog)..add(GetBlogEvent()),
      
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BlogListScreen(),
      ),
    );
    
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Home Page"),),
    );
  }
}
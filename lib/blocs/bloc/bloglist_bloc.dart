import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:subspace/constants/constant.dart';
import 'package:subspace/data/bloglist.dart';

part 'bloglist_event.dart';
part 'bloglist_state.dart';


class BloglistBloc extends Bloc<BloglistEvent, BloglistState> {
  final Dio dio;
  final Box<Blog> blogBox;
  
  BloglistBloc({required this.dio,required this.blogBox}) : super(BloglistInitial()) {
    
    on<GetBlogEvent>(_onGetBlogEvent);
    on<MarkFavouriteEvent>(_onMarkFavouriteEvent);

    
  }
  

  Future<void> _onGetBlogEvent(GetBlogEvent event, Emitter<BloglistState> emit) async {
    emit(BloglistLoading());
    try{
      if(blogBox.isNotEmpty) {
        final blogs = blogBox.values.toList();
        emit(BloglistLoaded(blogs));
      }
      else 
      {
          final data = await dio.get(
        BasicApiConstants().baseUrl,
        options: Options(
          headers: {
            "x-hasura-admin-secret": BasicApiConstants().adminSecret,
          }
        )
        
      );
  

      List<Blog> blogList = (data.data["blogs"] as List).map((e) => Blog.fromMap(e)).toList();
      await blogBox.clear(); // Clear the existing entries if needed
      await blogBox.addAll(blogList);
      emit(BloglistLoaded(blogList));
      }
      
    }
    catch(e)
    {
      emit(BloglistError(e.toString()));
    }
  }

   void _onMarkFavouriteEvent(MarkFavouriteEvent event, Emitter<BloglistState> emit) {
    if (state is BloglistLoaded) {
      final currentState = state as BloglistLoaded;
      final updatedBlogs = currentState.blogs.map((blog) {
        if (blog.id == event.blogId) {
          return blog.copyWith(isFavourite: !blog.isFavourite); 
        }
        return blog;
      }).toList();
      emit(BloglistLoaded(updatedBlogs));
    }
  }
  
 
}

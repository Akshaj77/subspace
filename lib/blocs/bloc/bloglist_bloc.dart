import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:subspace/constants/constant.dart';
import 'package:subspace/data/bloglist.dart';

part 'bloglist_event.dart';
part 'bloglist_state.dart';


class BloglistBloc extends Bloc<BloglistEvent, BloglistState> {
  final Dio dio;
  
  BloglistBloc({required this.dio}) : super(BloglistInitial()) {
    print("created");
    on<GetBlogEvent>(_onGetBlogEvent);
    on<MarkFavouriteEvent>(_onMarkFavouriteEvent);

    
  }
  

  Future<void> _onGetBlogEvent(GetBlogEvent event, Emitter<BloglistState> emit) async {
    emit(BloglistLoading());
    try{
      print(" triggered ");
      final data = await dio.get(
        BasicApiConstants().baseUrl,
        options: Options(
          headers: {
            "x-hasura-admin-secret": BasicApiConstants().adminSecret,
          }
        )
        
      );
      print(data);

      List<Blog> blogList = (data.data["blogs"] as List).map((e) => Blog.fromMap(e)).toList();
      emit(BloglistLoaded(blogList));
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
          return blog.copyWith(isFavourite: !blog.isFavourite); // Toggle favorite status
        }
        return blog;
      }).toList();
      emit(BloglistLoaded(updatedBlogs));
    }
  }
}

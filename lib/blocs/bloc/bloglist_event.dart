part of 'bloglist_bloc.dart';

@immutable
sealed class BloglistEvent extends Equatable{
  const BloglistEvent();

   @override
  List<Object> get props => [];
}

final class GetBlogEvent extends BloglistEvent {


}

final class MarkFavouriteEvent extends BloglistEvent {
  final String blogId;

 const MarkFavouriteEvent(this.blogId);
}

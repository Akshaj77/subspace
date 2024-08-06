part of 'bloglist_bloc.dart';

@immutable
sealed class BloglistState {}

final class BloglistInitial extends BloglistState {}

final class BloglistLoading extends BloglistState {}

final class BloglistLoaded extends BloglistState {
  final  List<dynamic> blogs;


 BloglistLoaded(this.blogs);
}

final class BloglistError extends BloglistState {
  final String error ;

  BloglistError(this.error);
}

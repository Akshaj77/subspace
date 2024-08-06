import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/blocs/bloc/bloglist_bloc.dart';
import 'package:subspace/screens/detailview_screen.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BloglistBloc, BloglistState>(
          builder: (context, state) {
            if (state is BloglistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BloglistLoaded) {
              if (state.blogs.isEmpty) {
                return const Center(
                    child: Text('No blogs available.', style: TextStyle(fontSize: 18)));
              }
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) {
                        return DetailBlogScreen(id: index);
                      }));
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            blog.image_url != null && blog.image_url.isNotEmpty
                                ?  ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                        blog.image_url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                                : const Text('No image available'),
                                IconButton(
                        icon: Icon(
                          blog.isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: blog.isFavourite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          context.read<BloglistBloc>().add(MarkFavouriteEvent(blog.id));
                        },
                      ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is BloglistError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.error}',
                        style: const TextStyle(fontSize: 18, color: Colors.red)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<BloglistBloc>().add(GetBlogEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

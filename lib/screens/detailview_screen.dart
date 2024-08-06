import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/blocs/bloc/bloglist_bloc.dart';

class DetailBlogScreen extends StatelessWidget {
  const DetailBlogScreen({super.key,required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: BlocBuilder<BloglistBloc,BloglistState>(
        builder: (context,state ) {
          if (state is BloglistLoading) 
          {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is BloglistLoaded)  
          {
            final blog = state.blogs[id];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  
                  children: [
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
                              const  SizedBox(height: 20.0,),
                              Text(blog.title,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )
                              ),
                ],),
              );
          }
          else 
          {
            return Center(child: CircularProgressIndicator(),);
          }
        },

      ),
    );
  }
}
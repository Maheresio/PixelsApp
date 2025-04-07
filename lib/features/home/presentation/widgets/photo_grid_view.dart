import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/app_strings.dart';
import '../controller/bloc/photo_bloc.dart';
import 'photo_girid_shimmer.dart';
import 'photo_grid_view_item.dart';

class PhotoGridView extends StatelessWidget {
  const PhotoGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is PhotoError) {
          return const Center(
            child: Text(
             AppStrings.errorNoPhotosFound,
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (state is PhotoSuccess) {
          final photos = state.filteredPhotos ?? state.photos;
          return Expanded(
            child: MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.sizeOf(context).width > 500 ? 3 : 2,
              ),
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 14.0,
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return PhotoGridViewItem(photos: photos, index: index);
              },
            ),
          );
        }

        return const PhotoGridShimmer();
      },
    );
  }
}


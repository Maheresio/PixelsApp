import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_router.dart';
import '../../../../core/app_strings.dart';
import '../../../auth/presentation/controller/auth_provider.dart';
import '../controller/bloc/photo_bloc.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController scrollController;
  late final TextEditingController searchController;
  Timer? _debounce;
  String? selectedOrientation;
  String? selectedSize;
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    searchController = TextEditingController();
    scrollController.addListener(() {
      _onScroll();
    });
    context.read<PhotoBloc>().add(const GetPhotosEvent());
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels == position.maxScrollExtent) {
      context.read<PhotoBloc>().add(const GetPhotosEvent());
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const LogoutFloatingButton(),
      body: HomeViewBody(
        scrollController: scrollController,
        searchController: searchController,
        selectedOrientation: selectedOrientation,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
        onFilterApplied: (orientation, size, color) {
          setState(() {
            selectedOrientation = orientation;
            selectedSize = size;
            selectedColor = color;
          });
        },
      ),
    );
  }
}

class LogoutFloatingButton extends ConsumerWidget {
  const LogoutFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppStrings.logoutFailed} ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        data: (user) {
          if (user == null && previous?.value != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.logoutSuccessful),
                backgroundColor: Colors.green,
              ),
            );
            GoRouter.of(context).pushReplacement(AppRouter.loginView);
          }
        },
      );
    });

    return FloatingActionButton(
      onPressed: () async {
        ref.read(authProvider.notifier).signOut();
      },
      child: const Icon(Icons.logout),
    );
  }
}

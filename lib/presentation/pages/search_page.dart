import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_util/get_place_search_cubit.dart';
import '../cubit/place_search_cubit.dart';
import '../cubit/place_search_state.dart';
import '../widgets/place_list_item.dart';
import '../widgets/search_input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlaceSearchCubit>(
      create: (context) => getPlaceSearchCubit(),
      child: SearchPageBody(),
    );
  }
}

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({Key? key}) : super(key: key);

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<PlaceSearchCubit, PlaceSearchState>(
              builder: (context, state) {
                return SearchInput(
                  controller: _searchController,
                  onChanged: (query) {
                    context.read<PlaceSearchCubit>().searchPlace(query);
                  },
                  isLoading: state is PlaceSearchLoading,
                );
              },
            ),
            Expanded(
              child: BlocBuilder<PlaceSearchCubit, PlaceSearchState>(
                builder: (context, state) {
                  if (state is PlaceSearchLoaded) {
                    return _buildLoadedState(state);
                  } else if (state is PlaceSearchError) {
                    return _buildErrorState(state);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(PlaceSearchLoaded state) {
    if (state.places.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No results found for "${state.searchQuery}"',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: state.places.length,
      itemBuilder: (context, index) {
        final place = state.places[index];
        return PlaceListItem(
          place: place,
          query: state.searchQuery,
        );
      },
    );
  }

  Widget _buildErrorState(PlaceSearchError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 30),
          const SizedBox(height: 16),
          Text(
            'Error: ${state.message}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
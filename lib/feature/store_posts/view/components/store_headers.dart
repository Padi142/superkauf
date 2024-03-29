import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/bloc/store_state.dart';

class StoreHeaders extends StatelessWidget {
  final BoxConstraints constraints;
  final Function(int) onStoreSelected;
  final int selectedStore;
  final Function(int) onStoresLoaded;

  const StoreHeaders({
    super.key,
    required this.constraints,
    required this.onStoreSelected,
    required this.selectedStore,
    required this.onStoresLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return state.maybeMap(
          success: (stores) {
            onStoresLoaded(stores.stores.length);
            return SizedBox(
              height: 50,
              width: constraints.maxWidth,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stores.stores.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          onStoreSelected(stores.stores[index].id);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: selectedStore == stores.stores[index].id ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(stores.stores[index].name,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: selectedStore == stores.stores[index].id ? Colors.white : Colors.black,
                                      )),
                            )),
                      ),
                    );
                  }),
            );
          },
          error: (error) {
            return Text(error.error);
          },
          orElse: () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      5,
                      (index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: CardLoading(height: 30, width: 70, borderRadius: BorderRadius.all(Radius.circular(10))),
                          ))),
            ),
          ),
        );
      },
    );
  }
}

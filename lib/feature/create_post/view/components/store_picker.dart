import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/library/app.dart';

class StoreCarousel extends StatefulWidget {
  final List<StoreModel> stores;
  final Function(StoreModel) onStoreSelected;
  final double height;
  final PanelController panelController;

  const StoreCarousel({
    Key? key,
    required this.stores,
    required this.onStoreSelected,
    required this.height,
    required this.panelController,
  }) : super(key: key);

  @override
  State<StoreCarousel> createState() => _StoreCarouselState();
}

class _StoreCarouselState extends State<StoreCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: widget.height,
        viewportFraction: 0.6,
        showIndicator: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          widget.onStoreSelected(widget.stores[index]);
        },
        slideIndicator: CircularSlideIndicator(),
      ),
      items: widget.stores.map((store) => _buildStoreCard(store)).toList(),
    );
  }

  Widget _buildStoreCard(StoreModel store) {
    return GestureDetector(
      onTap: () {
        widget.onStoreSelected(store);
        widget.panelController.close();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.0,
              blurRadius: 3.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store.name,
                style: App.appTheme.textTheme.titleLarge,
              ),
              const SizedBox(height: 5.0),
              Center(
                  child: Image.network(
                store.image,
                height: widget.height * 0.6,
                fit: BoxFit.contain,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

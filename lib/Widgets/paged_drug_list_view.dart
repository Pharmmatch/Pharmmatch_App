import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmmatch_app/models/drug_info.dart';
import 'package:pharmmatch_app/Widgets/drug_container.dart';
import 'package:pharmmatch_app/const/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PagedDrugListView extends StatefulWidget {
  const PagedDrugListView({
    required this.inputText,
    super.key,
  });

  final String inputText;

  @override
  State<PagedDrugListView> createState() => _PagedDrugListViewState();
}

class _PagedDrugListViewState extends State<PagedDrugListView> {
  final PagingController<int, DrugInfo> _pagingController =
      PagingController(firstPageKey: 0);
  List<DrugInfo> _filteredDrugs = [];
  static const _pageSize = 20;
  bool _isLoading = false;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PagedDrugListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputText != widget.inputText) {
      _filterDrugs(widget.inputText);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _filterDrugs(String searchQuery) async {
    setState(() {
      _isLoading = true;
      _filteredDrugs = [];
      _pagingController.itemList = [];
    });

    if (searchQuery.isEmpty) {
      setState(() {
        _isLoading = false;
      });
    } else {
      final response = await http
          .get(Uri.parse('$localUrl/search_kordrug?query=$searchQuery'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<DrugInfo> filteredDrugs =
            jsonResponse.map((json) => DrugInfo.fromJson(json)).toList();

        setState(() {
          _filteredDrugs = filteredDrugs;
          _isLoading = false;
        });

        _pagingController.refresh();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final startIndex = pageKey * _pageSize;
      final endIndex = startIndex + _pageSize;
      if (startIndex < _filteredDrugs.length) {
        final drugsForPage = _filteredDrugs.sublist(
            startIndex,
            endIndex > _filteredDrugs.length
                ? _filteredDrugs.length
                : endIndex);
        _pagingController.appendPage(drugsForPage, pageKey + 1);
      } else {
        _pagingController.appendLastPage([]);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : PagedListView<int, DrugInfo>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<DrugInfo>(
              itemBuilder: (context, item, index) => Padding(
                padding: const EdgeInsets.all(15),
                child: DrugContainer(drug: item),
              ),
            ),
          );
  }
}

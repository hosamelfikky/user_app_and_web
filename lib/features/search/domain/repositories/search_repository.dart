import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/api_client.dart';
import '../../../../util/app_constants.dart';
import '../../../item/domain/models/item_model.dart';
import '../models/popular_categories_model.dart';
import '../models/search_suggestion_model.dart';
import 'search_repository_interface.dart';

class SearchRepository implements SearchRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.searchHistory, searchHistories);
  }

  @override
  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.searchHistory) ?? [];
  }

  @override
  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.searchHistory, []);
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset, String? query, bool? isStore, bool isSuggestedItems = false}) async {
    if (isSuggestedItems) {
      return await _getSuggestedItems();
    } else {
      return await _getSearchData(query, isStore!);
    }
  }

  Future<List<Item>?> _getSuggestedItems() async {
    List<Item>? suggestedItemList;
    Response response = await apiClient.getData(AppConstants.suggestedItemUri);
    if (response.statusCode == 200) {
      suggestedItemList = [];
      response.body.forEach((suggestedItem) => suggestedItemList!.add(Item.fromJson(suggestedItem)));
    }
    return suggestedItemList;
  }

  Future<Response> _getSearchData(String? query, bool isStore) async {
    return await apiClient.getData('${AppConstants.searchUri}${isStore ? 'stores' : 'items'}/search?name=$query&offset=1&limit=50');
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }

  @override
  Future<SearchSuggestionModel?> getSearchSuggestions(String searchText) async {
    SearchSuggestionModel? searchSuggestionModel;
    Response response = await apiClient.getData('${AppConstants.searchSuggestionsUri}?name=$searchText');
    if (response.statusCode == 200) {
      searchSuggestionModel = SearchSuggestionModel.fromJson(response.body);
    }
    return searchSuggestionModel;
  }

  @override
  Future<List<PopularCategoryModel?>?> getPopularCategories() async {
    List<PopularCategoryModel?>? popularCategoryList;
    Response response = await apiClient.getData(AppConstants.searchPopularCategoriesUri);
    if (response.statusCode == 200) {
      popularCategoryList = [];
      response.body.forEach((category) {
        popularCategoryList!.add(PopularCategoryModel.fromJson(category));
      });
    }
    return popularCategoryList;
  }
}

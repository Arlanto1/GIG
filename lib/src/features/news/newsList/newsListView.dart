import 'dart:convert';
import 'dart:developer';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/news/model/location_model.dart';
import 'package:db_atom/src/features/news/model/news_model.dart';
import 'package:db_atom/src/features/news/services/news_service.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsApp> {
  int selectedTab = 0;
  String selectedLocation = '';

  final NewsService service = NewsService();
  final tabs = [
    "general",
    "politics",
    "business",
    "sports",
    "traffic",
    "weather"
  ];

  List<Map<String, dynamic>> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
    setState(() => isLoading = true);
    String category = tabs[selectedTab];

    try {
      NewApp data;
      if (selectedLocation.isEmpty) {
        // No location selected → call base news1 API
        data = await service.fetchNews(
          category: category,
          location: '', // or your service can detect empty location
        );
      } else {
        // Location selected → call API with location
        data = await service.fetchNews(
          category: category,
          location: selectedLocation,
        );
      }

      newsList = data.news
          ?.map((e) => {
        "id": e.id,
        "title": e.title,
        "image": e.imageUrl,
        "url": e.url,
        "source": {"name": e.sourceName},
        "time": e.publishedAt,
        "tag": "",
      })
          .toList() ??
          [];

      log("Fetched: ${newsList.length} for location: $selectedLocation");
    } catch (e) {
      log("ERROR: $e");
      newsList = [];
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("ATOM Bulletin"),
          backgroundColor: Colors.white,
          iconTheme: null,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                dashboardViewRoute, // 🔁 your dashboard route
                    (route) => false,
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LocationSelector(
                onLocationSelected: (stateName) {
                  setState(() {
                    selectedLocation = stateName;
                    loadNews(); // Call API again when location changes
                  });
                },
              ),
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // --------------------------
          // CATEGORY TABS
          // --------------------------
          SizedBox(
            height: 45,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedTab == index;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedTab = index);
                      loadNews(); // reload news for new category
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(27),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.6),
                          width: 0.9,
                        ),
                      ),
                      child: Text(
                        tabs[index].toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          // --------------------------
          // NEWS LIST
          // --------------------------
          Expanded(
            child: isLoading
                ? const Center(
                child: CircularProgressIndicator(color: Colors.white))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final item = newsList[index];

                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      // OPEN WEBVIEW WHEN NEWS ITEM IS CLICKED
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewPage(url: item["url"]),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        bigNewsCard(item),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _logout(BuildContext context) {
    var dialog = CustomAlertDialog(
      title: Constants.logout,
      message: Constants.logoutValidation,
      onPositivePressed: () {
        CommonServices().unlock();
        Validator.logoutAction(context);
      },
      positiveBtnText: Constants.yes,
      negativeBtnText: Constants.no,
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Widget bigNewsCard(Map<String, dynamic> item) {
    final String image = item["image"] ?? "";
    final String title = item["title"] ?? "";
    final String source = item["source"]?["name"] ?? "";
    final String time = item["time"] ?? "";

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              // Colors.white.withValues(alpha: 0.4),
              Colors.white,
              Colors.white,
              Colors.white,

              // Colors.white.withValues(alpha: 0.4),
            ],
            stops: [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.25),
            width: 0.8,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT IMAGE
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(12),
            //   child: Image.network(
            //     image.isNotEmpty ? image : "https://via.placeholder.com/150",
            //     width: 120,
            //     height: 120,
            //     fit: BoxFit.cover,
            //     errorBuilder: (_, __, ___) => Container(
            //       width: 120,
            //       height: 120,
            //       color: Colors.grey.shade800,
            //       child: const Icon(Icons.broken_image, color: Colors.white),
            //     ),
            //   ),
            // ),

            // SHOW IMAGE ONLY IF NOT EMPTY
            if (image.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(), // no error image
                ),
              ),
              const SizedBox(width: 12),
            ],
            const SizedBox(width: 16),

            // RIGHT TEXT CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // TITLE
                  Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.public,
                              size: 14, color: Colors.black),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              source,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // TIME BELOW
                      // Text(
                      //   time.isNotEmpty ? time.substring(0, 10) : "",
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 13,
                      //   ),
                      // ),
                      Row(
                        children: [
                          const Icon(Icons.access_time_filled,
                              size: 14, color: Colors.black),
                          const SizedBox(width: 5),
                          Text(
                            time.isNotEmpty ? time.substring(0, 10) : "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          title: const Text("ATOM Bulletin"),
          backgroundColor: Colors.white,
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}


class LocationSelector extends StatefulWidget {
  final Function(String stateName) onLocationSelected;

  const LocationSelector({super.key, required this.onLocationSelected});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  List<States> statesList = [];
  States? selectedState;

  @override
  void initState() {
    super.initState();
    loadLocations();
  }

  Future<void> loadLocations() async {
    try {
      final response = await http.get(
        Uri.parse('https://india-location-hub.in/api/locations/states'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final locationModel = LocationModel.fromJson(jsonResponse);

        setState(() {
          statesList = locationModel.data?.states ?? [];
        });
      }
    } catch (e) {
      log("Error loading locations: $e");
    }
  }

  void showLocationSheet() {
    if (statesList.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: statesList.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final state = statesList[index];
            final isSelected = selectedState?.name == state.name;

            return ListTile(
              title: Text(state.name ?? ""),
              trailing: isSelected
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() {
                  selectedState = state;
                });
                widget.onLocationSelected(state.name ?? "");
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showLocationSheet,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 160),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  selectedState?.name ?? "Select Location",
                  style: TextStyle(
                    color: selectedState == null
                        ? Colors.grey.shade500
                        : Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

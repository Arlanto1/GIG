// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/news/services/news_service.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class NewsApp extends StatefulWidget {
//   const NewsApp({super.key});
//
//   @override
//   State<NewsApp> createState() => _NewsHomePageState();
// }
//
// class _NewsHomePageState extends State<NewsApp> {
//   int selectedTab = 0;
//
//   late Future<List<dynamic>> newsFuture;
//
//   final NewsService service = NewsService();
//   // NewsAPI top categories
//   final tabs = ["general", "politics", "business", "sports"];
//
//   List<Map<String, dynamic>> newsList = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadNews();
//
//   }
//
//   // Load data from API
//   Future<void> loadNews() async {
//     setState(() => isLoading = true);
//
//     try {
//       newsList = await NewsService().fetchTopHeadlines(category: "General");
//       log('Fetched headlines (${newsList.length})');
//     } catch (e) {
//       log('Fetched Exception: $e');
//       newsList = [];
//     }
//
//     setState(() => isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(56),
//         child: BaseAppBar().buildAppHeader(
//           context: context,
//           title: 'News',
//           showPopUp: false,
//           showSaveButton: false,
//           showSubmitButton: false,
//           showDisLikeButton: false,
//           showLikeButton: false,
//         ),
//       ),
//
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//
//           // --------------------------
//           // CATEGORY TABS
//           // --------------------------
//           SizedBox(
//             height: 45,
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               scrollDirection: Axis.horizontal,
//               itemCount: tabs.length,
//               itemBuilder: (context, index) {
//                 bool isSelected = selectedTab == index;
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigate to the details page for this tab/category
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => WebViewPage(url: item["url"]),
//                             ),
//                           );
//                         },
//                         child: const Text("Open Website"),
//                       )
//
//                     },
//
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 22, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.black.withValues(alpha: 0.22),
//                         borderRadius: BorderRadius.circular(27),
//                         border: Border.all(
//                           color: Colors.white.withValues(alpha: 0.2),
//                           width: 0.6,
//                         ),
//                       ),
//                       child: Text(
//                         tabs[index].toUpperCase(),
//                         style: TextStyle(
//                           color: isSelected ? Colors.black : Colors.white,
//                           fontSize: 16,
//                           fontWeight:
//                           isSelected ? FontWeight.w600 : FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           const SizedBox(height: 15),
//
//           // --------------------------
//           // LIST OF NEWS CARDS
//           // --------------------------
//           Expanded(
//             child: isLoading
//                 ? const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             )
//                 : ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               itemCount: newsList.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     bigNewsCard(newsList[index]),
//                     const SizedBox(height: 16),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 🔥 BIG NEWS CARD — FIXED WITH NULL-SAFE VALUES
//   Widget bigNewsCard(Map<String, dynamic> item) {
//     final String image = item["image"] ?? "";
//     final String title = item["title"] ?? "";
//     final String tag = item["tag"] ?? "";
//     final String source = item["source"] ?? "";
//     final String time = item["time"] ?? "";
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.black.withValues(alpha: 0.4),
//               Colors.transparent,
//               Colors.black.withValues(alpha: 0.4),
//             ],
//             stops: const [0.02, 0.35, 1],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(27),
//           border: Border.all(
//             color: Colors.white.withValues(alpha: 0.25),
//             width: 0.8,
//           ),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // LEFT IMAGE
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 image.isNotEmpty
//                     ? image
//                     : "https://via.placeholder.com/150",
//                 width: 120,
//                 height: 120,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   width: 120,
//                   height: 120,
//                   color: Colors.grey.shade800,
//                   child: const Icon(Icons.broken_image, color: Colors.white),
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // RIGHT TEXT CONTENT
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // TAG
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.08),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Text(
//                       tag,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.white70,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // TITLE
//                   Text(
//                     title,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // SOURCE + TIME
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.public,
//                               size: 14, color: Colors.grey),
//                           const SizedBox(width: 5),
//                           Text(
//                             source,
//                             style: TextStyle(
//                               color: Colors.grey.shade300,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         time.isNotEmpty
//                             ? time.substring(0, 10)
//                             : "",
//                         style: TextStyle(
//                           color: Colors.grey.shade400,
//                           fontSize: 13,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class WebViewPage extends StatelessWidget {
//   final String url;
//
//   const WebViewPage({super.key, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(url));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Article"),
//       ),
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }

import 'dart:developer';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/news/services/news_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsApp> {
  int selectedTab = 0;

  final NewsService service = NewsService();
  final tabs = ["general", "politics", "business", "sports"];

  List<Map<String, dynamic>> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  // Load news by category
  Future<void> loadNews() async {
    setState(() => isLoading = true);

    try {
      String category = tabs[selectedTab]; // dynamic category
      newsList = await service.fetchTopHeadlines(category: category);
      log("Fetched: ${newsList.length}");
    } catch (e) {
      log("Error: $e");
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
        child: BaseAppBar().buildAppHeader(
          context: context,
          title: 'News',
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
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
                            : Colors.black.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(27),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.6,
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
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final item = newsList[index];

                return GestureDetector(
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
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 BIG NEWS CARD WITH IMAGE + TITLE
  Widget bigNewsCard(Map<String, dynamic> item) {
    final String image = item["urlToImage"] ?? "";
    final String title = item["title"] ?? "";
    final String source = item["source"]?["name"] ?? "";
    final String time = item["publishedAt"] ?? "";

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha: 0.4),
              Colors.transparent,
              Colors.black.withValues(alpha: 0.4),
            ],
            stops: const [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 0.8,
          ),
        ),
        padding: const EdgeInsets.all(12),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image.isNotEmpty
                    ? image
                    : "",
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
            ),
            // TEXT RIGHT SIDE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // SOURCE & TIME
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        source,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        time.isNotEmpty ? time.substring(0, 10) : "",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
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

// ----------------------------
// WEBVIEW PAGE
// ----------------------------
class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Article"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

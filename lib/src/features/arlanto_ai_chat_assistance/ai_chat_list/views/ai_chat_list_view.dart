import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/ai_chat_details/views/ai_chat_details_view.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/ai_chat_list/bloc/ai_chat_list_bloc.dart';


class AiChatListView extends StatefulWidget {
  const AiChatListView({super.key});

  @override
  State<AiChatListView> createState() => _AiChatListViewState();
}

class _AiChatListViewState extends State<AiChatListView> {
  @override
  void initState() {
    super.initState();
    /// FIRST LOAD
    context.read<AiChatListBloc>().add(FetchAIData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiChatListBloc, AIChatListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppHeader(
            isTitleCenter: true,
            title: "ATOM AI Chat Assistance",
            backgroundColour: const Color(0xFF0C001C),
            backBtn: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
            ),
          ),
          floatingActionButton: Flutterfloatingbutton(
            backgroundColor: AppColors.navigationSkyBlueColor,
            foregroundColor: AppColors.backgroundWhiteColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>   const AiChatDetailsView(),
                ),
              );
            },
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0C001C), Color(0xFF0C001C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: state.status == FormStatus.loading
                ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00FFF7),
              ),
            )
                : state.items.isEmpty
                ? const Center(
              child: Text(
                "No Records Found.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                const Color mainNeon = Color(0xFF00FFF7);
                List<Label> labels = [
                          Label(
                            key: Constants.createdby,
                            value: item.createdBy ?? "",
                          ),
                        ];
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    // Item tap action
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          mainNeon.withOpacity(0.18),
                          Colors.transparent,
                          mainNeon.withOpacity(0.14)
                        ],
                        stops: const [0.02, 0.35, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(27),
                      border: Border.all(
                        color: mainNeon.withOpacity(0.30),
                        width: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: mainNeon.withOpacity(0.09),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BaseListTileItem(
                      id: item.id,
                      labels: labels,
                      onTap: (selectedIndex) {
                        showDialog(
                          context: context,
                          builder: (_) => BasePopUpItems(
                            id: item.id.toString(),
                            labels: labels,
                          ),
                        );
                      },
                      onEditTap: (selectedIndex) {

                      },
                      showEditButton: true,
                      onViewTap: (selectedIndex) {
                        showDialog(
                          context: context,
                          builder: (_) => BasePopUpItems(
                            id: item.id.toString(),
                            labels: labels,
                            isEventProtectionStatus: false,
                            isLawEnforcementStatus: true,
                            isMasterGuard: false,
                          ),
                        );
                      },
                      index: index,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

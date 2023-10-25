import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/date_time_picker.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_cubit.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/create_found_submit_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/network_handler.dart' as network_handler;
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/app_button.dart';
import '../../../models/base_user.dart';
import '../../../models/organisation.dart';
import '../models/user.dart';

class CreateFound extends StatefulWidget {
  final FoundListArticleDetails? listuser;
  final int? eventId;

  const CreateFound({super.key, this.listuser, this.eventId});

  @override
  State<CreateFound> createState() => _CreateFoundState();
}

class _CreateFoundState extends State<CreateFound> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = '';
  String serialNumber = '';

  // Group Value for Radio Button.
  int isDepositorDBEmployeeSelected = 1;
  int isClaimantDBEmployeeSelected = 1;
  int isClaimantAcceptedtoSignSelected = 0;
  int isClaimantAcceptedByemail = 1;
  final GlobalKey<FormState> createfoundFormKey = GlobalKey<FormState>();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController colorTextController = TextEditingController();
  TextEditingController foundLocationTextController = TextEditingController();
  TextEditingController depositorEmpIdTextController = TextEditingController();
  TextEditingController claimantEmpIdTextController = TextEditingController();
  TextEditingController additionalinformationTextController =
      TextEditingController();
  TextEditingController claimantsignatureTextController =
      TextEditingController();
  TextEditingController founddateTextController = TextEditingController();
  TextEditingController handedoverdatedateTextController =
      TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();
  TextEditingController assettypeTextController = TextEditingController();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController depositorTextController = TextEditingController();
  TextEditingController claimantTextController = TextEditingController();
  String isDepositorDBEmployee = "";

  // String slnoValue = "dfwe";
  String createdByValue = "";
  String itemhandoverByValue = "";
  String locationselectedText = "";
  Organisation? selectedEmployeedepartment;
  Organisation? selectedClaimdepartment;
  String claimantDepartmentName = '';
  String claimant = '';
  ArticleList? selectedArtclelist;
  BaseUser? selecteddepositorList;
  BaseUser? selectedClaimList;
  User? userDetails;
  Organisation? locationSelectedlist;
  SubmitCreateFoundModel? createfoundResponse;
  SerialNumberModel? serialnumberResponse;
  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;

  @override
  void initState() {
    super.initState();
    if (widget.listuser != null) {
      editCreatefoundItems();
    }
    _getFoundArticleList();
    _getCurrentDate();
  }

  editCreatefoundItems() async {
    if (widget.listuser != null) {
      await SharedPrefs.setFoundId(widget.listuser?.id ?? 0);
      selecteddepositorList = widget.listuser?.depositor != null
          ? BaseUser(
              email: widget.listuser?.depositor?.email ?? "",
              id: widget.listuser?.depositor?.userId ?? 0,
              name: widget.listuser?.depositor?.name ?? "")
          : BaseUser();
      selectedArtclelist = widget.listuser?.typeOfArticle != null
          ? ArticleList(
              id: widget.listuser?.typeOfArticle?.id ?? 1,
              name: widget.listuser?.typeOfArticle?.name ?? "")
          : ArticleList();
      userDetails = widget.listuser?.entrySecurity != null
          ? User(
              userId: widget.listuser?.entrySecurity?.userId ?? 1,
              lastName: widget.listuser?.entrySecurity?.lastName ?? "")
          : User();
      createdByValue = userDetails?.name != null ? userDetails?.name ?? '' : '';
      serialNumber =
          widget.listuser?.slNo != null ? widget.listuser?.slNo ?? "" : '';
      locationSelectedlist = widget.listuser?.location != null
          ? Organisation(
              id: widget.listuser?.location?.id ?? 0,
              name: widget.listuser?.location?.name ?? "")
          : Organisation();
      locationselectedText = locationSelectedlist?.name != null
          ? locationSelectedlist?.name ?? ""
          : '';
      quantityTextController.text = widget.listuser?.quantity != null
          ? widget.listuser?.quantity.toString() ?? ""
          : '';
      colorTextController.text = widget.listuser?.color != null
          ? widget.listuser?.color.toString() ?? ""
          : '';
      foundLocationTextController.text = widget.listuser?.foundLocation != null
          ? widget.listuser?.foundLocation.toString() ?? ""
          : '';
      additionalinformationTextController.text =
          widget.listuser?.additionalInformation != null
              ? widget.listuser?.additionalInformation.toString() ?? ""
              : '';
      founddateTextController.text = widget.listuser?.foundDate != null
          ? Utils.timestamptoDateConversion(
              int.parse(widget.listuser?.foundDate ?? '0'),
              Constants.fulldateFormat)
          : '';
      dateofcreationTextController.text = widget.listuser?.inputDate != null
          ? Utils.timestamptoDateConversion(
              int.parse(widget.listuser?.inputDate ?? '0'),
              Constants.fulldateFormat)
          : '';
      assettypeTextController.text = widget.listuser?.typeOfAsset != null
          ? (widget.listuser?.typeOfAsset == 0 ? "Personal" : "Company")
          : '';
      statusTextController.text = widget.listuser?.status == 0
          ? "Found"
          : widget.listuser?.status == 1
              ? "Under Security Custody"
              : "Handover";
      depositorTextController.text = widget.listuser?.depositorName != null
          ? widget.listuser?.depositorName ?? ""
          : '';
      isDepositorDBEmployeeSelected =
          ((widget.listuser?.depositorDbEmp ?? false) == true) ? 1 : 0;
      isClaimantAcceptedtoSignSelected =
          ((widget.listuser?.claimantNoSign ?? false) == true) ? 1 : 0;
      isClaimantAcceptedByemail =
          ((widget.listuser?.claimantConfirmByEmail ?? false) == true) ? 1 : 0;
      isClaimantDBEmployeeSelected =
          ((widget.listuser?.claimantDbEmp ?? false) == true) ? 1 : 0;
      depositorEmpIdTextController.text = widget.listuser?.employeeId != null
          ? widget.listuser?.employeeId ?? ''
          : '';
      selectedEmployeedepartment = widget.listuser?.depositorDepartment != null
          ? Organisation(
              id: widget.listuser?.depositorDepartment?.id ?? 0,
              name: widget.listuser?.depositorDepartment?.name ?? '')
          : Organisation();
      getAttachments =
          widget.listuser?.images != null ? widget.listuser?.images ?? [] : [];
      claimantDepartmentName = widget.listuser?.claimantDepartmentName != null
          ? widget.listuser?.claimantDepartmentName ?? ''
          : '';
      itemhandoverByValue = widget.listuser?.handOverSecurityName ?? '';
      handedoverdatedateTextController.text =
          widget.listuser?.handoverDate != null
              ? Utils.timestamptoDateConversion(
                  int.parse(widget.listuser?.handoverDate ?? '0'),
                  Constants.fulldateFormat)
              : handedoverdatedateTextController.text.isEmpty
                  ? ''
                  : handedoverdatedateTextController.text;
      claimantEmpIdTextController.text =
          widget.listuser?.claimantEmployeeId != null
              ? widget.listuser?.claimantEmployeeId ?? ''
              : '';
      claimant = widget.listuser?.claimant?.lastName != null
          ? widget.listuser?.claimant?.lastName ?? ''
          : '';
      claimantTextController.text = widget.listuser?.claimant?.lastName != null
          ? widget.listuser?.claimant?.lastName ?? ''
          : '';
      selectedClaimdepartment = widget.listuser?.claimantDepartment != null
          ? Organisation(
              id: widget.listuser?.claimantDepartment?.id ?? 0,
              name: widget.listuser?.claimantDepartment?.name ?? '')
          : Organisation();
      selectedClaimList = widget.listuser?.claimant != null
          ? BaseUser(
              email: widget.listuser?.claimant?.email ?? "",
              id: widget.listuser?.claimant?.userId ?? 0,
              name: widget.listuser?.claimant?.lastName ?? "")
          : BaseUser();
    }
  }

  createFoundBody(bool isSubmit, int isFoundId) async {
    bool isDepositorDBEmployeeSelectedvalue =
        isDepositorDBEmployeeSelected == 1 ? true : false;
    int statusvalue = 0;
    if (statusTextController.text.toLowerCase() == "found") {
      statusvalue = 0;
    } else if (statusTextController.text.toLowerCase() ==
        "under security custody") {
      statusvalue = 0;
    } else {
      statusvalue = 2;
    }

    int founddate = Utils.datetoTimestampConversion(
        founddateTextController.text, Constants.fulldateFormat);
    int inputdate = Utils.datetoTimestampConversion(
        dateofcreationTextController.text, Constants.fulldateFormat);
    Map<String, dynamic> entrySecurityBody = {
      "userId": userDetails?.userId ?? 0,
    };
    Map<String, dynamic> locationBody = {
      "id": locationSelectedlist?.id ?? 0,
      "name": locationSelectedlist?.name ?? ''
    };
    Map<String, dynamic> depositorBody = {
      "userId": selecteddepositorList?.id ?? 1,
      "userName": selecteddepositorList?.name ?? '',
      "email": selecteddepositorList?.email ?? '',
    };
    Map<String, dynamic> articleBody = {
      "id": selectedArtclelist?.id ?? 0,
    };
    Map<String, dynamic> depositorDeptBody = {
      "id": selectedEmployeedepartment?.id ?? 1,
    };
    Map<String, dynamic> foundBody = {
      "status": statusvalue,
      "typeOfAsset":
          (assettypeTextController.text.toLowerCase()) == 'company' ? 1 : 0,
      "color":
          colorTextController.text.length > 0 ? colorTextController.text : '',
      "slNo": serialNumber,
      "typeOfArticle": articleBody,
      "entrySecurity": entrySecurityBody,
      "foundLocation": foundLocationTextController.text,
      "quantity": quantityTextController.text.length > 0
          ? int.parse(quantityTextController.text)
          : 0,
      "additionalInformation": additionalinformationTextController.text,
      "depositorDbEmp": isDepositorDBEmployeeSelectedvalue,
      "inputDate": inputdate,
      "foundDate": founddate,
      "location": locationBody,
      "depositorName": isDepositorDBEmployeeSelected == 1
          ? selecteddepositorList?.name ?? ''
          : depositorTextController.text.length > 0
              ? depositorTextController.text
              : '',
      "employeeId": depositorEmpIdTextController.text.length > 0
          ? depositorEmpIdTextController.text
          : '',
      "depositorDepartment": depositorDeptBody,
      "depositor": depositorBody,
      "eventProtection": widget.eventId,
      "images": getFiles ?? []
    };
    Map<String, dynamic> requestBody = {
      "found": foundBody,
    };
    var username = await SharedPrefs.getUsername();
    showLoadingDialog(context);
    await createFoundArticleCubit.createFoundArticleHandle(
        requestBody,
        isSubmit,
        context,
        username,
        widget.listuser != null ? Constants.editfound : Constants.createfound);
  }

  Future createNewuserBody(bool isSubmit, int isFoundId) async {
    int founddate = Utils.datetoTimestampConversion(
        founddateTextController.text, Constants.fulldateFormat);
    int inputdate = Utils.datetoTimestampConversion(
        dateofcreationTextController.text, Constants.fulldateFormat);
    int handoverdate = Utils.datetoTimestampConversion(
        handedoverdatedateTextController.text, Constants.fulldateFormat);
    var username = await SharedPrefs.getUsername();
    bool isDepositorDBEmployeeSelectedvalue =
        isDepositorDBEmployeeSelected == 1 ? true : false;
    bool isClaimDBEmployeeSelectedvalue = false;
    bool isClaimSignSelectedvalue =
        isClaimantAcceptedtoSignSelected == 1 ? true : false;
    bool isClaimantselectedByemail =
        isClaimantAcceptedByemail == 1 ? true : false;
    TypeOfArticle? typeOfArticle =
        TypeOfArticle(id: selectedArtclelist?.id ?? 1);
    User? entrysecurtity = User(userId: userDetails?.userId ?? 1);
    Depositor? depositor = Depositor(userId: selecteddepositorList?.id ?? 1);
    CreateLocation? location =
        CreateLocation(id: locationSelectedlist?.id ?? 1);
    DepositorDepartment? depositordep =
        DepositorDepartment(id: selectedEmployeedepartment?.id ?? 1);
    List<CreateImage>? images = getFiles ?? [];
    CreateClaimantDepartment? createclaimantDepartment =
        CreateClaimantDepartment(
            id: widget.listuser?.claimantDepartment?.id ?? 1,
            name: widget.listuser?.claimantDepartment?.name ?? '');
    CreateClaimant? claimant = CreateClaimant(
        userId: widget.listuser?.claimant?.userId ?? 1,
        userName: widget.listuser?.claimant?.userName ?? '',
        email: widget.listuser?.claimant?.email ?? '',
        lastName: widget.listuser?.claimant?.lastName ?? '',
        firstName: widget.listuser?.claimant?.firstName ?? '');
    CreateHandoverSecurity? createhandover =
        CreateHandoverSecurity(userId: widget.listuser?.claimant?.userId ?? 1);
    int statusvalue = 0;
    if (statusTextController.text.toLowerCase() == "found") {
      statusvalue = 0;
    } else if (statusTextController.text.toLowerCase() ==
        "under security custody") {
      statusvalue = 0;
    } else {
      statusvalue = 2;
    }
    Found? found = Found(
        claimantConfirmByEmail: isClaimantselectedByemail,
        id: widget.listuser?.id,
        claimantDepartment: createclaimantDepartment,
        claimant: claimant,
        claimantDbEmp: isClaimDBEmployeeSelectedvalue,
        claimantNoSign: isClaimSignSelectedvalue,
        handoverSecurity: createhandover,
        handoverDate: handoverdate,
        claimantEmployeeId: claimantEmpIdTextController.text.isEmpty
            ? 0
            : int.parse(claimantEmpIdTextController.text),
        slNo: serialNumber,
        images: images,
        typeOfAsset:
            (assettypeTextController.text.toLowerCase()) == 'company' ? 1 : 0,
        typeOfArticle: typeOfArticle,
        foundLocation: foundLocationTextController.text.length > 0
            ? foundLocationTextController.text
            : '',
        additionalInformation:
            additionalinformationTextController.text.length > 0
                ? additionalinformationTextController.text
                : '',
        quantity: quantityTextController.text.length > 0
            ? int.parse(quantityTextController.text)
            : 0,
        color:
            colorTextController.text.length > 0 ? colorTextController.text : '',
        status: statusvalue,
        depositorDbEmp: isDepositorDBEmployeeSelectedvalue,
        inputDate: inputdate,
        foundDate: founddate,
        entrySecurity: entrysecurtity,
        location: location,
        depositorName: isDepositorDBEmployeeSelected == 1
            ? selecteddepositorList?.name ?? ''
            : depositorTextController.text.length > 0
                ? depositorTextController.text
                : '',
        depositor: depositor,
        depositorDepartment: depositordep,
        employeeId: depositorEmpIdTextController.text.length > 0
            ? depositorEmpIdTextController.text
            : '');
    found.eventProtection = widget.eventId;
    CreateFoundRequestBody requestBody = CreateFoundRequestBody(found: found);
    showLoadingDialog(context);
    await createFoundArticleCubit.createNewFoundArticle(
      requestBody,
      isSubmit,
      context,
      username,
      widget.listuser != null ? Constants.editfound : Constants.createfound,
    );
  }

  void _getFoundArticleList() async {
    var userid = await SharedPrefs.getUserId();
    final bool isActive = await network_handler.networkChecking(context);
    if (isActive) {
      await createFoundArticleCubit.getUserByRoleDepositor(
          'ATOM_STATIC_USER', context);
      await createFoundArticleCubit.getLocations('ATOM_LOCATIONS', context);
      await createFoundArticleCubit.getEmployeeDepartments(
          'EMPLOYEE_DEPARTMENTS', context);
      await createFoundArticleCubit.getArticleType('ARTICLE_LIST', context);
      if (widget.listuser == null) {
        await createFoundArticleCubit.getUserDetails(userid, context);
      }
    } else {
      Utils.showAlertMessage("No Network connection", context);
    }
  }

  void _getCurrentDate() {
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(DateTime.now());
    print(
        formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement
    dateofcreationTextController.text = formattedDate;
    statusTextController.text = 'Found';
    handedoverdatedateTextController.text = formattedDate;
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  _createFoundAlert(BuildContext context, String messgae) {
    var dialog = CustomAlertDialog(
        title: 'Create Found',
        message: messgae,
        onPostivePressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: '');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  // createdraftValidations(BuildContext context) {
  //   if ((locationSelectedlist?.name ?? "").isEmpty) {
  //     Validator().showToast(
  //       context,
  //       "Please enter location",
  //     );
  //   } else if ((selectedArtclelist?.name ?? "").isEmpty) {
  //     Validator().showToast(
  //       context,
  //       "Please enter article name",
  //     );
  //   } else if (isDepositorDBEmployeeSelected == 0 &&
  //       depositorTextController.text.isEmpty) {
  //     Validator().showToast(context, "Please enter depositor");
  //   } else if (isDepositorDBEmployeeSelected == 1 &&
  //       (((selecteddepositorList?.name ?? "").isEmpty) ||
  //           (depositorEmpIdTextController.text.isEmpty) ||
  //           ((selectedEmployeedepartment?.name ?? "").isEmpty))) {
  //     if ((selecteddepositorList?.name ?? "").isEmpty) {
  //       Validator().showToast(
  //         context,
  //         "Please enter depositor",
  //       );
  //     } else if (depositorEmpIdTextController.text.isEmpty) {
  //       Validator().showToast(
  //         context,
  //         "Please enter depositor employee id",
  //       );
  //     } else if ((selectedEmployeedepartment?.name ?? "").isEmpty) {
  //       Validator().showToast(
  //         context,
  //         "Please enter employee department",
  //       );
  //     }
  //   } else {
  //     //createNewuserBody(true, widget.listuser?.id ?? 0);
  //     if (widget.listuser != null) {
  //       if (isClaimantDBEmployeeSelected == 1 &&
  //           ((claimant.isEmpty) ||
  //               (claimantEmpIdTextController.text.isEmpty) ||
  //               ((selectedClaimdepartment?.name ?? '').isEmpty))) {
  //         if (claimant.isEmpty) {
  //           Validator().showToast(
  //             context,
  //             "Please enter claimant",
  //           );
  //         } else if (claimantEmpIdTextController.text.isEmpty) {
  //           Validator().showToast(
  //             context,
  //             "Please enter claimant employee id",
  //           );
  //         } else if ((selectedClaimdepartment?.name ?? '').isEmpty) {
  //           Validator().showToast(
  //             context,
  //             "Please enter claimant department",
  //           );
  //         }
  //       } else if (isClaimantDBEmployeeSelected == 0 &&
  //           claimantTextController.text.isEmpty) {
  //         Validator().showToast(context, "Please enter claim");
  //       } else {
  //         createNewuserBody(true, widget.listuser?.id ?? 0);
  //       }
  //     } else {
  //       createFoundBody(false, widget.listuser?.id ?? 0);
  //     }
  //   }
  // }

  createfoundValidations(BuildContext context) {
    if (statusTextController.text.isEmpty &&
        createdByValue.isEmpty &&
        (locationSelectedlist?.name ?? "").isEmpty &&
        dateofcreationTextController.text.isEmpty &&
        serialNumber.isEmpty &&
        assettypeTextController.text.isEmpty &&
        (selectedArtclelist?.name ?? "").isEmpty &&
        founddateTextController.text.isEmpty &&
        foundLocationTextController.text.isEmpty &&
        additionalinformationTextController.text.isEmpty &&
        // quantityTextController.text.isEmpty &&
        (((isDepositorDBEmployeeSelected == 1 &&
                    (selecteddepositorList?.name ?? "").isEmpty) &&
                depositorEmpIdTextController.text.isEmpty &&
                (selectedEmployeedepartment?.name ?? "").isEmpty) ||
            (isDepositorDBEmployeeSelected == 0 &&
                depositorTextController.text.isEmpty))) {
      Validator().showToast(
        context,
        "Please fill all required fields",
      );
    } else if ((locationSelectedlist?.name ?? "").isEmpty) {
      Validator().showToast(
        context,
        "Please enter location",
      );
    } else if (dateofcreationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator date",
      );
    } else if (serialNumber.isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } else if (assettypeTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter asset type",
      );
    } else if ((selectedArtclelist?.name ?? "").isEmpty) {
      Validator().showToast(
        context,
        "Please enter article type",
      );
    } else if (founddateTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter found date",
      );
    } else if (foundLocationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter found location",
      );
    } else if (quantityTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter quantity",
      );
    } else if (colorTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter colour",
      );
    } else if (isDepositorDBEmployeeSelected == 0 &&
        depositorTextController.text.isEmpty) {
      Validator().showToast(context, "Please enter depositor");
    } else if (isDepositorDBEmployeeSelected == 1 &&
        (((selecteddepositorList?.name ?? "").isEmpty) ||
            (depositorEmpIdTextController.text.isEmpty) ||
            ((selectedEmployeedepartment?.name ?? "").isEmpty))) {
      if ((selecteddepositorList?.name ?? "").isEmpty) {
        Validator().showToast(
          context,
          "Please enter depositor",
        );
      } else if (depositorEmpIdTextController.text.isEmpty) {
        Validator().showToast(
          context,
          "Please enter depositor employee id",
        );
      } else if ((selectedEmployeedepartment?.name ?? "").isEmpty) {
        Validator().showToast(
          context,
          "Please enter employee department",
        );
      }
    } else {
      //createNewuserBody(true, widget.listuser?.id ?? 0);
      if (widget.listuser != null) {
        if (isClaimantDBEmployeeSelected == 1 &&
            ((claimant.isEmpty) ||
                (claimantEmpIdTextController.text.isEmpty) ||
                (claimantDepartmentName.isEmpty))) {
          if (claimant.isEmpty) {
            Validator().showToast(
              context,
              "Please enter claimant",
            );
          } else if (claimantEmpIdTextController.text.isEmpty) {
            Validator().showToast(
              context,
              "Please enter claimant employee id",
            );
          } else if ((selectedClaimdepartment?.name ?? '').isEmpty) {
            Validator().showToast(
              context,
              "Please enter claimant department",
            );
          }
        } else if (isClaimantDBEmployeeSelected == 0 &&
            claimantTextController.text.isEmpty) {
          Validator().showToast(context, "Please enter claim");
        } else {
          createNewuserBody(true, widget.listuser?.id ?? 0);
        }
      } else {
        createFoundBody(true, widget.listuser?.id ?? 0);
      }
    }
  }

  assetTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: ["Personal", "company"],
            onTap: (String value) {
              print(value);
              assettypeTextController.text = value;
              setState(() {});
            },
          );
        });
  }

  articleTypeDialog(CreateFoundState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateArticleList:
                state.getArticleTypeResponse?.articleList ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addarticletype,
                      createFoundState: state,
                    );
                  });
            },
            onTap: (ArticleList list) {
              print(list.name);
              selectedArtclelist = list;
              setState(() {});
            },
          );
        });
  }

  datePickerDialog(TextEditingController textfield) async {
    // datePickerselection(context, founddateTextController);
    DateTime? pickedDate = await showDateTimePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    print(
        formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement
    if (textfield == founddateTextController) {
      founddateTextController.text = formattedDate;
    } else if (textfield == handedoverdatedateTextController) {
      handedoverdatedateTextController.text = formattedDate;
    }
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  // colorDailog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CustomSimpleListTexts(
  //           texts: const ["Red", "Yellow", "White", "Black", "Orange"],
  //           onTap: (String value) {
  //             print(value);
  //             colorTextController.text = value;
  //             FocusScope.of(context).unfocus();
  //             colorTextController.clear;
  //             setState(() {});
  //           },
  //         );
  //       });
  // }

  depositorDialog(CreateFoundState state, String name) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateDepostorList:
                state.getDepositorResponse?.atomStaticUser ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return CreateFoundNewUser(
                      title: Constants.createnewuser,
                      createoundstate: state,
                    );
                  });
            },
            onTap: (BaseUser list) {
              print(list.name);
              if (name.toLowerCase() == 'depositor') {
                selecteddepositorList = list;
              } else {
                selectedClaimList = list;
              }
              setState(() {});
            },
          );
        });
  }

  employeeDepartmentDialog(CreateFoundState state, String name) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateEmployeeDepartments:
                state.getEmployeeDepartmentsResponse?.employeeDepartments ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addemployeedepartment,
                      createFoundState: state,
                    );
                  });
            },
            onTap: (Organisation list) {
              print(list.name);
              if (name == Constants.employeedepartment) {
                selectedEmployeedepartment = list;
              } else {
                selectedClaimdepartment = list;
              }
              setState(() {});
            },
          );
        });
  }

  initiallyLocationandSerialnumberdataset(CreateFoundState state) async {
    if (locationSelectedlist == null &&
        state.getLocationsResponse != null &&
        widget.listuser == null) {
      locationSelectedlist = Organisation(id: 24, name: "DLF Square");
      locationselectedText = 'DLF Square';
      await createFoundArticleCubit.getSerialnumberDetails('24', 'AF', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        appBar: AppHeader(
          isTitleCenter: false,
          title: widget.listuser != null
              ? Constants.editfound
              : Constants.createfound,
          backBtn: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppIcon.backIcon,
                color: AppColors.backgroundWhitecolor),
          ),

          action: [
            Visibility(
              visible: widget.listuser?.status != 2,
              child: GestureDetector(
                onTap: () {
                  //for now the new param is isSubmit added, if any new params needed we can add to this.
                  //createNewuserBody(false); //for save
                  //createdraftValidations(context);
                  createNewuserBody(false, 0);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(
                    AppIcon.createfoundsaveicon,
                  ),
                ),
              ),
            ),
            //Visibility(
            //   //visible:
            //  // widget.listuser?.status == 0 && widget.listuser?.status == 1,
            //  child: GestureDetector(
            //       onTap: () {
            //         //createNewuserBody(); //in this method createfoundValidations, calling the createNewuserBody
            //         createfoundValidations(context);
            //       },
            //       child: const Padding(
            //         padding: EdgeInsets.only(right: 20.0),
            //         child: Icon(
            //           Icons.send,
            //           color: AppColors.backgroundWhitecolor,
            //         ),
            //         // SvgPicture.asset(
            //         //   AppIcon.createfoundsaveicon,
            //         //),
            //       ),
            //     ),
            // ),
          ],
          //backgroundColor: AppColors.navigationSkybluecolor,
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
          builder: (context, state) {
            createfoundResponse = state.createFoundResponse;

            if (state.stateType == CreateFoundStateType.addattachment) {
              // if (getFiles == null || getFiles?.length == 0) {
              getFiles = state.loadAttachments ?? [];
              // } else {
              //   if (state.loadAttachments != null && state.loadAttachments?.length != 0) {
              //     getFiles?.addAll(state.loadAttachments ?? []);
              //   }
              //  }
            }
            // if (createfoundResponse?.message != null) {
            //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            //     _createFoundAlert(context, createfoundResponse?.message ?? '');
            //   });
            // }
            initiallyLocationandSerialnumberdataset(state);
            if (widget.listuser == null) {
              userDetails = state.getUserDetailsResponse ?? User();
              if (userDetails != null) {
                createdByValue =
                    '${userDetails?.firstName ?? ''} ${userDetails?.lastName ?? ''}';
              }
              serialnumberResponse = state.getSerialnumberResponse;
              if (serialnumberResponse != null) {
                serialNumber = serialnumberResponse?.serialNo ?? "";
              }
            } else {
              claimantDepartmentName = selectedClaimdepartment?.name ?? '';
              claimant = selectedClaimList?.name ?? '';
            }
            return Container(
                color: AppColors.navigationSkybluecolor,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    height: height * 0.01,
                    color: AppColors.navigationSkybluecolor,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const ShapeDecoration(
                        color: AppColors.backgroundWhitecolor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        )),
                    child: Form(
                        key: createfoundFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // Status
                            CommonWidgets.textDisplay(
                                Constants.status, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFieldController: statusTextController,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                              suffixWidget: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(
                                    //AppIcon.dropdownicon,
                                    AppIcon.dropdownicon,
                                    //fit: BoxFit.,
                                    color: AppColors.textgreyThemecolor,
                                    width: 10,
                                    height: 10,
                                    key: const Key(Keys.userIcon),
                                  ),
                                ),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            //created by

                            CommonWidgets.horizentaltextHandling(
                                Constants.createdby,
                                '${state.getUserDetailsResponse?.firstName ?? ''} ${state.getUserDetailsResponse?.lastName ?? ''}'),

                            // ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // Location

                            CommonWidgets.textDisplay(
                                Constants.location, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // date of creation
                            CommonWidgets.textDisplay(Constants.dateofcreation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // slno

                            CommonWidgets.horizentaltextHandling(
                                Constants.slno, serialNumber),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // asset type
                            CommonWidgets.textDisplay(
                                Constants.assettype, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (widget.listuser == null ||
                                    assettypeTextController.text.isEmpty) {
                                  assetTypeDialog();
                                }
                              },
                              child: FlutterInputField(
                                  isEnable: false,
                                  isDisableColor: widget.listuser == null ||
                                          assettypeTextController.text.isEmpty
                                      ? false
                                      : true,
                                  textFieldController: assettypeTextController,
                                  textFormKey: Keys.statusTextController,
                                  hintText: '',
                                  onChange: (String username) {
                                    //this.username = username;
                                    setState(() {});
                                  },
                                  onTap: () {
                                    if (widget.listuser == null ||
                                        assettypeTextController.text.isEmpty) {
                                      assetTypeDialog();
                                    }
                                  },
                                  validateTextField: (String? user) {},
                                  suffixWidget: IconButton(
                                      icon: SvgPicture.asset(
                                          width: 10,
                                          height: 10,
                                          AppIcon.dropdownicon,
                                          key: const Key('closed_eye')),
                                      onPressed: () {
                                        print('suffixIcon pressed');

                                        assetTypeDialog();
                                      })),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // article type
                            CommonWidgets.textDisplay(
                                Constants.articleType, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            articleaddButtonwidgetLoading(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // found date
                            CommonWidgets.textDisplay(
                                Constants.founddate, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datepickerWidgetLoading(founddateTextController),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // found location

                            CommonWidgets.textDisplay(Constants.foundlocation,
                                Styles.textStyleBlack14),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textFieldController: foundLocationTextController,
                              textFormKey: Keys.foundLocationTextController,
                              hintText: '',
                              isEnable: widget.listuser == null
                                  ? true
                                  : (widget.listuser != null &&
                                          (widget.listuser?.foundLocation ?? '')
                                              .isEmpty)
                                      ? true
                                      : false,
                              isDisableColor: (widget.listuser != null &&
                                          (widget.listuser?.foundLocation ?? '')
                                              .isEmpty) ||
                                      widget.listuser == null
                                  ? false
                                  : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // additional information
                            CommonWidgets.textDisplay(
                                Constants.additionalinformation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              textFieldController:
                                  additionalinformationTextController,
                              textFormKey:
                                  Keys.additionalinformationTextController,
                              hintText: Constants.informationhere,
                              isEnable: widget.listuser == null
                                  ? true
                                  : (widget.listuser != null &&
                                          (widget.listuser
                                                      ?.additionalInformation ??
                                                  '')
                                              .isEmpty)
                                      ? true
                                      : false,
                              isDisableColor: (widget.listuser != null &&
                                          (widget.listuser
                                                      ?.additionalInformation ??
                                                  '')
                                              .isEmpty) ||
                                      widget.listuser == null
                                  ? false
                                  : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // // quantitiy
                            // CommonWidgets.textDisplay(
                            //     Constants.quantity, Styles.textStyleBlack14),
                            // CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // FlutterInputField(
                            //   keyboardType: TextInputType.number,
                            //   textFieldController: quantityTextController,
                            //   textFormKey: Keys.quantityTextController,
                            //   hintText: '',
                            //   isEnable: widget.listuser == null
                            //       ? true
                            //       : (widget.listuser != null &&
                            //               (widget.listuser?.quantity == null))
                            //           ? false
                            //           : true,
                            //   isDisableColor: (widget.listuser != null &&
                            //           (widget.listuser?.quantity != null))
                            //       ? true
                            //       : false,
                            //   onChange: (String username) {
                            //     //this.username = username;
                            //     setState(() {});
                            //   },
                            //   validateTextField: (String? user) {},
                            // ),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // quantitiy
                            CommonWidgets.textDisplay(
                                Constants.quantity, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              textFieldController: quantityTextController,
                              textFormKey: Keys.quantityTextController,
                              hintText: '',
                              isEnable: widget.listuser == null
                                  ? true
                                  : (widget.listuser != null &&
                                          (widget.listuser?.quantity == null))
                                      ? true
                                      : false,
                              isDisableColor: (widget.listuser != null &&
                                          (widget.listuser?.quantity != null) ||
                                      widget.listuser == null)
                                  ? false
                                  : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // color
                            CommonWidgets.textDisplay(
                                Constants.colour, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textFieldController: colorTextController,
                              textFormKey: Keys.colorTextController,
                              hintText: '',
                              isEnable: widget.listuser == null
                                  ? true
                                  : (widget.listuser != null &&
                                          (widget.listuser?.color ?? '')
                                              .isEmpty)
                                      ? true
                                      : false,
                              isDisableColor: (widget.listuser != null &&
                                          (widget.listuser?.color ?? '')
                                              .isEmpty) ||
                                      widget.listuser == null
                                  ? false
                                  : true,
                              onChange: (String username) {
                                //this.username = username;
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                            ),
                            // FlutterInputField(
                            //   onTap: () {
                            //     colorDailog();
                            //   },
                            //   textFieldController: colorTextController,
                            //   textFormKey: Keys.colorTextController,
                            //   isEnable: widget.listuser == null
                            //       ? true
                            //       : (widget.listuser != null &&
                            //               (widget.listuser?.color ?? '')
                            //                   .isEmpty)
                            //           ? true
                            //           : false,
                            //   isDisableColor: (widget.listuser != null &&
                            //               (widget.listuser?.color ?? '')
                            //                   .isEmpty) ||
                            //           widget.listuser == null
                            //       ? false
                            //       : true,
                            //   hintText: '',
                            //   onChange: (String username) {
                            //     //this.username = username;
                            //     setState(() {});
                            //   },
                            //   validateTextField: (String? user) {},
                            //   // )
                            //   //)
                            // ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // is depositor employee
                            CommonWidgets.textDisplay(
                                Constants.isdepositordbemployee,
                                Styles.textStyleBlack14),
                            radioButtonHandling(isDepositorDBEmployeeSelected,
                                Constants.isdepositordbemployee),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // depositor
                            CommonWidgets.textDisplay(
                                Constants.depositor, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            isDepositorDBEmployeeSelected == 1
                                ? TextfieldAddButton(
                                    title: selecteddepositorList?.name != null
                                        ? ('${selecteddepositorList?.name ?? ''}(${selecteddepositorList?.email ?? ''})')
                                        : '',
                                    height: 70,
                                    isDisableColor: widget.listuser?.status != 0 && widget.listuser !=null
                                        ? true
                                        : false,
                                    onTap: () {
                                      if (widget.listuser?.status == 0 || widget.listuser == null )
                                         {
                                        depositorDialog(
                                            state, Constants.depositor);
                                      }
                                    })
                                : FlutterInputField(
                                    textFieldController:
                                        depositorTextController,
                                    textFormKey: Keys.depositorTextController,
                                    hintText: '',
                                    isEnable: widget.listuser == null
                                        ? true
                                        : (widget.listuser != null &&
                                                (widget.listuser
                                                            ?.depositorName ??
                                                        '')
                                                    .isEmpty)
                                            ? true
                                            : false,
                                    isDisableColor: (widget.listuser != null &&
                                            (widget.listuser?.depositorName ??
                                                    '')
                                                .isEmpty)
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            // Depositor employee id
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.textDisplay(
                                    Constants.depositoremployeeid,
                                    Styles.textStyleBlack14)
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),

                            isDepositorDBEmployeeSelected == 1
                                ? FlutterInputField(
                                    textFieldController:
                                        depositorEmpIdTextController,
                                    textFormKey:
                                        Keys.depositorEmpIdTextController,
                                    hintText: '',
                                    isEnable: widget.listuser == null
                                        ? true
                                        : (widget.listuser != null &&
                                                (widget.listuser?.employeeId ??
                                                        '')
                                                    .isEmpty)
                                            ? true
                                            : false,
                                    isDisableColor: (widget.listuser?.status ==
                                                    2 &&
                                                (widget.listuser?.employeeId ??
                                                        '')
                                                    .isEmpty) ||
                                            widget.listuser == null
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  )
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.01)
                                : Container(),
                            // employee department
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.textDisplay(
                                    Constants.employeedepartment,
                                    Styles.textStyleBlack14)
                                : Container(),
                            isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),

                            isDepositorDBEmployeeSelected == 1
                                ? TextfieldAddButton(
                                    title:
                                        selectedEmployeedepartment?.name ?? '',
                                    height: 60,
                                    isDisableColor: widget.listuser != null && widget.listuser?.status != 0
                                        ? true
                                        : false,
                                    onTap: () {
                                      if (widget.listuser == null ||widget.listuser?.status == 0)
                                          {
                                        employeeDepartmentDialog(state,
                                            Constants.employeedepartment);
                                      }
                                    },
                                  )
                                : Container(),
                            widget.listuser != null &&
                                    isDepositorDBEmployeeSelected == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.01)
                                : Container(),

                            if (widget.listuser?.status == 1) ...[
                              // is claimant db employee
                              widget.listuser != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.isclaimantdbemployee,
                                      Styles.textStyleBlack14,
                                    )
                                  : Container(),
                              widget.listuser != null
                                  ? radioButtonHandling(
                                      isClaimantDBEmployeeSelected,
                                      Constants.isclaimantdbemployee)
                                  : Container(),

                              // claimant
                              widget.listuser != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimant,
                                      Styles.textStyleBlack14,
                                    )
                                  : Container(),
                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 0
                                  ? FlutterInputField(
                                      textFieldController:
                                          claimantTextController,
                                      textFormKey: Keys.claimantTextController,
                                      hintText: claimant,
                                      isEnable: widget.listuser?.status != 2
                                          ? true
                                          : (widget.listuser != null &&
                                                  (widget.listuser?.claimant
                                                              ?.lastName ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor:
                                          (widget.listuser?.status != 2 &&
                                                  (widget.listuser?.claimant
                                                              ?.lastName ??
                                                          '')
                                                      .isEmpty)
                                              ? false
                                              : true,
                                      onChange: (String username) {
                                        //this.username = username;
                                        claimant = username;
                                        setState(() {});
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : widget.listuser != null
                                      ? TextfieldAddButton(
                                          title: selectedClaimList?.name ?? '',
                                          height: 60,
                                          isDisableColor: widget.listuser?.status !=2
                                              ? false
                                              : true,
                                          onTap: () {
                                            if ( widget.listuser?.status !=2) {
                                              depositorDialog(
                                                  state, Constants.claimant);
                                            }
                                          },
                                        )
                                      : Container(),
                              isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),

                              widget.listuser != null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),

                              // Claimant employee id

                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimantemployeeid,
                                      Styles.textStyleBlack14)
                                  : Container(),
                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),

                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? FlutterInputField(
                                      textFieldController:
                                          claimantEmpIdTextController,
                                      textFormKey:
                                          Keys.claimantEmpIdTextController,
                                      isEnable:  widget.listuser?.status !=2
                                          ? true
                                          : (widget.listuser != null &&
                                                  (widget.listuser
                                                              ?.claimantEmployeeId ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: ( widget.listuser?.status !=2)
                                          ? false
                                          : true,
                                      hintText: '',
                                      onChange: (String username) {
                                        //this.username = username;
                                        setState(() {});
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : Container(),

                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),

                              // claimant department

                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimantdepartment,
                                      Styles.textStyleBlack14)
                                  : Container(),
                              isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),

                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? TextfieldAddButton(
                                      title:
                                          (selectedClaimdepartment?.name ?? ''),
                                      height: 60,
                                      isDisableColor: widget.listuser == null && widget.listuser?.status == 3
                                          ? true
                                          : false,
                                      onTap: () {
                                       // if (widget.listuser == null ||widget.listuser?.status == 0)
                                        {
                                          employeeDepartmentDialog(state,
                                              Constants.claimantdepartment);
                                        }
                                      },
                                    )
                                  : Container(),
                              isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),

                              // is claimant accepted by email

                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.isclaimantacceptedbyemail,
                                      Styles.textStyleBlack14)
                                  : Container(),
                              widget.listuser != null &&
                                      isClaimantDBEmployeeSelected == 1
                                  ? radioButtonHandling(
                                      isClaimantAcceptedByemail,
                                      Constants.isclaimantacceptedbyemail)
                                  : Container(),

                              // is claimant accepted to sign

                              widget.listuser != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.isclaimantacceptedtosign,
                                      Styles.textStyleBlack14,
                                    )
                                  : Container(),
                              widget.listuser != null
                                  ? radioButtonHandling(
                                      isClaimantAcceptedtoSignSelected,
                                      Constants.isclaimantacceptedtosign)
                                  : Container(),

                              widget.listuser != null &&
                                      isClaimantAcceptedtoSignSelected == 1
                                  ? CommonWidgets.textDisplay(
                                      Constants.claimantsignature,
                                      Styles.textStyleBlack14)
                                  : Container(),
                              widget.listuser != null &&
                                      isClaimantAcceptedtoSignSelected == 1
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              widget.listuser != null &&
                                      isClaimantAcceptedtoSignSelected == 1
                                  ? FlutterInputField(
                                      lineHeight: 6,
                                      textFieldController:
                                          claimantsignatureTextController,
                                      isEnable: false,
                                      textFormKey:
                                          Keys.claimantsignatureTextController,
                                      isDisableColor: true,
                                      hintText: '',
                                      onChange: (String username) {
                                        //this.username = username;
                                        setState(() {});
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : Container(),
                              widget.listuser != null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),
                            ],
                            // Item Handover By
                            if (widget.listuser?.status == 2) ...[
                              widget.listuser?.status == 2
                                  ? CommonWidgets.horizentaltextHandling(
                                      Constants.itemhandoverby,
                                      itemhandoverByValue)
                                  : Container(),

                              // Handed over date

                              widget.listuser != null
                                  ? CommonWidgets.textDisplay(
                                      Constants.handedoverdate,
                                      Styles.textStyleBlack14,
                                    )
                                  : Container(),
                              widget.listuser != null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              widget.listuser != null
                                  ? datepickerWidgetLoading(
                                      handedoverdatedateTextController)
                                  : Container(),
                              widget.listuser == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                  : Container(),
                            ],
                            // upload
                            widget.listuser == null
                                ? Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFCACACA),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize:
                                                      const Size(140, 50)),
                                              onPressed: () {
                                                // Navigator.pushNamed(context,
                                                //     createFoundAttachmentRoute);
                                                //UploadAttachment();
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return UploadAttachment(
                                                        userdetails:
                                                            userDetails,
                                                        getFiles:
                                                            getFiles ?? [],
                                                        createoundstate: state,
                                                      );
                                                    });
                                              },

                                              icon: SvgPicture.asset(
                                                //AppIcon.dropdownicon,
                                                AppIcon.uploadicon,
                                                //fit: BoxFit.,
                                                color: AppColors
                                                    .backgroundWhitecolor,
                                                width: 13,
                                                height: 13,
                                                key: const Key(Keys.userIcon),
                                              ),
                                              // const Icon(
                                              //   // <-- Icon
                                              //   Icons.upload,
                                              //   color: AppColors.backgroundWhitecolor,
                                              //   size: 24.0,
                                              // ),
                                              label: const Text(
                                                Constants.clicktoupload,
                                                style: Styles
                                                    .textStyleRegularNormalWhite12,
                                              ), // <-- Text
                                            ),
                                          ),
                                        ]),
                                  )
                                : Container(),
                            getAttachments != null ||
                                    getFiles != null ||
                                    getFiles?.length != 0 ||
                                    getAttachments?.length != 0
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.01)
                                : Container(),
                            (getAttachments == null ||
                                    getAttachments?.length == 0 ||
                                    widget.listuser == null)
                                ? getFiles?.length == 0 || getFiles == null
                                    ? Container()
                                    : attachmentListviews(
                                        getFiles, getAttachments)
                                : attachmentListviews(getFiles, getAttachments),
                            if (widget.listuser?.status != 2) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  cancelButtonDisplay(),
                                  submitButtonDisplay()
                                ],
                              ),
                            ],
                          ],
                        )),
                  ),
                ])));
          },
        ));
  }

  Widget submitButtonDisplay() {
    return // Login button
        AppButton(
      width: 150,
      // disableColor: isHandedOver,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        createfoundValidations(context);
      },
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget locationWidgetdislay(CreateFoundState state) {
    return GestureDetector(
      onTap: () {
        //if (widget.listuser == null || locationselectedText.isEmpty)
        {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              print(state.getLocationsResponse);
              return CustomExpansionListTexts(
                getLocationsresponse:
                    state.getLocationsResponse ?? GetLocations(),
                onTap: (Organisation? list) async {
                  print(list?.name);
                  await createFoundArticleCubit.getSerialnumberDetails(
                      list?.id.toString() ?? '', 'AF', context);
                  locationselectedText = list?.name ?? '';
                  locationSelectedlist = list;
                  setState(() {});
                },
              );
            },
          );
        }
      },
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFCACACA),
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: locationselectedText.isEmpty
              ? Container()
              : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.normaltextBackground),
                        ),
                        onPressed: () {},
                        child: Text(
                          locationselectedText,
                          style: Styles.textStyleBlack14,
                        ),
                      ),
                    ),
                  )
                ])),
    );
  }

  Widget datecreateWidgetdisplay() {
    return FlutterInputField(
      textFieldController: dateofcreationTextController,
      textFormKey: Keys.dateofcreationTextController,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String username) {
        //this.username = username;
        setState(() {});
      },
      validateTextField: (String? user) {},
    );
  }

  Widget radioButtonHandling(int selectedValue, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: widget.listuser != null
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          // focusColor:
          //     AppColors.navigationSkybluecolor,

          value: 1,
          groupValue: selectedValue,
          onChanged: (val) {
            radioButtonItem = 'Yes';
            selectedValue = 1;
            if (name == Constants.isclaimantacceptedtosign) {
              isClaimantAcceptedtoSignSelected = selectedValue;
            } else if (name == Constants.isclaimantacceptedbyemail) {
              isClaimantAcceptedByemail = selectedValue;
            } else if (name == Constants.isclaimantdbemployee) {
              isClaimantDBEmployeeSelected = selectedValue;
            } else if (name == Constants.isdepositordbemployee &&
                widget.listuser?.status != 1) {
              isDepositorDBEmployeeSelected = selectedValue;
            }
            setState(() {});
          },
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: widget.listuser != null
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          value: 0,
          groupValue: selectedValue,
          onChanged: (val) {
            radioButtonItem = 'No';
            selectedValue = 0;
            if (name == Constants.isclaimantacceptedtosign) {
              isClaimantAcceptedtoSignSelected = selectedValue;
            } else if (name == Constants.isclaimantacceptedbyemail) {
              isClaimantAcceptedByemail = selectedValue;
            } else if (name == Constants.isclaimantdbemployee) {
              isClaimantDBEmployeeSelected = selectedValue;
            } else if (name == Constants.isdepositordbemployee &&
                widget.listuser?.status != 1) {
              isDepositorDBEmployeeSelected = selectedValue;
            }
            setState(() {});
          },
        ),
        const Text(Constants.no),
      ],
    );
    //return Container();
  }

  Widget articleaddButtonwidgetLoading(CreateFoundState state) {
    return TextfieldAddButton(
      title: selectedArtclelist?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser?.status != 2 && widget.listuser != null
          ? true
          : false,
      onTap: () {
        if (widget.listuser?.status != 2) {
          articleTypeDialog(state);
        }
      },
    );
  }

  Widget datepickerWidgetLoading(TextEditingController textfiled) {
    return GestureDetector(
      onTap: () {
        if (widget.listuser?.status == 0) {
          datePickerDialog(textfiled);
        }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
        textFormKey: textfiled == founddateTextController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor:
            widget.listuser == null || textfiled.text.isEmpty ? false : true,
        onChange: (String username) {
          //this.username = username;
          print('dfwf');

          setState(() {});
        },
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (widget.listuser == null || textfiled.text.isEmpty) {
              datePickerDialog(textfiled);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              color: AppColors.textgreyThemecolor,
              width: 20,
              key: const Key(Keys.userIcon),
            ),
          ),
        ),
      ),
    );
  }

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              attachmentListviews1?.length ?? attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            CreateImage? imagedata;
            FoundImage? imagedata1;
            if (widget.listuser != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.listuser != null
                      ? SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground)
                      : SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  onTap: () {
                    DownloadImage().saveImage(
                        context, imagedata1?.id ?? 0, imagedata1?.title ?? '');
                  },
                  title: widget.listuser != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata?.title ?? ''),
                ),

                Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //                           <-- Divider
              ],
            );
          }),
    );
  }
}

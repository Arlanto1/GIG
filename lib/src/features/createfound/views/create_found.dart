import 'dart:convert';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/utils/network_handler.dart' as network_handler;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateFound extends StatefulWidget {
  final FoundListArticleDetails? model;
  final int? eventId;
  final ExtraProperties? extraProperties;

  const CreateFound({
    super.key,
    this.model,
    this.eventId,
    this.extraProperties,
  });

  @override
  State<CreateFound> createState() => _CreateFoundState();
}

class _CreateFoundState extends State<CreateFound> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = '';
  String serialNumber = '';
  int pageNumber = 0;

  // Group Value for Radio Button.
  int isDepositorDBEmployeeSelected = 0;
  int isClaimantDBEmployeeSelected = 0;
  int isClaimantAcceptedtoSignSelected = 1;
  int isClaimantAcceptedByemail = 0;
  final GlobalKey<FormState> createfoundFormKey = GlobalKey<FormState>();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController colorTextController = TextEditingController();
  TextEditingController foundLocationTextController = TextEditingController();
  TextEditingController depositorEmpIdTextController = TextEditingController();
  TextEditingController claimantEmpIdTextController = TextEditingController();
  TextEditingController additionalinformationTextController =
      TextEditingController();
  TextEditingController foundDateTextController = TextEditingController();
  TextEditingController handedoverdatedateTextController =
      TextEditingController();
  TextEditingController dateOfCreationTextController = TextEditingController();
  TextEditingController assetTypeTextController = TextEditingController();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController depositorTextController = TextEditingController();
  TextEditingController claimantTextController = TextEditingController();
  String isDepositorDBEmployee = "";

  final FocusNode foundLocationFocusNode = FocusNode();

  // String slnoValue = "dfwe";
  String createdByValue = "";
  String handOverByValue = "";
  String locationselectedText = "";
  Organisation? selectedEmployeedepartment;
  Organisation? selectedClaimdepartment;
  String claimantDepartmentName = '';
  String claimant = '';
  Organisation? selectedArtclelist;
  BaseUser? selecteddepositorList;
  BaseUser? selectedClaimList;
  User? userDetails;
  User? handOverSecurity;
  Organisation? locationSelectedlist;
  SubmitCreateFoundModel? createfoundResponse;
  SerialNumberModel? serialnumberResponse;
  List<ImageContent> getFiles = [];
  List<ImageContent> getAttachments = [];

  SignatureController claimantSignatureController = SignatureController();

  @override
  void initState() {
    super.initState();
    claimantSignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);
    populateData();
    BlocProvider.of<CreateFoundArticleCubit>(context).initializeValues();
    _getFoundArticleList();
    _getCurrentDate();
  }

  @override
  void dispose() {
    claimantSignatureController.dispose();
    super.dispose();
  }

  populateData() async {
    assetTypeTextController.text = "Personal";
    widget.model?.typeOfAsset == 0;
    if (widget.model != null) {
      await SharedPrefs.setFoundId(widget.model?.id ?? 0);
      selecteddepositorList = widget.model?.depositor != null
          ? BaseUser(
              email: widget.model?.depositor?.email ?? "",
              id: widget.model?.depositor?.userId ?? 0,
              name: widget.model?.depositor?.userInfo ?? "")
          : BaseUser();
      selectedArtclelist = widget.model?.typeOfArticle != null
          ? Organisation(
              id: widget.model?.typeOfArticle?.id ?? 1,
              name: widget.model?.typeOfArticle?.name ?? "")
          : Organisation();
      userDetails = widget.model?.entrySecurity != null
          ? User(
              userId: widget.model?.entrySecurity?.userId ?? 1,
              lastName: widget.model?.entrySecurity?.lastName ?? "")
          : User();
      handOverSecurity = widget.model?.handoverSecurity != null
          ? User(
              userId: widget.model?.handoverSecurity?.userId ?? 1,
              lastName: widget.model?.handoverSecurity?.lastName ?? "")
          : User();
      createdByValue =
          userDetails?.userInfo != null ? userDetails?.userInfo ?? '' : '';
      handOverByValue = handOverSecurity?.userInfo != null
          ? handOverSecurity?.userInfo ?? ''
          : '';
      serialNumber = widget.model?.slNo != null ? widget.model?.slNo ?? "" : '';
      locationSelectedlist = widget.model?.location != null
          ? Organisation(
              id: widget.model?.location?.id ?? 0,
              name: widget.model?.location?.name ?? "")
          : Organisation();
      locationselectedText = locationSelectedlist?.name != null
          ? locationSelectedlist?.name ?? ""
          : '';
      quantityTextController.text = widget.model?.quantity != null
          ? widget.model?.quantity.toString() ?? ""
          : '';
      colorTextController.text = widget.model?.color != null
          ? widget.model?.color.toString() ?? ""
          : '';
      foundLocationTextController.text = widget.model?.foundLocation != null
          ? widget.model?.foundLocation.toString() ?? ""
          : '';
      additionalinformationTextController.text =
          widget.model?.additionalInformation != null
              ? widget.model?.additionalInformation.toString() ?? ""
              : '';
      foundDateTextController.text =
          widget.model?.foundDate != null && widget.model?.foundDate != '0'
              ? Utils.timestampToDateConversion(
                  int.tryParse(widget.model?.foundDate ?? '0'),
                  Constants.fulldateFormat)
              : '';
      dateOfCreationTextController.text =
          widget.model?.inputDate != null && widget.model?.inputDate != '0'
              ? Utils.timestampToDateConversion(
                  int.tryParse(widget.model?.inputDate ?? '0'),
                  Constants.fulldateFormat)
              : dateOfCreationTextController.text;
      assetTypeTextController.text = widget.model?.typeOfAsset != null
          ? (widget.model?.typeOfAsset == 0 ? "Personal" : "Company")
          : '';
      statusTextController.text = widget.model?.status == 0
          ? "Found"
          : widget.model?.status == 1
              ? "Under Security Custody"
              : widget.model?.status == -1
                  ? "Cancelled"
                  : "Handed Over/ Claimed";
      depositorTextController.text = widget.model?.depositorName != null
          ? widget.model?.depositorName ?? ""
          : '';
      isDepositorDBEmployeeSelected =
          ((widget.model?.depositorDbEmp ?? false) == true) ? 1 : 0;
      isClaimantAcceptedtoSignSelected =
          ((widget.model?.claimantNoSign ?? false) == true) ? 1 : 0;
      isClaimantAcceptedByemail =
          ((widget.model?.claimantConfirmByEmail ?? false) == true) ? 1 : 0;
      isClaimantDBEmployeeSelected =
          ((widget.model?.claimantDbEmp ?? false) == true) ? 1 : 0;
      depositorEmpIdTextController.text = widget.model?.employeeId != null
          ? widget.model?.employeeId ?? ''
          : '';
      selectedEmployeedepartment = widget.model?.depositorDepartment != null
          ? Organisation(
              id: widget.model?.depositorDepartment?.id ?? 0,
              name: widget.model?.depositorDepartment?.name ?? '')
          : Organisation();
      getAttachments =
          widget.model?.images != null ? widget.model?.images ?? [] : [];
      claimantDepartmentName = widget.model?.claimantDepartmentName != null
          ? widget.model?.claimantDepartmentName ?? ''
          : '';
      handedoverdatedateTextController.text = widget.model?.handoverDate != null
          ? Utils.timestampToDateConversion(
              int.parse(widget.model?.handoverDate ?? '0'),
              Constants.fulldateFormat)
          : handedoverdatedateTextController.text.isEmpty
              ? ''
              : handedoverdatedateTextController.text;
      claimantEmpIdTextController.text = widget.model?.claimantEmployeeId ?? '';
      claimant = widget.model?.claimant?.lastName != null
          ? widget.model?.claimant?.lastName ?? ''
          : '';
      log('---widget.model?.claimant?.lastName-----${widget.model?.claimant?.lastName}----');
      claimantTextController.text = widget.model?.claimant?.userInfo != null
          ? widget.model?.claimant?.userInfo ?? ''
          : '';
      claimantTextController.text = widget.model?.claimantName != null
          ? widget.model?.claimantName ?? ""
          : '';
      selectedClaimdepartment = widget.model?.claimantDepartment != null
          ? Organisation(
              id: widget.model?.claimantDepartment?.id ?? 0,
              name: widget.model?.claimantDepartment?.name ?? '')
          : Organisation();
      selectedClaimList = widget.model?.claimant != null
          ? BaseUser(
              email: widget.model?.claimant?.email ?? "",
              id: widget.model?.claimant?.userId ?? 0,
              name: widget.model?.claimant?.userInfo ?? "")
          : BaseUser();
    }
  }

  createFoundBody(bool isSubmit, int isFoundId) async {
    log('-createFoundBody-----');

    bool isDepositorDBEmployeeSelectedValue =
        isDepositorDBEmployeeSelected == 1 ? true : false;
    // int statusValue = 0;
    // if (statusTextController.text.toLowerCase() == "found") {
    //   statusValue = 0;
    // } else if (statusTextController.text.toLowerCase() ==
    //     "under security custody") {
    //   statusValue = 0;
    // } else {
    //   statusValue = 2;
    // }

    int foundDate = Utils.dateToTimestampConversion(
        foundDateTextController.text, Constants.fulldateFormat);
    // int inputDate = Utils.dateToTimestampConversion(
    //     dateofcreationTextController.text, Constants.fulldateFormat);
    int inputdate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    Map<String, dynamic> entrySecurityBody = {
      "userId": userDetails?.userId ?? 0,
    };
    Map<String, dynamic> handOverSecurityBody = {
      "userId": handOverSecurity?.userId ?? 0,
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
      "status": widget.model?.status ?? 0,
      "typeOfAsset": assetTypeTextController.text.isEmptyOrNull
          ? ((assetTypeTextController.text.toLowerCase()) == 'company' ? 1 : 0)
          : null,
      "color":
          colorTextController.text.isNotEmpty ? colorTextController.text : '',
      "slNo": serialNumber,
      "typeOfArticle": articleBody,
      "entrySecurity": entrySecurityBody,
      "handoverSecurity": handOverSecurityBody,
      "foundLocation": foundLocationTextController.text,
      "quantity": quantityTextController.text.isNotEmpty
          ? int.parse(quantityTextController.text)
          : 0,
      "additionalInformation": additionalinformationTextController.text,
      "depositorDbEmp": isDepositorDBEmployeeSelectedValue,
      "inputDate": inputdate,
      "foundDate": foundDate,
      "location": locationBody,
      "depositorName": isDepositorDBEmployeeSelected == 1
          ? selecteddepositorList?.name ?? ''
          : depositorTextController.text.isNotEmpty
              ? depositorTextController.text
              : '',
      "claimantName": isClaimantDBEmployeeSelected == 1
          ? selectedClaimList?.name ?? ''
          : claimantTextController.text.isNotEmpty
              ? claimantTextController.text
              : '',
      "employeeId": depositorEmpIdTextController.text.isNotEmpty
          ? depositorEmpIdTextController.text
          : '',
      "depositorDepartment": depositorDeptBody,
      "depositor": depositorBody,
      "eventProtection": widget.eventId,
      "images": getFiles
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
        widget.model != null ? Constants.editFound : Constants.createFound);
  }

  /// Submit Form
  Future submitForm(
    bool isSubmit,
    int isFoundId, {
    CreateFoundState? state,
  }) async {
    log('-createRequestBody-----');

    int? foundDate = Utils.dateToTimestampConversion(
        foundDateTextController.text, Constants.fulldateFormat);
    if (foundDate == 0) {
      foundDate = null;
    } // int inputDate = Utils.dateToTimestampConversion(
    //     dateofcreationTextController.text, Constants.fulldateFormat);
    int inputDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    int? handoverDate;
    if (widget.model?.status ==
        ConstantsIntValue.articleFoundStatusUnderSecurityCustody) {
      handoverDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    }
    // Utils.dateToTimestampConversion(
    //     handedoverdatedateTextController.text, Constants.fulldateFormat);
    var username = await SharedPrefs.getUsername();
    bool isDepositorDBEmployeeSelectedValue =
        isDepositorDBEmployeeSelected == 1 ? true : false;
    bool isClaimDBEmployeeSelectedValue =
        isClaimantDBEmployeeSelected == 1 ? true : false;
    bool isClaimSignSelectedValue =
        isClaimantAcceptedtoSignSelected == 1 ? true : false;
    bool isClaimantSelectedByEmail =
        isClaimantAcceptedByemail == 1 ? true : false;
    Organisation? articleType = Organisation(
        id: selectedArtclelist?.id ?? widget.model?.typeOfArticle?.id);
    User? entrySecurity = User(
        userId: userDetails?.userId ?? widget.model?.entrySecurity?.userId);
    User? handoverSecurity = User(
        userId:
            handOverSecurity?.userId ?? widget.model?.handoverSecurity?.userId);
    User? depositor = User(
        userId: selecteddepositorList?.id ?? widget.model?.depositor?.userId);
    Organisation? location = Organisation(
        id: locationSelectedlist?.id ?? widget.model?.location?.id);
    Organisation? depositorDepartment =
        selectedEmployeedepartment ?? widget.model?.depositorDepartment;
    List<ImageContent>? images =
        getFiles.isEmpty ? widget.model?.images : getFiles;
    Organisation? claimantDepartment =
        selectedClaimdepartment ?? widget.model?.claimantDepartment;

    await pushSignature(controller: claimantSignatureController);

    // isClaimantDBEmployeeSelected;
    User? claimant = widget.model?.claimant;
    if (selectedClaimList != null) {
      claimant = User(
        userId: selectedClaimList?.id,
        name: selectedClaimList?.name,
      );
    }

    log('--claimantEmpIdTextController.text--${claimantEmpIdTextController.text}---');
    Found? found = Found(
        claimantConfirmByEmail: isClaimantSelectedByEmail,
        id: widget.model?.id,
        claimantDepartment: claimantDepartment,
        claimant: claimant,
        claimantDbEmp: isClaimDBEmployeeSelectedValue,
        claimantNoSign: isClaimSignSelectedValue,
        // Passing signature
        claimantSign: widget.model?.claimantSign,
        handoverDate: handoverDate,
        claimantEmployeeId: int.tryParse(claimantEmpIdTextController.text),
        slNo: serialNumber,
        images: images,
        typeOfAsset: !assetTypeTextController.text.isEmptyOrNull
            ? ((assetTypeTextController.text.toLowerCase()) == 'company'
                ? 1
                : 0)
            : null,
        typeOfArticle: articleType,
        foundLocation: foundLocationTextController.text.isNotEmpty
            ? foundLocationTextController.text
            : '',
        additionalInformation:
            additionalinformationTextController.text.isNotEmpty
                ? additionalinformationTextController.text
                : '',
        quantity: quantityTextController.text.isNotEmpty
            ? int.parse(quantityTextController.text)
            : 0,
        color:
            colorTextController.text.isNotEmpty ? colorTextController.text : '',
        status: widget.model?.status ?? 0,
        depositorDbEmp: isDepositorDBEmployeeSelectedValue,
        inputDate: inputDate,
        foundDate: foundDate,
        entrySecurity: entrySecurity,
        handoverSecurity: handoverSecurity,
        location: location,
        depositorName: isDepositorDBEmployeeSelected == 1
            ? selecteddepositorList?.name ?? ''
            : depositorTextController.text.isNotEmpty
                ? depositorTextController.text
                : '',
        claimantName: isClaimantDBEmployeeSelected == 1
            ? selectedClaimList?.name ?? ''
            : claimantTextController.text.isNotEmpty
                ? claimantTextController.text
                : '',
        depositor: depositor,
        depositorDepartment: depositorDepartment,
        employeeId: depositorEmpIdTextController.text.isNotEmpty
            ? depositorEmpIdTextController.text
            : '');
    found.eventProtection = widget.eventId;
    CreateFoundRequestBody requestBody = CreateFoundRequestBody(found: found);
    // showLoadingDialog(context);
    await createFoundArticleCubit.createNewFoundArticle(
      requestBody,
      isSubmit,
      context,
      username,
      widget.model != null ? Constants.editFound : Constants.createFound,
    );
    var userid = await SharedPrefs.getUserId();
    await foundListArticleCubit.getFoundList(
        pageNumber.toString(), '20', userid, context);
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
      if (widget.model == null) {
        await createFoundArticleCubit.getUserDetails(userid, context);
      }
    } else {
      Utils.showAlertMessage("No Network connection", context);
    }
  }

  void _getCurrentDate() {
    final currentDate = DateTime.now();
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(currentDate);
    //you can implement different kind of Date Format here according to your requirement
    dateOfCreationTextController.text = formattedDate;
    statusTextController.text = 'Found';
    handedoverdatedateTextController.text = formattedDate;
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  createFoundValidations(BuildContext context) {
    if (statusTextController.text.isEmpty &&
        createdByValue.isEmpty &&
        (locationSelectedlist?.name ?? "").isEmpty &&
        dateOfCreationTextController.text.isEmpty &&
        serialNumber.isEmpty &&
        assetTypeTextController.text.isEmpty &&
        (selectedArtclelist?.name ?? "").isEmpty &&
        foundDateTextController.text.isEmpty &&
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
    } else if (dateOfCreationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator date",
      );
    } else if (serialNumber.isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } else if (assetTypeTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter asset type",
      );
    } else if ((selectedArtclelist?.name ?? "").isEmpty) {
      Validator().showToast(
        context,
        "Please enter article type",
      );
    } else if (foundDateTextController.text.isEmpty) {
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
      } else if (isClaimantAcceptedtoSignSelected == 0) {
        Validator().showToast(context,
            "Please Save instead of initiate Claimant confirmation process");
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
      if (widget.model != null && widget.model?.status != 0) {
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
        } else if (widget.model?.status != 0 &&
            isClaimantDBEmployeeSelected == 0 &&
            claimantTextController.text.isEmpty) {
          log('--isClaimantDBEmployeeSelected--$isClaimantDBEmployeeSelected-------');
          if (claimant.isEmptyOrNull) {
            Validator().showToast(context, "Please enter claim");
          }
        } else {
          submitForm(true, widget.model?.id ?? 0);
        }
      } else {
        submitForm(true, widget.model?.id ?? 0);
      }
    }
  }

  assetTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSimpleListTexts(
          texts: const ["Personal", "company"],
          onTap: (String value) {
            assetTypeTextController.text = value;
            setState(() {});
          },
        );
      },
    );
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
            onTap: (Organisation list) {
              selectedArtclelist = list;
              setState(() {});
              FocusScope.of(context).requestFocus(foundLocationFocusNode);
            },
          );
        });
  }

  datePickerDialog(TextEditingController textfield) async {
    await showDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    //you can implement different kind of Date Format here according to your requirement
    if (textfield == handedoverdatedateTextController) {
      handedoverdatedateTextController.text =
          DateFormat(Constants.fulldateFormat).format(DateTime.now());
    }
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

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
            onTap: (Organisation department) {
              if (name == Constants.employeedepartment) {
                log('--department--${department.name}--');
                selectedEmployeedepartment = department;

                log('--selectedEmployeedepartment--${selectedEmployeedepartment?.name}--');
              } else {
                selectedClaimdepartment = department;
              }
              setState(() {});
            },
          );
        });
  }

  initiallyLocationandSerialnumberdataset(CreateFoundState state) async {
    if (locationSelectedlist == null &&
        state.getLocationsResponse != null &&
        widget.model == null) {
      locationSelectedlist = Organisation(id: 323, name: "SunGard");
      locationselectedText = 'SunGard';
    }
  }

  FocusNode depositorEmployeeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    bool isDisabled = false;
    return BlocConsumer<CreateFoundArticleCubit, CreateFoundState>(
      listener: (context, state) {
        log('-state.status----${state.status}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.generalInformation,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                articleFoundListRoute,
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }

        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
          return;
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppHeader(
              isTitleCenter: false,
              title: widget.model != null
                  ? Constants.editFound
                  : Constants.createFound,
              backBtn: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pop(context);
                  // Navigator.popAndPushNamed(
                  //   context,
                  //   articleFoundListRoute,
                  // );
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.white),
              ),

              action: [
                Visibility(
                  visible:
                      widget.model?.status != 2 && widget.model?.status != -1,
                  child: GestureDetector(
                    onTap: () {
                      //for now the new param is isSubmit added, if any new params needed we can add to this.
                      //createNewuserBody(false); //for save
                      //createdraftValidations(context);
                      submitForm(false, 0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SvgPicture.asset(
                        AppIcon.createfoundsaveicon,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      widget.model?.status != -1 && widget.model?.status != 2,
                  child: GestureDetector(
                    onTap: () async {
                      //loginFormKey.currentState!.validate();
                      FocusScope.of(context).unfocus();
                      createFoundValidations(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.send,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              //backgroundColor: AppColors.navigationSkybluecolor,
            ),
            backgroundColor: AppColors.backgroundWhiteColor,
            body: BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
              builder: (context, state) {
                if (state.status == FormStatus.loading) {
                  return const BaseLoader();
                }
                // if (widget.model?.status == 2) {
                //   isDisabled = true;
                // }

                if (widget.extraProperties != null &&
                    !widget.extraProperties!.hasWritePermission!) {
                  isDisabled = true;
                }
                createfoundResponse = state.createFoundResponse;

                if (state.status == FormStatus.addAttachment) {
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
                if (widget.model == null) {
                  userDetails = state.loggedInUser ?? User();
                  handOverSecurity = state.loggedInUser ?? User();
                  if (userDetails != null) {
                    createdByValue =
                        '${userDetails?.firstName ?? ''} ${userDetails?.lastName ?? ''}';
                  }
                  if (handOverSecurity != null) {
                    handOverByValue =
                        '${handOverSecurity?.firstName ?? ''} ${handOverSecurity?.lastName ?? ''}';
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
                  color: AppColors.navigationSkyBlueColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.01,
                          color: AppColors.navigationSkyBlueColor,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const ShapeDecoration(
                              color: AppColors.backgroundWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                              )),
                          child: AbsorbPointer(
                            absorbing: isDisabled,
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Status
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundStatus ??
                                          state.labels?.defaultLocale
                                              .foundStatus ??
                                          Constants.status,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    isEnable: false,
                                    isDisableColor: true,
                                    controller: statusTextController,
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
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.textGreyThemeColor,
                                            BlendMode.srcIn,
                                          ),
                                          // color: AppColors.textgreyThemecolor,
                                          width: 10,
                                          height: 10,
                                          key: const Key(Keys.userIcon),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Created By
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.foundEntrySecurity ??
                                          state.labels?.defaultLocale
                                              .foundEntrySecurity ??
                                          Constants.createdby,
                                      isMandatory: true,
                                      '${widget.model != null ? widget.model?.entrySecurity?.firstName : state.loggedInUser?.firstName ?? ''} ${widget.model != null ? widget.model?.entrySecurity?.lastName : state.loggedInUser?.lastName ?? ''}'),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Location
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundLocation ??
                                          state.labels?.defaultLocale
                                              .foundLocation ??
                                          Constants.location,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  locationWidgetdislay(state),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// date of creation
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundInputDate ??
                                          state.labels?.defaultLocale
                                              .foundInputDate ??
                                          Constants.dateofcreation,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  datecreateWidgetdisplay(),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// slno

                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.foundSlNo ??
                                          state.labels?.defaultLocale
                                              .foundSlNo ??
                                          Constants.slno,
                                      serialNumber,
                                      isMandatory: true),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// asset type
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundTypeOfAsset ??
                                          state.labels?.defaultLocale
                                              .foundTypeOfAsset ??
                                          Constants.assettype,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  //Text('-${assetTypeTextController.text}---'),
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.model?.status == 0 ||
                                          widget.model == null) {
                                        assetTypeDialog();
                                      }
                                    },
                                    child: FlutterInputField(
                                        isEnable: false,
                                        isDisableColor:
                                            widget.model?.status == 0
                                                ? false
                                                : true,
                                        // initialValue: assettypeTextController,
                                        controller: assetTypeTextController,
                                        textFormKey:
                                            Keys.assetTypeTextControllerKey,
                                        hintText: '',
                                        onChange: (String username) {
                                          //this.username = username;
                                          setState(() {});
                                        },
                                        onTap: () {
                                          if (widget.model?.status == 0 ||
                                              widget.model == null) {
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
                                              assetTypeDialog();
                                            })),
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// article type
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundTypeOfArticle ??
                                          state.labels?.defaultLocale
                                              .foundTypeOfArticle ??
                                          Constants.articleType,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  articleaddButtonwidgetLoading(state),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Found date
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundFoundDate ??
                                          state.labels?.defaultLocale
                                              .foundFoundDate ??
                                          Constants.founddate,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  BaseDate().datePickerWidgetLoading(
                                    showFutureDate: false,
                                    textController: foundDateTextController,
                                    isDisabled: (widget.model?.status != 0 || widget.model != null)
                                        ? false
                                        : true,
                                    //initialDate: DateTime.now().subtract(Duration(days: 1)),
                                    onChange: (String value) {
                                      widget.model?.foundDate =
                                          Utils().formatTime(value);
                                    },
                                    context: context,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Found location
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundFoundLocation ??
                                          state.labels?.defaultLocale
                                              .foundFoundLocation ??
                                          Constants.foundlocation,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: foundLocationTextController,
                                    textFormKey:
                                        Keys.foundLocationTextController,
                                    hintText: '',
                                    focusNode: foundLocationFocusNode,
                                    isEnable: widget.model?.status == 0 ||
                                            widget.model == null
                                        ? true
                                        : false,
                                    isDisableColor: widget.model?.status == 0
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// additional information
                                  CommonWidgets
                                      .textDisplay(
                                          state.labels?.locale
                                                  .foundAdditionalInformation ??
                                              state.labels?.defaultLocale
                                                  .foundAdditionalInformation ??
                                              Constants.additionalinformation,
                                          Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    showBorder: true,
                                    lineHeight: 6,
                                    controller:
                                        additionalinformationTextController,
                                    textFormKey: Keys
                                        .additionalinformationTextController,
                                    hintText: Constants.informationhere,
                                    isEnable: widget.model?.status == 0 ||
                                            widget.model == null
                                        ? true
                                        : false,
                                    isDisableColor: widget.model?.status == 0 ||
                                            widget.model == null
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      // additionalinformationTextController.text += '\n';
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                    onFieldSubmitted: (String value) {
                                      additionalinformationTextController
                                          .value = TextEditingValue(
                                        text:
                                            '${additionalinformationTextController.text}\n',
                                        selection: TextSelection.collapsed(
                                          offset:
                                              additionalinformationTextController
                                                      .text.length +
                                                  1,
                                        ),
                                      );
                                    },
                                  ),

                                  /// quantitiy
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundQuantity ??
                                          state.labels?.defaultLocale
                                              .foundQuantity ??
                                          Constants.quantity,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.number,
                                    controller: quantityTextController,
                                    textFormKey: Keys.quantityTextController,
                                    hintText: '',
                                    isEnable: widget.model?.status == 0 ||
                                            widget.model == null
                                        ? true
                                        : false,
                                    isDisableColor: widget.model?.status == 0
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// color
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundColor ??
                                          state.labels?.defaultLocale
                                              .foundColor ??
                                          Constants.colour,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: colorTextController,
                                    textFormKey: Keys.colorTextController,
                                    hintText: '',
                                    isEnable: widget.model?.status == 0 ||
                                            widget.model == null
                                        ? true
                                        : false,
                                    isDisableColor: widget.model?.status == 0
                                        ? false
                                        : true,
                                    onChange: (String username) {
                                      //this.username = username;
                                      setState(() {});
                                    },
                                    validateTextField: (String? user) {},
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// is Depositor DBEmployee
                                  CommonWidgets
                                      .textDisplay(
                                          state.labels?.locale
                                                  .foundDepositorDbEmp ??
                                              state.labels?.defaultLocale
                                                  .foundDepositorDbEmp ??
                                              Constants.isdepositordbemployee,
                                          Styles.textStyleBlack14,
                                          isMandatory: true),
                                  radioButtonHandling(
                                      isDepositorDBEmployeeSelected,
                                      Constants.isdepositordbemployee,
                                      isDisableColor:
                                          (widget.model?.status == null ||
                                                  widget.model?.status == 0)
                                              ? false
                                              : true),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  /// depositor
                                  CommonWidgets.textDisplay(
                                      state.labels?.locale.foundDepositor ??
                                          state.labels?.defaultLocale
                                              .foundDepositor ??
                                          Constants.depositor,
                                      Styles.textStyleBlack14,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  isDepositorDBEmployeeSelected == 1
                                      ? TextFieldAddButton(
                                          title: selecteddepositorList?.name !=
                                                  null
                                              ? ('${selecteddepositorList?.name ?? ''}(${selecteddepositorList?.email ?? ''})')
                                              : '',
                                          height: 70,
                                          isDisableColor:
                                              widget.model?.status == 1 ||
                                                      widget.model?.status ==
                                                          2 ||
                                                      widget.model?.status == -1
                                                  ? true
                                                  : false,
                                          onTap: () {
                                            if (widget.model?.status == 0 ||
                                                widget.model == null) {
                                              depositorDialog(
                                                  state, Constants.depositor);
                                              FocusScope.of(context).requestFocus(
                                                  depositorEmployeeFocusNode);
                                            }
                                          })
                                      : FlutterInputField(
                                          controller: depositorTextController,
                                          textFormKey:
                                              Keys.depositorTextController,
                                          hintText: '',
                                          isEnable: widget.model?.status == 0 ||
                                                  widget.model == null
                                              ? true
                                              : false,
                                          isDisableColor:
                                              widget.model?.status != 0
                                                  ? false
                                                  : true,
                                          onChange: (String username) {
                                            //this.username = username;
                                            setState(() {});
                                          },
                                          validateTextField: (String? user) {},
                                        ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Depositor Employee id
                                  isDepositorDBEmployeeSelected == 1
                                      ? CommonWidgets
                                          .textDisplay(
                                              state.labels?.locale
                                                      .foundEmployeeId ??
                                                  state.labels?.defaultLocale
                                                      .foundEmployeeId ??
                                                  Constants.depositoremployeeid,
                                              Styles.textStyleBlack14,
                                              isMandatory: true)
                                      : Container(),
                                  isDepositorDBEmployeeSelected == 1
                                      ? CommonWidgets.verticalSpacerWidget(
                                          height * 0.001)
                                      : Container(),

                                  isDepositorDBEmployeeSelected == 1
                                      ? FlutterInputField(
                                          controller:
                                              depositorEmpIdTextController,
                                          textFormKey:
                                              Keys.depositorEmpIdTextController,
                                          hintText: '',
                                          isEnable:
                                              (widget.model?.status == null ||
                                                      widget.model?.status == 0)
                                                  ? true
                                                  : false,
                                          isDisableColor:
                                              widget.model?.status != 0
                                                  ? false
                                                  : true,
                                          focusNode: depositorEmployeeFocusNode,
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

                                  /// Employee department
                                  isDepositorDBEmployeeSelected == 1
                                      ? CommonWidgets.textDisplay(
                                          state.labels?.locale
                                                  .foundEmployeeDepartment ??
                                              state.labels?.defaultLocale
                                                  .foundEmployeeDepartment ??
                                              Constants.employeedepartment,
                                          Styles.textStyleBlack14,
                                          isMandatory: true)
                                      : Container(),
                                  isDepositorDBEmployeeSelected == 1
                                      ? CommonWidgets.verticalSpacerWidget(
                                          height * 0.001)
                                      : Container(),
                                  isDepositorDBEmployeeSelected == 1
                                      ? TextFieldAddButton(
                                          title: selectedEmployeedepartment
                                                  ?.name ??
                                              '',
                                          height: 60,
                                          isDisableColor:
                                              widget.model?.status == 1 ||
                                                      widget.model?.status ==
                                                          2 ||
                                                      widget.model?.status == -1
                                                  ? true
                                                  : false,
                                          onTap: () {
                                            if (widget.model == null ||
                                                widget.model?.status == 0) {
                                              employeeDepartmentDialog(
                                                  state,
                                                  state.labels?.locale
                                                          .foundEmployeeDepartment ??
                                                      state
                                                          .labels
                                                          ?.defaultLocale
                                                          .foundEmployeeDepartment ??
                                                      Constants
                                                          .employeedepartment);
                                            }
                                          },
                                        )
                                      : Container(),
                                  widget.model != null &&
                                          isDepositorDBEmployeeSelected == 1
                                      ? CommonWidgets.verticalSpacerWidget(
                                          height * 0.01)
                                      : Container(),

                                  if (widget.model?.status == 1 ||
                                      widget.model?.status == 2) ...[
                                    /// is claimant db employee
                                    widget.model?.status != null
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .foundClaimantDbEmp ??
                                                state.labels?.defaultLocale
                                                    .foundClaimantDbEmp ??
                                                Constants.isclaimantdbemployee,
                                            Styles.textStyleBlack14,
                                            isMandatory: true)
                                        : Container(),
                                    widget.model != null
                                        ? radioButtonHandling(
                                            isClaimantDBEmployeeSelected,
                                            isDisableColor: (widget
                                                            .model?.status ==
                                                        2 ||
                                                    isClaimantAcceptedByemail !=
                                                        0)
                                                ? true
                                                : false,
                                            Constants.isclaimantdbemployee,
                                          )
                                        : Container(),

                                    ///claimant
                                    CommonWidgets.textDisplay(
                                        state.labels?.locale.foundClaimant ??
                                            state.labels?.defaultLocale
                                                .foundClaimant ??
                                            Constants.claimant,
                                        Styles.textStyleBlack14,
                                        isMandatory: true),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    isClaimantDBEmployeeSelected == 1
                                        ? TextFieldAddButton(
                                            title: selectedClaimList?.name !=
                                                    null
                                                ? ('${selectedClaimList?.name ?? ''}(${selectedClaimList?.email ?? ''})')
                                                : '',
                                            height: 70,
                                            isDisableColor: widget
                                                            .model?.status !=
                                                        2 &&
                                                    isClaimantAcceptedByemail ==
                                                        0
                                                ? false
                                                : true,
                                            onTap: () {
                                              if (widget.model?.status != 2 &&
                                                  isClaimantAcceptedByemail ==
                                                      0) {
                                                depositorDialog(
                                                    state,
                                                    state.labels?.locale
                                                            .foundClaimant ??
                                                        state
                                                            .labels
                                                            ?.defaultLocale
                                                            .foundClaimant ??
                                                        Constants.claimant);
                                              }
                                            })
                                        : FlutterInputField(
                                            controller: claimantTextController,
                                            textFormKey:
                                                Keys.claimantTextController,
                                            hintText: '',
                                            isEnable:
                                                widget.model?.status == 0 ||
                                                        widget.model == null || widget.model?.status == 2
                                                    ? false
                                                    : true,
                                            isDisableColor:
                                                widget.model?.status != 0
                                                    ? false
                                                    : true,
                                            onChange: (String username) {
                                              //this.username = username;
                                              setState(() {});
                                            },
                                            validateTextField:
                                                (String? user) {},
                                          ),

                                    /// Claimant employee id
                                    widget.model != null &&
                                            isClaimantDBEmployeeSelected == 1
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .foundClaimantEmployeeId ??
                                                state.labels?.defaultLocale
                                                    .foundClaimantEmployeeId ??
                                                Constants.claimantemployeeid,
                                            Styles.textStyleBlack14,
                                            isMandatory: true)
                                        : Container(),
                                    widget.model != null &&
                                            isClaimantDBEmployeeSelected == 1
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    widget.model != null &&
                                            isClaimantDBEmployeeSelected == 1
                                        ? FlutterInputField(
                                            textInputType: TextInputType.text,
                                            controller:
                                                claimantEmpIdTextController,
                                            textFormKey: Keys
                                                .claimantEmpIdTextController,
                                            isEnable: widget.model?.status !=
                                                        2 &&
                                                    isClaimantAcceptedByemail ==
                                                        0
                                                ? true
                                                : (widget.model != null &&
                                                        (widget.model
                                                                    ?.claimantEmployeeId ??
                                                                '')
                                                            .isEmpty)
                                                    ? true
                                                    : false,
                                            isDisableColor:
                                                (widget.model?.status != 2)
                                                    ? false
                                                    : true,
                                            hintText: '',
                                            onChange: (String username) {
                                              //this.username = username;
                                              setState(() {});
                                            },
                                            validateTextField:
                                                (String? user) {},
                                          )
                                        : Container(),

                                    widget.model != null &&
                                            isClaimantDBEmployeeSelected == 1
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    /// claimant department
                                    widget.model != null &&
                                            isClaimantDBEmployeeSelected == 1
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .foundClaimantDbEmp ??
                                                state.labels?.defaultLocale
                                                    .foundClaimantDbEmp ??
                                                Constants.claimantdepartment,
                                            Styles.textStyleBlack14,
                                            isMandatory: true)
                                        : Container(),
                                    isClaimantDBEmployeeSelected == 1
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    widget.model != null &&
                                            isClaimantDBEmployeeSelected == 1
                                        ? TextFieldAddButton(
                                            title: (selectedClaimdepartment
                                                    ?.name ??
                                                ''),
                                            height: 60,
                                            isDisableColor: widget
                                                            .model?.status !=
                                                        2 &&
                                                    isClaimantAcceptedByemail ==
                                                        0
                                                ? false
                                                : true,
                                            onTap: () {
                                              if (widget.model?.status != 2 &&
                                                  isClaimantAcceptedByemail ==
                                                      0) {
                                                employeeDepartmentDialog(
                                                    state,
                                                    state.labels?.locale
                                                            .foundClaimantDbEmp ??
                                                        state
                                                            .labels
                                                            ?.defaultLocale
                                                            .foundClaimantDbEmp ??
                                                        Constants
                                                            .claimantdepartment);
                                              }
                                            },
                                          )
                                        : Container(),
                                    isClaimantDBEmployeeSelected == 1
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    if (isClaimantDBEmployeeSelected == 1) ...[
                                      /// is claimant accepted to sign
                                      widget.model != null
                                          ? CommonWidgets.textDisplay(
                                              state.labels?.locale
                                                      .foundClaimantNoSign ??
                                                  state.labels?.defaultLocale
                                                      .foundClaimantNoSign ??
                                                  Constants
                                                      .isclaimantacceptedtosign,
                                              Styles.textStyleBlack14,
                                              isMandatory: true)
                                          : Container(),
                                      widget.model != null
                                          ? radioButtonHandling(
                                              isClaimantAcceptedtoSignSelected,
                                              state.labels?.locale
                                                      .foundClaimantNoSign ??
                                                  state.labels?.defaultLocale
                                                      .foundClaimantNoSign ??
                                                  Constants
                                                      .isclaimantacceptedtosign,
                                              // isDisableColor: isDisabled,
                                              isDisableColor: (widget
                                                              .model?.status ==
                                                          2 ||
                                                      isClaimantAcceptedByemail !=
                                                          0)
                                                  ? true
                                                  : false,
                                            )
                                          : Container(),

                                      ///TODO: Need to work on signature
                                      if (isClaimantAcceptedtoSignSelected ==
                                          1) ...[
                                        /// Claimant Signature
                                        buildSignature(
                                          controller:
                                              claimantSignatureController,
                                          label: Constants.claimantSignature,
                                          spaceHeight: height,
                                          state: state,
                                        ),
                                      ],

                                      /// is claimant confirmed by email

                                      widget.model != null &&
                                              isClaimantAcceptedtoSignSelected ==
                                                  0
                                          ? CommonWidgets.textDisplay(
                                              state.labels?.locale
                                                      .foundClaimantConfirmByEmail ??
                                                  state.labels?.defaultLocale
                                                      .foundClaimantConfirmByEmail ??
                                                  Constants
                                                      .isclaimantacceptedbyemail,
                                              Styles.textStyleBlack14,
                                              isMandatory: true)
                                          : Container(),
                                      widget.model != null &&
                                              isClaimantAcceptedtoSignSelected ==
                                                  0
                                          ? radioButtonHandling(
                                              isClaimantAcceptedByemail,
                                              state.labels?.locale
                                                      .foundClaimantConfirmByEmail ??
                                                  state.labels?.defaultLocale
                                                      .foundClaimantConfirmByEmail ??
                                                  Constants
                                                      .isclaimantacceptedbyemail,
                                              isDisableColor: widget
                                                              .model?.status !=
                                                          2 ||
                                                      widget.model?.status !=
                                                          1 ||
                                                      widget.model?.status != -1
                                                  ? !isDisabled
                                                  : isDisabled,
                                            )
                                          : Container(),
                                    ],
                                  ],

                                  /// Item Handover By
                                  if (widget.model?.status == 2 ||
                                      widget.model?.status == 1) ...[
                                    CommonWidgets.horizentaltextHandling(
                                        state.labels?.locale
                                                .foundHandoverSecurity ??
                                            state.labels?.defaultLocale
                                                .foundHandoverSecurity ??
                                            Constants.itemhandoverby,
                                        // widget.model?.status == 2
                                        //     ? '${state.loggedInUser?.firstName ?? ''} ${state.loggedInUser?.lastName ?? ''}'
                                        //     : '',
                                        '${widget.model?.handoverSecurity != null ? widget.model?.handoverSecurity?.firstName : state.loggedInUser?.firstName ?? ''} ${widget.model?.handoverSecurity != null ? widget.model?.handoverSecurity?.lastName : state.loggedInUser?.lastName ?? ''}',
                                        isMandatory: true),

                                    /// Handed over date

                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.foundHandoverDate ??
                                          state.labels?.defaultLocale
                                              .foundHandoverDate ??
                                          Constants.handedoverdate,
                                      Styles.textStyleBlack14,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datepickerWidgetLoading(
                                        handedoverdatedateTextController),
                                  ],
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// upload
                                  widget.model == null ||
                                          widget.model?.status == 0
                                      ? Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xFFCACACA),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8))),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      fixedSize:
                                                          const Size(140, 50),
                                                      backgroundColor: AppColors
                                                          .navigationSkyBlueColor,
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              dialogContext) {
                                                            return UploadAttachment(
                                                              userdetails:
                                                                  userDetails,
                                                              getFiles:
                                                                  getFiles,
                                                              createoundstate:
                                                                  state,
                                                            );
                                                          });
                                                    },

                                                    icon: SvgPicture.asset(
                                                      AppIcon.uploadicon,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        AppColors
                                                            .backgroundWhiteColor,
                                                        BlendMode.srcIn,
                                                      ),
                                                      width: 13,
                                                      height: 13,
                                                      key: const Key(
                                                          Keys.userIcon),
                                                    ),

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

                                  // getFiles.isNotEmpty ||
                                  //         getAttachments.isNotEmpty
                                  //     ? CommonWidgets.verticalSpacerWidget(
                                  //         height * 0.01)
                                  //     : Container(),
                                  // (getAttachments.isEmpty ||
                                  //         widget.model == null)
                                  //     ? getFiles.isEmpty
                                  //         ? Container()
                                  //         : attachmentListviews(
                                  //             getFiles, getAttachments)
                                  //     : attachmentListviews(
                                  //         getFiles, getAttachments),

                                  // if (!getAttachments.isEmptyOrNull ) ...[
                              BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: getAttachments.isEmptyOrNull
                                        ? getFiles
                                        : getAttachments,
                                    files: getFiles.isEmptyOrNull
                                        ? getAttachments
                                        : getFiles,
                                    showDownloadIcon:
                                        widget.model != null ? true : false,
                                    moduleCode:
                                        Constants.articleFoundModuleCode,
                                  ),
                                  // ],

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  if (widget.model?.status != 2 &&
                                      widget.model?.status != -1) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        cancelButtonDisplay(),
                                        submitButtonDisplay(state)
                                      ],
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.03),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),

                        if (widget.model?.status == 2 ||
                            widget.model?.status == -1) ...[
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const ShapeDecoration(
                              color: AppColors.backgroundWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(00.0)),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                cancelButtonDisplay(),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }

  Column buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required CreateFoundState state,
  }) {
    bool isEditable = false;
    bool isSigned = false;

    isSigned = widget.model?.claimantSign != null &&
        !widget.model!.claimantSign!.imageContent.isEmptyOrNull;
    isEditable = true;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidgets.textDisplay(
              label,
              Styles.textStyleBlack14,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.clear();

                    // BlocProvider.of<MaterialMovementDetailsCubit>(context)
                    //     .makeSignEditable(receiverSign: true);
                  },
                  iconSize: 20,
                  color: Colors.grey,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
        CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
        ClipRect(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(
                color: AppColors.geryLightBackground,
                width: 1, // Border width
              ),
            ),
            height: 100,
            width: double.infinity,
            child: (isEditable && isSigned)
                ? Image.memory(
                    Uint8List.fromList(
                      base64Decode(
                        widget.model?.claimantSign!.imageContent ?? '',
                      ),
                    ),
                    fit: BoxFit.none,
                  )
                : Signature(
                    controller: controller,
                    backgroundColor: Colors.white,
                  ),
          ),
        ),
        CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
      ],
    );
  }

  Future<void> pushSignature({
    required SignatureController controller,
  }) async {
    String imageBytes = await SignatureController().exportSignature(controller);

    // Check for null explicitly
    if (imageBytes.isEmpty) {
      return;
    }

    ImageContent imageContent = ImageContent();
    imageContent.imageContent = imageBytes;

    log('--imageBytes--$imageBytes--');

    widget.model?.claimantSign ??= ImageContent();
    widget.model?.claimantSign = imageContent;
    // if (isReceiverSignature) {
    //   imageContent.type = 2;
    //   state.model.receiverSign = imageContent;
    //   emit(state.copyWith(
    //     model: state.model,
    //   ));
    // } else {
    //   imageContent.type = 3;
    //   state.model.entrySecuritySign = imageContent;
    //   emit(state.copyWith(
    //     model: state.model,
    //   ));
    // }
  }

  Widget submitButtonDisplay(CreateFoundState state) {
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
        createFoundValidations(context);
      },
    );
  }

  Widget cancelButtonDisplay() {
    bool condition = widget.model?.id == null ||
        widget.model?.status == ConstantsIntValue.cancelledStatus ||
        widget.model?.status ==
            ConstantsIntValue.articleFoundStatusHandedOverOrClaimed;
    return AppButton(
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: condition ? Constants.close : Constants.cancelRecord,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        if (condition) {
          Navigator.pop(context);
          return;
        }
        var dialog = CustomAlertDialog(
            title: Constants.cancelRecord,
            message: Constants.cancelRecordWarningMessage,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              updateRecordStatus();
            },
            positiveBtnText: Constants.yes,
            negativeBtnText: Constants.no);
        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );
  }

  void updateRecordStatus() {
    if (widget.model?.id != null) {
      BlocProvider.of<CreateFoundArticleCubit>(context)
          .updateStatus(id: widget.model!.id.toString());
      Navigator.popAndPushNamed(
        context,
        articleFoundListRoute,
      );
    } else {
      Navigator.pop(context);
    }
  }

  Widget locationWidgetdislay(CreateFoundState state) {
    return GestureDetector(
      onTap: () {
        if (widget.model?.status == null || widget.model?.status == 0) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return CustomExpansionListTexts(
                locationList: state.getLocationsResponse ?? Locations(),
                onTap: (Organisation? list) async {
                  await createFoundArticleCubit.getSerialnumberDetails(
                      list?.id.toString() ?? '', Constants.articleFoundModuleCode, context);
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
                color: const Color(0xFFCACACA),
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
                              AppColors.normalTextBackground),
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
      controller: dateOfCreationTextController,
      textFormKey: Keys.dateofcreationTextController,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String username) {
        //this.username = username;
        //setState(() {});
      },
      validateTextField: (String? user) {},
    );
  }

  Widget radioButtonHandling(
    int selectedValue,
    String name, {
    bool? isDisableColor = false,
  }) {
    isDisableColor ??= widget.model?.status == 1 || widget.model?.status == 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: isDisableColor
              ? AppColors.disableTextFieldBackground
              : AppColors.navigationSkyBlueColor,
          // focusColor:
          //     AppColors.navigationSkybluecolor,

          value: 1,
          groupValue: selectedValue,
          onChanged: (val) {
            radioButtonItem = 'Yes';
            selectedValue = 1;
            if (name == Constants.isclaimantacceptedtosign &&
                widget.model?.status != 2 &&
                isClaimantAcceptedByemail == 0) {
              isClaimantAcceptedtoSignSelected = selectedValue;
            } else if ((name == Constants.isclaimantacceptedbyemail) &&
                widget.model?.status != 2 &&
                widget.model?.status != 1 &&
                widget.model?.status != -1) {
              isClaimantAcceptedByemail = selectedValue;
            } else if (name == Constants.isclaimantdbemployee &&
                widget.model?.status == 1 &&
                widget.model?.status != 2 &&
                isClaimantAcceptedByemail == 0) {
              isClaimantDBEmployeeSelected = selectedValue;
            } else if (name == Constants.isdepositordbemployee &&
                widget.model?.status != 1 &&
                widget.model?.status != 2 &&
                widget.model?.status != -1) {
              isDepositorDBEmployeeSelected = selectedValue;
            }
            setState(() {});
          },
        ),
        const Text(Constants.yes),
        Radio(
            activeColor: isDisableColor
                ? AppColors.disableTextFieldBackground
                : AppColors.navigationSkyBlueColor,
            value: 0,
            groupValue: selectedValue,
            onChanged: (val) {
              radioButtonItem = 'No';
              selectedValue = 0;
              if (name == Constants.isclaimantacceptedtosign &&
                  widget.model?.status != 2 &&
                  isClaimantAcceptedByemail == 0) {
                isClaimantAcceptedtoSignSelected = selectedValue;
              } else if ((name == Constants.isclaimantacceptedbyemail) &&
                  widget.model?.status != 2 &&
                  widget.model?.status != 1 &&
                  widget.model?.status != -1) {
                isClaimantAcceptedByemail = selectedValue;
              } else if (name == Constants.isclaimantdbemployee &&
                  widget.model?.status == 1 &&
                  widget.model?.status != 2 &&
                  isClaimantAcceptedByemail == 0) {
                isClaimantDBEmployeeSelected = selectedValue;
              } else if (name == Constants.isdepositordbemployee &&
                  widget.model?.status != 1 &&
                  widget.model?.status != 2 &&
                  widget.model?.status != -1) {
                isDepositorDBEmployeeSelected = selectedValue;
              }
              setState(() {});
            }),
        const Text(Constants.no),
      ],
    );
    //return Container();
  }

  Widget articleaddButtonwidgetLoading(CreateFoundState state) {
    return TextFieldAddButton(
      title: selectedArtclelist?.name ?? '',
      height: 60,
      isDisableColor: widget.model?.status == 1 ||
              widget.model?.status == 2 ||
              widget.model?.status == -1
          ? true
          : false,
      onTap: () {
        if (widget.model?.status == 0 || widget.model == null) {
          articleTypeDialog(state);
        }
      },
    );
  }

  Widget datepickerWidgetLoading(TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        log('-widget.listuser?.status----${widget.model?.status}----');
        if (widget.model?.status == null || widget.model?.status == 0) {
          datePickerDialog(controller);
        }
      },
      child: FlutterInputField(
        controller: controller,
        textFormKey: controller == foundDateTextController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor: widget.model?.status != 0 ? false : true,
        onChange: (String username) {
          //this.username = username;
          setState(() {});
        },
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (widget.model == null ||
                controller.text.isEmpty ||
                widget.model?.status == 0) {
              datePickerDialog(controller);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              colorFilter: const ColorFilter.mode(
                AppColors.textGreyThemeColor,
                BlendMode.srcIn,
              ),
              // color: AppColors.textGreyThemeColor,
              width: 20,
              key: const Key(Keys.userIcon),
            ),
          ),
        ),
      ),
    );
  }

  Widget attachmentListviews(
    List<ImageContent>? attachmentListviews,
    List<ImageContent>? attachmentListviews1,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (attachmentListviews1?.length ?? 0) >
                  (attachmentListviews?.length ?? 0)
              ? attachmentListviews1?.length
              : attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            ImageContent? imageData;
            ImageContent? imageData1;
            if (widget.model != null) {
              imageData1 = attachmentListviews1?[index];
            } else {
              imageData = attachmentListviews?[index];
            }
            log('--attachmentListviews1?.length--${attachmentListviews1?.length}');
            log('--attachmentListviews?.length--${attachmentListviews?.length}');

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.model?.status == null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Delete logic here
                                if (imageData1 != null) {
                                  // Implement delete functionality for attachmentListviews1
                                  setState(() {
                                    attachmentListviews1!.removeAt(index);
                                  });
                                }
                                if (imageData != null) {
                                  // Implement delete functionality for attachmentListviews1
                                  setState(() {
                                    attachmentListviews!.removeAt(index);
                                  });
                                }
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                // Add your download functionality here
                                DownloadImage().saveImage(
                                  context,
                                  imageData?.id ?? 0,
                                  imageData?.title ?? '',
                                  Constants.articleFoundModuleCode,
                                );
                              },
                              child: BaseIcons().downloadIcon(),
                            )
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            // Add your download functionality here
                            DownloadImage().saveImage(
                              context,
                              imageData?.id ?? 0,
                              imageData?.title ?? '',
                              Constants.articleFoundModuleCode,
                            );
                          },
                          child: BaseIcons().downloadIcon(),
                        ),
                  title: widget.model != null
                      ? Text(imageData1?.title ?? '')
                      : Text(imageData?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //                           <-- Divider
              ],
            );
          }),
    );
  }
}

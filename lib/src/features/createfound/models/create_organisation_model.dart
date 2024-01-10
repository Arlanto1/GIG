import 'dart:convert';

import '../../../models/organisation.dart';

Organisation createOrganisationFromJson(String str) =>
    Organisation.fromJson(json.decode(str));

String createOrganisationToJson(Organisation data) =>
    json.encode(data.toJson());

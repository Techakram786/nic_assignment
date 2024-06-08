import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/authority_model.dart';
import '../model/organization_model.dart';

class FormController extends GetxController {
  //todo Controllers for form fields
  var nameTextController = TextEditingController().obs;
  var textController = TextEditingController().obs;

  //todo Form key to validate form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var validChar = RegExp(r'').obs; //todo Define the regular expression
  RxInt minLength = 0.obs;
  RxInt maxLength = 0.obs;
  var isReEmployed = false.obs; // todo Initial value is false (No is selected)

  // todo List to hold organization data
  // Reactive dropdown value
  RxString? dropdownValue = ''.obs;
  RxString? dropdownValue1 = ''.obs;
  RxBool isDropdown1Selected = false.obs;

  // todo List to hold organization data
  late final RxList<OrganizationModel> organizations =
      <OrganizationModel>[].obs;
  late final RxList<AuthorityModel> authorityList = <AuthorityModel>[].obs;
  late final RxList<AuthorityModel> filteredAuthorityList =
      <AuthorityModel>[].obs;

  //todo Validate and submit the form
  void submitForm(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted')),
      );
    }
  }

  //todo for organization list data...
  final jsonString = '''
  [
    {"org_code": "11", "org_name": "Banks"},
    {"org_code": "2", "org_name": "Central Government"},
    {"org_code": "3", "org_name": "Central Govt Autonomous/Statutory organisation/body/Society"},
    {"org_code": "4", "org_name": "Central Govt PSU/Undertaking"},
    {"org_code": "8", "org_name": "Central Govt University/College/Educational Institutions"},
    {"org_code": "1", "org_name": "EPFO"},
    {"org_code": "10", "org_name": "Municipal Corporations/Local Bodies/Authorities"},
    {"org_code": "5", "org_name": "State Government/UT"},
    {"org_code": "6", "org_name": "State Govt Autonomous organisation/body"},
    {"org_code": "7", "org_name": "State Govt PSU"},
    {"org_code": "9", "org_name": "State University/College/Educational Institutions"}
  ]
  ''';

  //todo for authority list data...
  final jsonStringouth = '''
  [
    {
        "org_code": "7",
        "authority_code": "AAVINP",
        "authority_name": "Aavin Ex-gratia Pension and Family Pension - TN",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLAGVB",
        "authority_name": "Andhra Pradesh Grameena Vikas Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "6",
        "authority_code": "APPCBD",
        "authority_name": "Andhra Pradesh Pollution Control Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "APPGCL",
        "authority_name": "Andhra Pradesh Power Generation Corporation",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLAPGB",
        "authority_name": "Andhra Pragathi Grameena Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "AEEDS",
        "authority_name": "Atomic Energy Education Society",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "EDUBHU",
        "authority_name": "Banaras Hindu University",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|/",
        "ppo_valid_length": "7|12"
      },
      {
        "org_code": "10",
        "authority_code": "BWSSBD",
        "authority_name": "Bangalore Water Supply and Sewerage Board",
        "valid_rule": "8",
        "rule_status": "O",
        "ppo_valid_char": "0-9",
        "ppo_valid_length": "8|8"
      },
      {
        "org_code": "11",
        "authority_code": "BKSTAF",
        "authority_name": "Banking Staff",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLBRKG",
        "authority_name": "Baroda Rajasthan Kshetriya Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "BUPGB",
        "authority_name": "Baroda U.P Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "BHSPHC",
        "authority_name": "Bihar State Power(Holding) Company Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "MCGMB",
        "authority_name": "Brihanmumbai Municipal Corporation",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "BISTAN",
        "authority_name": "Bureau of Indian Standards(BIS)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CALDLB",
        "authority_name": "Calcutta Dock Labour Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CBSEHQ",
        "authority_name": "CBSE-HQ",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "CGOV",
        "authority_name": "Central Government",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "CGOVNP",
        "authority_name": "Central Government New Pension Scheme (NPS AR)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CPRIN",
        "authority_name": "Central Power Research Institute",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CSLKB",
        "authority_name": "Central Silk Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "CMWSSB",
        "authority_name": "Chennai Metropolitan Water Supply Sewerage Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "8|8"
      },
      {
        "org_code": "3",
        "authority_code": "TNCPT",
        "authority_name": "Chennai Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "CSPGCL",
        "authority_name": "Chhatisgarh State Power Generation Company Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "CSPTCL",
        "authority_name": "Chhatisgarh State Power Transmission Co. Ltd.",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "CRGB",
        "authority_name": "Chhattisgarh Rajya Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "4",
        "authority_code": "COALIL",
        "authority_name": "Coal India Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CMPFO",
        "authority_name": "Coal Mines Provident Fund Organisation",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CHNPT",
        "authority_name": "Cochin Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "CUSATK",
        "authority_name": "Cochin University of Science and Technology",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CCNTDB",
        "authority_name": "Coconut Development Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "COFFBI",
        "authority_name": "Coffee Board of India",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "CTNUNV",
        "authority_name": "Cotton University, Guwahati",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "CSIRES",
        "authority_name": "Council Of Scientific And Industrial Research",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "8|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLBHGB",
        "authority_name": "Dakshin Bihar Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "DAMVCO",
        "authority_name": "Damodar Valley Corporation",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "DNDPT",
        "authority_name": "Deendayal Port Trust ( Kandla Port Trust)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "DSPS",
        "authority_name": "Defence",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "DSPSAF",
        "authority_name": "Defence - Jt.CDA(AF), Subrato Park, Delhi Cantt",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "DSPSAR",
        "authority_name": "Defence - PCDA (P) Allahabad",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "DSPSNV",
        "authority_name": "Defence - PCDA(Navy) Mumbai",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "DELJAL",
        "authority_name": "Delhi Jal Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "EPDCAP",
        "authority_name": "Eastern Power Distribution Company of AP Ltd.",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "1",
        "authority_code": "EPFO",
        "authority_name": "EPFO",
        "valid_rule": "13",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "13|13"
      },
      {
        "org_code": "4",
        "authority_code": "GICRE",
        "authority_name": "General Insurance Corporation of India",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "GCHNCO",
        "authority_name": "Greater Chennai Corporation",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "1|20"
      },
      {
        "org_code": "7",
        "authority_code": "GPTFA",
        "authority_name": "Gridco Pension Fund, Odisha",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "6",
        "authority_code": "GMBEPT",
        "authority_name": "Gujarat Maritime Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9",
        "ppo_valid_length": "1|6"
      },
      {
        "org_code": "3",
        "authority_code": "HDCKPT",
        "authority_name": "Haldia Dock Complex Kolkata Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "HRVPNL",
        "authority_name": "Haryana Vidyut Prasaran Nigam Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLHPGB",
        "authority_name": "Himachal Pradesh Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "HPSEBL",
        "authority_name": "Himachal Pradesh State Electricity Board Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "HMWSSB",
        "authority_name": "Hyderabad Metropolitan Water Supply Sewerage Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "IITBO",
        "authority_name": "IIT Bombay",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "IITKA",
        "authority_name": "IIT Kanpur",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "IITKGP",
        "authority_name": "IIT Kharagpur",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "IITMA",
        "authority_name": "IIT Madras",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "IITDH",
        "authority_name": "IIT(ISM) Dhanbad",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "CAGIAA",
        "authority_name": "Indian Audit and Accounts Department (IA and AD)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "ISINTK",
        "authority_name": "Indian Statistical Institute - Kolkata",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "INSTPR",
        "authority_name": "Institute for Plasma Research",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "IHMCTN",
        "authority_name": "Institute of Hotel Management, Hajipur",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "MHJNPT",
        "authority_name": "Jawaharlal Nehru Port Authority",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "JLNTUH",
        "authority_name": "Jawaharlal Nehru Technological University HYD",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "JHBVNL",
        "authority_name": "Jharkhand Bijli Vitran Nigam Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLJRGB",
        "authority_name": "Jharkhand Rajya Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "JHUSNL",
        "authority_name": "Jharkhand Urja Sancharan Nigam Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "JHUUNL",
        "authority_name": "Jharkhand Urja Utpadan Nigam Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "JHUVNL",
        "authority_name": "Jharkhand Urja Vikas Nigam Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLKAGB",
        "authority_name": "Karnataka Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "KPCLTD",
        "authority_name": "Karnataka Power Corporation Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLKVGB",
        "authority_name": "Karnataka Vikas Grameena Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "KLAGUN",
        "authority_name": "Kerala Agricultural University (KAU)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "KWA",
        "authority_name": "Kerala Water Authority",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "6",
        "authority_code": "KMIONC",
        "authority_name": "Kidwai Memorial Institute of Oncology",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "KPTCLD",
        "authority_name": "KPTCL and ESCOMs",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|:|/|,|-",
        "ppo_valid_length": "2|12"
      },
      {
        "org_code": "4",
        "authority_code": "LICOI",
        "authority_name": "Life Insurance Corporation of India",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLMPGB",
        "authority_name": "Madhya Pradesh Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "10|10"
      },
      {
        "org_code": "11",
        "authority_code": "RLMDGB",
        "authority_name": "Madhyanchal Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "MAAFSU",
        "authority_name": "Maharashtra Animal and Fishery Sciences University",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "3|10"
      },
      {
        "org_code": "9",
        "authority_code": "MGUKL",
        "authority_name": "Mahatma Gandhi University Kerala",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "MAPKRV",
        "authority_name": "Mahatma Phule Krishi Vidyapeeth, Rahuri",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "MCAPS",
        "authority_name": "Ministry of Culture - Artistes Pension Scheme",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "MMGPT",
        "authority_name": "Mormugao Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "MPMKVV",
        "authority_name": "MP Madhya Kshetra Vidyut Vitaran Co Ltd",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "MPPKVV",
        "authority_name": "MP Paschim Kshetra Vidyut Vitaran Co Ltd",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "MHMBPT",
        "authority_name": "Mumbai Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "MCCCHD",
        "authority_name": "Municipal Corporation Chandigarh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "NABARD",
        "authority_name": "NABARD",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "NCSMUS",
        "authority_name": "National Council of Science Museums",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "NIRDPR",
        "authority_name": "National Institute of Rural Dev and Panchayati Raj",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "NITRKL",
        "authority_name": "National Institute of Technology, Rourkela",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "8|8"
      },
      {
        "org_code": "8",
        "authority_code": "NITTRC",
        "authority_name": "National Institute Of Technology, Tiruchirappalli",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "MANAGE",
        "authority_name": "National Instt of Agricultural Extension Managemen",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "12|15"
      },
      {
        "org_code": "9",
        "authority_code": "NVAUGJ",
        "authority_name": "Navsari Agricultural University",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "NCERT",
        "authority_name": "NCERT New Delhi",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "NDMCG",
        "authority_name": "New Delhi Municipal Council",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "NMGPT",
        "authority_name": "New Mangalore Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "4",
        "authority_code": "NTPCLD",
        "authority_name": "NTPC Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "OHPCL",
        "authority_name": "Odisha Hydro Power Corporation Ltd",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "4",
        "authority_code": "ONGCL",
        "authority_name": "Oil and Natural Gas Corporation Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "PARPT",
        "authority_name": "Paradip Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "PHRLAB",
        "authority_name": "Physical Research Laboratory",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "PBMCG",
        "authority_name": "Port Blair Municipal Council",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "IPPS",
        "authority_name": "Postal",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLPUGB",
        "authority_name": "Prathama UP Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "10",
        "authority_code": "PSAMB",
        "authority_name": "Punjab State Agriculture Marketing Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "PSPCOR",
        "authority_name": "Punjab State Power Corporation Ltd",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "IRPS",
        "authority_name": "Railway",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLRMGB",
        "authority_name": "Rajasthan Marudhara Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RBIND",
        "authority_name": "Reserve Bank of India",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "SAKDM",
        "authority_name": "Sahitya Akademi",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLSGHB",
        "authority_name": "Sarva Haryana Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLSRGB",
        "authority_name": "Saurashtra Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "SIDBOI",
        "authority_name": "Small Industries Development Bank of India",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "APSPDC",
        "authority_name": "Southern Power Distribution Company of A.P Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "SPCSBD",
        "authority_name": "Spices Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "4",
        "authority_code": "SPMCIL",
        "authority_name": "SPMCIL Employees Pension Fund",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "SCTIMS",
        "authority_name": "Sree Chitra Tirunal Institute for Medical Sciences",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "APGOV",
        "authority_name": "State Government Andhra Pradesh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "ARGOV",
        "authority_name": "State Government Arunachal Pradesh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "ASGOV",
        "authority_name": "State Government Assam",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "BHGOV",
        "authority_name": "State Government Bihar",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "CHGOV",
        "authority_name": "State Government Chhattisgarh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "GOGOV",
        "authority_name": "State Government Goa",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "GUGOV",
        "authority_name": "State Government Gujarat",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "HRYGOV",
        "authority_name": "State Government Haryana",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|-|/",
        "ppo_valid_length": "2|20"
      },
      {
        "org_code": "5",
        "authority_code": "HPGOV",
        "authority_name": "State Government Himachal Pradesh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "JKGOV",
        "authority_name": "State Government Jammu and Kashmir",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "JHGOV",
        "authority_name": "State Government Jharkhand",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "KAGOV",
        "authority_name": "State Government Karnataka",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "KLGOV",
        "authority_name": "State Government Kerala",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "MPGOV",
        "authority_name": "State Government Madhya Pradesh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "MAHGOV",
        "authority_name": "State Government Maharashtra",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "MAGOV",
        "authority_name": "State Government Manipur",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "MEGOV",
        "authority_name": "State Government Meghalaya",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "MZGOV",
        "authority_name": "State Government Mizoram",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "ODGOV",
        "authority_name": "State Government Odisha",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "PUDGOV",
        "authority_name": "State Government Puducherry",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "PBGOV",
        "authority_name": "State Government Punjab",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "RJGOV",
        "authority_name": "State Government Rajasthan",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "SKGOV",
        "authority_name": "State Government Sikkim",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "TNGOV",
        "authority_name": "State Government Tamil Nadu",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "TSGOV",
        "authority_name": "State Government Telangana",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "TRGOV",
        "authority_name": "State Government Tripura",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "UPGOV",
        "authority_name": "State Government Uttar Pradesh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|_|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "UTGOV",
        "authority_name": "State Government Uttarakhand",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "WBGOV",
        "authority_name": "State Government West Bengal",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "SPMPKT",
        "authority_name": "Syama Prasad Mookerjee Port Kolkata",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLTNGB",
        "authority_name": "Tamil Nadu Grama Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "TNAGUN",
        "authority_name": "Tamilnadu Agricultural University, Coimbatore",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "5|6"
      },
      {
        "org_code": "11",
        "authority_code": "RLTSGB",
        "authority_name": "Telangana Grameena Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "2",
        "authority_code": "TLPS",
        "authority_name": "Telecom",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "TEFLUH",
        "authority_name": "The English and Foreign Language University",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "12|15"
      },
      {
        "org_code": "3",
        "authority_code": "TRBK",
        "authority_name": "The Rubber Board",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "SCCLTD",
        "authority_name": "The Singareni Collieries Company Limited (SCCL)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "TRTDAP",
        "authority_name": "Tirumala Tirupati Devasthanams(TTD)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "APTRAN",
        "authority_name": "Transmission Corporation of Andhra Pradesh Limited",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z",
        "ppo_valid_length": "4|16"
      },
      {
        "org_code": "10",
        "authority_code": "ULNMC",
        "authority_name": "Ulhasnagar Municipal Corporation",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "ANGOV",
        "authority_name": "Union Territory - Andaman and Nicobar",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "DDGOV",
        "authority_name": "Union Territory - Daman Diu",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "5",
        "authority_code": "LDKGOV",
        "authority_name": "Union Territory - Ladakh",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9",
        "ppo_valid_length": "12|12"
      },
      {
        "org_code": "5",
        "authority_code": "LKGOV",
        "authority_name": "Union Territory - Lakshadweep",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "EDUCLT",
        "authority_name": "University of Calicut",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "UOHYD",
        "authority_name": "University of Hyderabad",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "9",
        "authority_code": "EDUKER",
        "authority_name": "University of Kerala",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLUBGB",
        "authority_name": "Uttar Bihar Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "7",
        "authority_code": "UHBVNL",
        "authority_name": "Uttar Haryana Bijli Vitran Nigam Limited (UHBVNL)",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9",
        "ppo_valid_length": "2|5"
      },
      {
        "org_code": "11",
        "authority_code": "RLUTGB",
        "authority_name": "Uttarakhand Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "VOCPT",
        "authority_name": "V O Chidambaranar Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "11",
        "authority_code": "RLVKGB",
        "authority_name": "Vidharbha Konkan Gramin Bank",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "3",
        "authority_code": "VISPT",
        "authority_name": "Visakhapatnam Port Trust",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      },
      {
        "org_code": "8",
        "authority_code": "VNITEC",
        "authority_name": "Visvesvaraya National Institute of Technology",
        "valid_rule": "NA",
        "rule_status": "O",
        "ppo_valid_char": "0-9|A-Z|(|)|&|/|,|-",
        "ppo_valid_length": "2|30"
      }
  ]
  ''';

  // todo Constructor
  FormController() {
    // organisationList
    final List<dynamic> jsonList = json.decode(jsonString);
    organizations.addAll(
        jsonList.map((data) => OrganizationModel.fromJson(data)).toList());
    // authorityLiist
    final List<dynamic> jsonList1 = json.decode(jsonStringouth);
    authorityList.addAll(
        jsonList1.map((data) => AuthorityModel.fromJson(data)).toList());
  }

  // authorityList   without filter 2nd dropdown data
  //filteredAuthorityList  filter 2nd dropdown data
  Future<void> showFilterList(String orgCode) async {
    try {
      isDropdown1Selected.value = true;
      if (authorityList.isNotEmpty) {
        filteredAuthorityList.clear();
        filteredAuthorityList.value = authorityList
            .where((authority) => authority.orgCode == orgCode)
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
  }

  void showAlertDialog(BuildContext context) {
    // Set up the AlertDialog
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert"),
            content: const Text(
                "You are not allowed to generate DLC in case of Re-employment"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        });
  }
}

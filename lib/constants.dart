import 'dart:collection';

///This list contains the alpha-2 codes of countries
const List<String> europeCountries = [
  "AL",
  "AT",
  "BE",
  "BG",
  "HR",
  "CY",
  "CZ",
  "DK",
  "EE",
  "FI",
  "FR",
  "DE",
  "EL",
  "HU",
  "IS",
  "IE",
  "IT",
  "LV",
  "LT",
  "LU",
  "MT",
  "ME",
  "NL",
  "MK",
  "NO",
  "PL",
  "PT",
  "RO",
  "RS",
  "SK",
  "SI",
  "ES",
  "SE",
  "CH",
  "TR",
  "UK"
];


/// This map is a HashMap that contains info on the given Alpha-2 code <br />
/// The indexes here have the following values <br />
/// 0 : for the full name of the country <br />
/// 1 : for the reference in firebase <br />
/// 2 : for the local file name
final Map<String, List<String>> europeEq = HashMap()
  ..addAll({
    "AL" : ["Albania", "europe/AL_INDEX.db", "AL-INDEX.db"],
    "AT" : ["Austria", "europe/AT_INDEX.db", "AT-INDEX.db"],
    "BE" : ["Belgium", "europe/BE_INDEX.db", "BE-INDEX.db"],
    "BG" : ["Bulgaria", "europe/BG_INDEX.db", "BG-INDEX.db"],
    "HR" : ["Croatia", "europe/HR_INDEX.db", "HR-INDEX.db"],
    "CY" : ["Cyprus", "europe/CY_INDEX.db", "CY-INDEX.db"],
    "CZ" : ["Czechia", "europe/CZ_INDEX.db", "CZ-INDEX.db"],
    "DK" : ["Denmark", "europe/DK_INDEX.db", "DK-INDEX.db"],
    "EE" : ["Estonia", "europe/EE_INDEX.db", "EE-INDEX.db"],
    "FI" : ["Finland", "europe/FI_INDEX.db", "FI-INDEX.db"],
    "FR" : ["France", "europe/FR_INDEX.db", "FR-INDEX.db"],
    "DE" : ["Germany", "europe/DE_INDEX.db", "DE-INDEX.db"],
    "EL" : ["Greece", "europe/EL_INDEX.db", "EL-INDEX.db"],
    "HU" : ["Hungary", "europe/HU_INDEX.db", "HU-INDEX.db"],
    "IS" : ["Iceland", "europe/IS_INDEX.db", "IS-INDEX.db"],
    "IE" : ["Ireland", "europe/IE_INDEX.db", "IE-INDEX.db"],
    "IT" : ["Italy", "europe/IT_INDEX.db", "IT-INDEX.db"],
    "LV" : ["Latvia", "europe/LV_INDEX.db", "LV-INDEX.db"],
    "LT" : ["Lithuania", "europe/LT_INDEX.db", "LT-INDEX.db"],
    "LU" : ["Luxembourg", "europe/LU_INDEX.db", "LU-INDEX.db"],
    "MT" : ["Malta", "europe/MT_INDEX.db", "MT-INDEX.db"],
    "ME" : ["Montenegro", "europe/ME_INDEX.db", "ME-INDEX.db"],
    "NL" : ["Netherlands", "europe/NL_INDEX.db", "NL-INDEX.db"],
    "MK" : ["North Macedonia", "europe/MK_INDEX.db", "MK-INDEX.db"],
    "NO" : ["Norway", "europe/NO_INDEX.db", "NO-INDEX.db"],
    "PL" : ["Poland", "europe/PL_INDEX.db", "PL-INDEX.db"],
    "PT" : ["Portugal", "europe/PT_INDEX.db", "PT-INDEX.db"],
    "RO" : ["Romania", "europe/RO_INDEX.db", "RO-INDEX.db"],
    "RS" : ["Serbia", "europe/RS_INDEX.db", "RS-INDEX.db"],
    "SK" : ["Slovakia", "europe/SK_INDEX.db", "SK-INDEX.db"],
    "SI" : ["Slovania", "europe/SI_INDEX.db", "SI-INDEX.db"],
    "ES" : ["Spain", "europe/ES_INDEX.db", "ES-INDEX.db"],
    "SE" : ["Sweden", "europe/SE_INDEX.db", "SE-INDEX.db"],
    "CH" : ["Switzerland", "europe/CH_INDEX.db", "CH-INDEX.db"],
    "TR" : ["Türkiye", "europe/TR_INDEX.db", "TR-INDEX.db"],
    "UK" : ["United Kingdom", "europe/UK_INDEX.db", "UK-INDEX.db"]
  });

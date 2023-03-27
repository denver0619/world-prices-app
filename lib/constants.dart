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
    "AL" : ["Albania", "europe/AL_INDEX.db", "AL_INDEX.db"],
    "AT" : ["Austria", "europe/AT_INDEX.db", "AT_INDEX.db"],
    "BE" : ["Belgium", "europe/BE_INDEX.db", "BE_INDEX.db"],
    "BG" : ["Bulgaria", "europe/BG_INDEX.db", "BG_INDEX.db"],
    "HR" : ["Croatia", "europe/HR_INDEX.db", "HR_INDEX.db"],
    "CY" : ["Cyprus", "europe/CY_INDEX.db", "CY_INDEX.db"],
    "CZ" : ["Czechia", "europe/CZ_INDEX.db", "CZ_INDEX.db"],
    "DK" : ["Denmark", "europe/DK_INDEX.db", "DK_INDEX.db"],
    "EE" : ["Estonia", "europe/EE_INDEX.db", "EE_INDEX.db"],
    "FI" : ["Finland", "europe/FI_INDEX.db", "FI_INDEX.db"],
    "FR" : ["France", "europe/FR_INDEX.db", "FR_INDEX.db"],
    "DE" : ["Germany", "europe/DE_INDEX.db", "DE_INDEX.db"],
    "EL" : ["Greece", "europe/EL_INDEX.db", "EL_INDEX.db"],
    "HU" : ["Hungary", "europe/HU_INDEX.db", "HU_INDEX.db"],
    "IS" : ["Iceland", "europe/IS_INDEX.db", "IS_INDEX.db"],
    "IE" : ["Ireland", "europe/IE_INDEX.db", "IE_INDEX.db"],
    "IT" : ["Italy", "europe/IT_INDEX.db", "IT_INDEX.db"],
    "LV" : ["Latvia", "europe/LV_INDEX.db", "LV_INDEX.db"],
    "LT" : ["Lithuania", "europe/LT_INDEX.db", "LT_INDEX.db"],
    "LU" : ["Luxembourg", "europe/LU_INDEX.db", "LU_INDEX.db"],
    "MT" : ["Malta", "europe/MT_INDEX.db", "MT_INDEX.db"],
    "ME" : ["Montenegro", "europe/ME_INDEX.db", "ME_INDEX.db"],
    "NL" : ["Netherlands", "europe/NL_INDEX.db", "NL_INDEX.db"],
    "MK" : ["North Macedonia", "europe/MK_INDEX.db", "MK_INDEX.db"],
    "NO" : ["Norway", "europe/NO_INDEX.db", "NO_INDEX.db"],
    "PL" : ["Poland", "europe/PL_INDEX.db", "PL_INDEX.db"],
    "PT" : ["Portugal", "europe/PT_INDEX.db", "PT_INDEX.db"],
    "RO" : ["Romania", "europe/RO_INDEX.db", "RO_INDEX.db"],
    "RS" : ["Serbia", "europe/RS_INDEX.db", "RS_INDEX.db"],
    "SK" : ["Slovakia", "europe/SK_INDEX.db", "SK_INDEX.db"],
    "SI" : ["Slovenia", "europe/SI_INDEX.db", "SI_INDEX.db"],
    "ES" : ["Spain", "europe/ES_INDEX.db", "ES_INDEX.db"],
    "SE" : ["Sweden", "europe/SE_INDEX.db", "SE_INDEX.db"],
    "CH" : ["Switzerland", "europe/CH_INDEX.db", "CH_INDEX.db"],
    "TR" : ["Türkiye", "europe/TR_INDEX.db", "TR_INDEX.db"],
    "UK" : ["United Kingdom", "europe/UK_INDEX.db", "UK_INDEX.db"]
  });

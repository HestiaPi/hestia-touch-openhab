'use strict';

var DEFAULTS = new java.util.HashMap();

// C Defaults
DEFAULTS.put("C_MIN", 0);              // Minimum C setpoint
DEFAULTS.put("C_MAX", 40);             // Maximum C setpoint
//DEFAULTS.put("C_DEF", 22);             // Default C setpoint
DEFAULTS.put("TempC_DIFF", 0.2);       // Difference in C temps before processing the change
DEFAULTS.put("C_COMFORT_DEF", 0.5);    // COMFORT mode hysteresis in C
DEFAULTS.put("C_ECO_DEF", 1.0);        // Eco mode hysteresis in C

// F Defaults
DEFAULTS.put("F_MIN", 32);             // Minimum F setpoint
DEFAULTS.put("F_MAX", 100);            // Maximum F setpoint
//DEFAULTS.put("F_DEF", 70);             // Default F setpoint
DEFAULTS.put("TempF_DIFF", 0);         // Difference in F temps befpre processing the change
DEFAULTS.put("F_COMFORT_DEF", 1.0);    // COMFORT mode hysteresis in F
DEFAULTS.put("F_ECO_DEF", 3.0);        // Eco mode hysteresis in F

// Humidity Defaults
DEFAULTS.put("Humi_MIN", 0);           // Minimum humidity setpoint
DEFAULTS.put("Humi_MAX", 100);         // Maximum humidity setpoint
DEFAULTS.put("Humi_DEF", 50);          // Default humidity setpoint
DEFAULTS.put("Humi_DIFF", 3);          // Difference in humifity before processing the change

// Pressure Defaults
DEFAULTS.put("Pressure_DIFF", 0);      // Difference in pressure before processing the change

// Heating2
DEFAULTS.put("Heating2Time", 0);       // 2nd stage heating default time
DEFAULTS.put("Heating2Delta", 0);      // 2nd state heating default temperature delta

// Boost Times
DEFAULTS.put("HeatingBoostTime", 10);  // Default heating boost time
DEFAULTS.put("CoolingBoostTime", 10);  // Default cooling boost time
DEFAULTS.put("HotWaterBoostTime", 10);  // Default hot water boost time
DEFAULTS.put("HumidityBoostTime", 10); // Default humidity boost time


var SCRIPT_TIMEOUT = 5000; // TODO: remove after eliminating executeCommandLine calls

// Maps pin Items to GPIO pin Items
var PIN_MAP = new java.util.HashMap();

PIN_MAP.put("US_HeatingPin", "Pin12");
PIN_MAP.put("US_Heating2Pin", "Pin16");
PIN_MAP.put("US_CoolingPin", "Pin23");
PIN_MAP.put("US_FanPin", "Pin18");

PIN_MAP.put("EU_HeatingPin", "Pin23");
PIN_MAP.put("EU_Heating2Pin", "Pin16");
PIN_MAP.put("EU_HotWaterPin", "Pin12");
PIN_MAP.put("EU_HumidityPin", "Pin18");


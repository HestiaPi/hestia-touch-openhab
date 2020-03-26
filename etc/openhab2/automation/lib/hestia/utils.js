'use strict';

(function(context) {
  'use strict';

  // Logger config
  var LOG_ROOT = "org.eclipse.smarthome.model.script.";

  context.logDebug = function(name, message) {
    var logger = Java.type("org.slf4j.LoggerFactory").getLogger(LOG_ROOT+name);
    logger.debug(message);
  };

  context.logInfo = function(name, message) {
    var logger = Java.type("org.slf4j.LoggerFactory").getLogger(LOG_ROOT+name);
    logger.info(message);
  };

  context.logWarn = function(name, message) {
    var logger = Java.type("org.slf4j.LoggerFactory").getLogger(LOG_ROOT+name);
    logger.warn(message);
  };

  context.logError = function(name, message) {
    var logger = Java.type("org.slf4j.LoggerFactory").getLogger(LOG_ROOT+name);
    logger.error(message);
  };


  // Timers
  context.ScriptExecution = Java.type("org.eclipse.smarthome.model.script.actions.ScriptExecution");
  context.createTimerSecs = function(secs, runnable) {
    try {
      var time = Java.type("org.joda.time.DateTime").now().plusSeconds(secs);

      return context.ScriptExecution.createTimer(time, runnable);
    }
    catch(err){
      context.logError("createTimer", "Error creating timer: " + __LINE__ + " Error: " + err);
    }
  };

  context.sleep = function(secs) {
    java.lang.Thread.sleep(secs*1000);
  };

  context.waitForUpdate = function(item, maxSecs) {
    var count = 0;
    while(count < maxSecs && (items[item] == NULL || items[item] == UNDEF)){
      count++;
      java.lang.Thread.sleep(1000);
    }
  };

  context.waitForUpdateState = function(item, state, maxSecs) {
    var count = 0;
    while(count < maxSecs && (items[item] != state)){
      count++;
      java.lang.Thread.sleep(1000);
    }
  };

  context.ExecUtil = Java.type("org.eclipse.smarthome.io.net.exec.ExecUtil");
  context.executeCommandLine = function(cmd, timeout){
    return context.ExecUtil.executeCommandLineAndWaitResponse(cmd, timeout);
  };

  context.commandIfDifferent = function(item, cmd){
    if(items[item] != cmd) {
      events.sendCommand(item, cmd);
    }
  };
})(this);

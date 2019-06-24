//****************************************************************************************************
//**************************************************
import processing.serial.*;
import java.util.*;

//****************************************************************************************************
// Colormax Object
//****************************************************************************************************
class Colormax
{
  //****************************************************************************************************
  // Fields / Properties
  //****************************************************************************************************
  // Fields
  private String label;
  private boolean isAvailable = false;
  //private int isBusy = 0;
  //// Bit definitions:
  //// 0 = inactive, 1 = active
    //// Bit 0: Gathering CCLT                (0x01)
    //// Bit 1: Getting temp table            (0x02)
    //// Bit 2: Long Testing                  (0x04)
    //// Bit 3: Light Adjustment Calibration  (0x08)
    //// Bit 4: Getting colormax info         (0x10)
    //// Bit 5: Color Alignment table         (0x20)
    //// Bit 6: Getting alignment table       (0x40)
  
  // Status Definitions
  final String idle = "idle";
  final String gettingTempTable = "gettingTempTable";
  final String settingIlluminationFactor = "settingIlluminationFactor";
  final String updating = "updating";
  final String calibrating = "calibrating";
  final String retakingPoint = "retakingPoint";
  final String gettingAlignTable = "gettingAlignTable";
  final String[] statuses = {idle, gettingTempTable, settingIlluminationFactor, updating, calibrating, retakingPoint, gettingAlignTable};
  
  // Colormax status
  private String status = idle;     // to keep track of what this colormax is currently doing
  
  // Colormax properties
  private String identity;          // stores raw colormax response
  private String model;
  private String serialNumber;
  private String UDID;
  private String UDIDcd;
    
  private String settings;          // stores raw colormax response
  private String averaging;
  private String triggering;
  private String outputDelay;
  private int illumination;
  
  private String currentData;      // stores raw colormax response
  private int red;
  private int green;
  private int blue;
  private float maxColorValue = 65472.;
  
  private String clt;              // stores raw colormax response
  private float temperature;
  private String ledMa;
  private float ledMaFloat;
  private String ledDac;
  private String ledStability;
  
  private String illuminationSetting;
  
  private boolean isUsingTemp;
  private boolean isUsingAlign;
  
  String rawVersion;       // stores raw coloramx response
  String firmwareVersion;
  
  private int colorTargetsFormat = 0;
  
  // Serial related objects/variables 
  private Serial serial;
  String port;
  private final int baudRate = 115200;
  private final char parity = 'E';
  private final int dataBits = 7;
  private final float stopBits = 1.0;
  private final char bufferUntil = 13;
  private final int commandDelay = 25;
  
  private int currentLightAdjustment;
  private int currentTempPoint;
  private int currentAlignPoint;
  private int alignIndex;
  
  // Timer related objects/variables
  //private Timer timer;
  
  // Printwriter reltaed objects/variables
  private PrintWriter writer;    // Printwriter object for exporting colormax data to a .txt file

  //****************************************************************************************************
  // Constructor
  //****************************************************************************************************
  Colormax(String inLabel) {
    // Save label
    label = inLabel;
  }

  //****************************************************************************************************
  // Methods
  //****************************************************************************************************
  
  //**************************************************
  // Initialize
  // Desc: Initializes the colormax:
  // Initializes Serial port
  // Grabs the version, settings
  // Ret values:
  // 0: Success
  // 1: Port not found
  // 2: Serial Error
  // 3: Colormax not found
  //**************************************************
  int initialize(PApplet inParent, String inPort) {
    // Start by updating serial status
    updateSerialStatus(inParent, inPort);
    
    // All is well, now ask for this colormax's information
    // These, and all serial callbacks from the colormax, are handled in the application's serialEvent() function
    // (due to how prcoessing handles serial information, serialEvent has to live in the main applet)
    readSettings();
    delay(commandDelay);
    readVersion();
    delay(commandDelay);    
    readIlluminationFactor();
    delay(commandDelay);
    readCLT();
    
    // No problems
    //isBusy = 0;
    return 0;
  }
  
  //**************************************************
  // Set Serial Connection
  //**************************************************
  void setSerial(Serial inSerial){
    serial = inSerial;
    port = inSerial.port.getPortName();
    return;
  }
  
  Serial getSerial(){
    return serial;
  }

  //**************************************************
  // Update Serial Connection
  // Desc: Updates the serial connection
  // Ret values:
  // 0: Success
  // 1: Port not found
  // 2: Serial Error
  // 3: Colormax not found
  //**************************************************
  int updateSerialStatus(PApplet inParent, String inPort) {
    // Check if the input port is even connected
    if(!portIsConnected(inPort)) {
      // Port isn't connected
      return 1;
    }
    
    // We found the port, so
    // save this colormax's assigned port
    port = inPort;
    
    // Check if the serial connection is already opened
    if(serial != null) {
      // If it is open, kill it
      endSerial();
    }
    
    // Try and open the serial connection
    if(!startSerial(inParent)) {
      // Serial error
      return 2;
    }
    
    // By now we've found that:
    // 1) The specified serial port is connected to the system
    // 2) The serial connection has been opened successfully
    // Now we need to check if the colormax is out there
    
    if(!checkConnection()) {
      // Colormax not connected
      return 3;
    }
    
    // All is well, return 0
    return 0;
  }

  //**************************************************
  // Port is Connected
  // Desc: Checks to see if the port is connected
  // Returns true if port is found
  // Otherwise returns false
  //**************************************************
  boolean portIsConnected(String inPort) {
    for(int i = 0 ; i < Serial.list().length ; i++) {
      if(inPort.equals(Serial.list()[i])) {
        return true;
      }
    }
    return false;
  }
  
  //**************************************************
  // Colormax is Connected
  // Desc: Sends <CR> on the serial line and
  // hopes for a response. Result is stored in 
  // boolean isAvailable
  //**************************************************
  boolean checkConnection() {
    isAvailable = false;
    serial.write(13);
    int timeout = 250;
    int startMillis = millis();
    
    while(!isAvailable){
      delay(1);
      if(millis() - startMillis > timeout) {
          return isAvailable;
      }
    }
    return isAvailable;
  }

  //**************************************************
  // Start Serial
  // Desc: Starts a new serial connection
  // Ret vals:
  // True: Success
  // False: Active serial connection already in service
  // (call disconnectionSerial() to fix this)
  // OR COM port is busy
  //**************************************************
  boolean startSerial(PApplet inParent) {
    try {
      serial = new Serial(inParent, port, baudRate, parity, dataBits, stopBits);    //CMAX serial port settings
    }
    catch(Exception e) {
      println(e);
      return false;
    }
    serial.bufferUntil(bufferUntil);
    return true;
  }

  //**************************************************
  // End Serial
  // Desc: Stops, clears buffer, and nullifies
  // this colormax's serial object
  //**************************************************
  void endSerial() {
    if(serial != null){
      serial.stop();
      serial.clear();
      serial = null;
    }
  }

  //****************************************************************************************************
  // Properties methods 
  // Desc: 
  //****************************************************************************************************
  
  // Parse functions take raw colormax response and saves the relevant info
  // Identity ****************************************
  // !i command
  void parseIdentity(String inIdentity){
    identity = inIdentity;
    model = inIdentity.substring(3,4);
    serialNumber = inIdentity.substring(5, 21);
    //println("serialNumber:", serialNumber);
    return;
  }
  
  void setIdentity(String inIdentity){
    identity = inIdentity;
    return;
  }
  
  String getIdentity(){
    return identity;
  }
  
  void setModel(String inModel){
    model = inModel;
    return;
  }
  
  String getModel(){
    return model;
  }
  
  void setSerialNumber(String inSerialNumber){
    serialNumber = inSerialNumber;
    return;
  }
  
  String getSerialNumber(){
    return serialNumber;
  }
  
  // CLT (Color, LED, Temperature)*******************************
  // !h command
  void parseClt(String inClt){
    clt = inClt;
    red = Integer.parseInt(inClt.substring(3, 7), 16);
    green = Integer.parseInt(inClt.substring(8, 12), 16);
    blue = Integer.parseInt(inClt.substring(13, 17), 16);
    int tempTemp = Integer.parseInt(inClt.substring(18, 22), 16);
    if(tempTemp > 0x8000){
      tempTemp &= ~0x8000;
      tempTemp -= 0x8000;
    }
    temperature = (float) tempTemp / 16;
    ledMa = inClt.substring(23, 27);
    //println("ledMa:", Integer.parseInt(ledMa,16));
    ledMaFloat = (float) Integer.parseInt(ledMa, 16) / 64 / 1023 * 5 / 0.08; // for some reason this is how we convert to mA
    ledDac = inClt.substring(28, 32);
    ledStability = inClt.substring(33,34);
  }
  
  void setClt(String inClt){
    clt = inClt;
  }
  
  String getClt(){
    return clt;
  }
  
  void setTemperature(float inTemperature){
    temperature = inTemperature;
  }
  
  float getTemperature(){
    return temperature;
  }
  
  void setLedMa(String inLedMa){
  ledMa = inLedMa;
  }
  
  String getLedMa(){
    return ledMa;
  }
  
  void setLedMaFloat(float inLedMaFloat){
    ledMaFloat = inLedMaFloat;
  }
  
  float getLedMaFloat(){
    return ledMaFloat;
  }
  
  void setLedDac(String inLedDac){
    ledDac = inLedDac;
  }
  
  String getLedDac(){
    return ledDac;
  }
  
  void setLedStability(String inLedStability){
    ledStability = inLedStability;
  }
  
  
  String getLedStability(){
    return ledStability;
  }
  
  void parseIlluminationSetting(String inIlluminationSetting){
    illuminationSetting = inIlluminationSetting.substring(3,6);
  }
  
  void setIlluminationSetting(String inIlluminationSetting){
    illuminationSetting = inIlluminationSetting;
  }
  
  String getIlluminationSetting(){
    return illuminationSetting;
  }
  
  // Settings ****************************************
  // !s command
  void parseSettings(String inSettings){
    settings = inSettings;
    averaging = inSettings.substring(3, 4);
    triggering = inSettings.substring(5, 6);
    outputDelay = inSettings.substring(7, 8);
    illumination = Integer.parseInt(inSettings.substring(11, 13), 16);  // Convert illumination substring from hex to integer (0-100)
    return;
  }
  
  void setSettings(String inSettings){
    settings = inSettings;
  }
  
  String getSettings(){
    return settings;
  }
  
  void setAveraging(String inAveraging){
    averaging = inAveraging;
    return;
  }
  
  String getAveraging(){
    return averaging;
  }
  
  void setTriggering(String inTriggering){
    triggering = inTriggering;
    return;
  }
  
  String getTriggering(){
    return triggering;
  }
  
  void setOutputDelay(String inOutputDelay){
    outputDelay = inOutputDelay;
    return;
  }

  String getOutputDelay(){
    return outputDelay;
  }
  
  void setIllumination(int inIllumination){
    illumination = inIllumination;
    return;
  }
  
  int getIllumination(){
    return illumination;
  }
  
  // Current Data ****************************************
  // !d command
  void parseData(String inCurrentData){
    currentData = inCurrentData;
    red = Integer.parseInt(inCurrentData.substring(3, 7), 16);
    green = Integer.parseInt(inCurrentData.substring(8, 12), 16);
    blue = Integer.parseInt(inCurrentData.substring(13, 17), 16);
    return;
  }
  
  String getCurrentData(){
    return currentData;
  }
  
  void setRed(int inRed){
    red = inRed;
    return;
  }
  
  int getRed(){
    return red;
  }
  
  float getRedPercent(){
    return 100 * (float)(red / maxColorValue);
  }
  
  void setGreen(int inGreen){
    green = inGreen;
    return;
  }
  
  int getGreen(){
    return green;
  }
  
  float getGreenPercent(){
    return 100 * (float)(green / maxColorValue);
  }
  
  void setBlue(int inBlue){
    blue = inBlue;
    return;
  }
  
  int getBlue(){
    return blue;
  }
  
  float getBluePercent(){
    return 100 * (float)(blue / maxColorValue);
  }
  
  // Version ****************************************
  // !v command
  void parseVersion(String inVersion){
    rawVersion = inVersion;
    firmwareVersion = inVersion.substring(3, 6) + " " + inVersion.substring(7, 10);
  }
  
  void setVersion(String inVersion){
    firmwareVersion = inVersion;
    return;
  }
  
  String getVersion(){
    return firmwareVersion;
  }
  
  // Serial Port ****************************************
  void setPort(String inPort){
    port = inPort;
  }
  
  String getPort(){
    return port;
  }
  
  void setStatus(String inStatus){
    // MUST use valid status
    for(int i = 0 ; i <= statuses.length ; i++){
      if(inStatus == statuses[i]){
        // We've found a match, move on
        break;
      }
      
      else if(i == statuses.length){
        // We've checked the entire list and didn't find a match
      // spit out an error and get out of here
        println("@@@@@@@@@@ INVALID STATUS IN Colormax.setStatus() @@@@@@@@@@");
        return;
      }
    }
    status = inStatus;    
    return;
  }
  
  String getStatus(){
    return status;
  }
  
  // Unimplemented thus far ****************************************
  void setIsUsingTemp(boolean inState){
    isUsingTemp = inState;
  }
  
  boolean isUsingTemp(){
    return isUsingTemp;
  }
  
  void setIsUsingAlign(boolean inState){
    isUsingAlign = inState;
  }
  
  boolean isUsingAlign(){
    return isUsingAlign;
  }
  
  // Serial Read/Write ****************************************
  // Commands to read/write to the colormax
  
  void readIdentity() {
    serial.write("!i");
    serial.write(13);
  }
  
  void readSettings() {
    serial.write("!s");
    serial.write(13);
  }
  
  // This command's inputs are somewhat optional: if a string's value is set to null, we'll just
  // default to that property's previous setting; if illumination is set out of the range 0 - 100
  // we will default to the previous illumination setting
  void sendSettings(String inAveraging, String inTriggering, String inOutputDelay, int inIllumination){
    // condition ? true : false
    // Check if we recieved new input for certain settings. If not, assume we don't want to change
    // those settings, and set them equal to what we already have
    String outAveraging = inAveraging != null ? inAveraging : averaging;
    String outTriggering = inTriggering != null ? inTriggering : triggering;
    String outOutputDelay = inOutputDelay != null ? inOutputDelay : outputDelay;
    int outIllumination = inIllumination;// < 0 || inIllumination > 100 ? inIllumination : illumination;
    
    String outSettings = "!S" + "," + outAveraging + "," + outTriggering + "," + outOutputDelay + "," + "0" + "," + String.format("%02X", outIllumination);
    serial.write(outSettings);
    println(outSettings);
    serial.write(13);
  }

  void readVersion() {
    serial.write("!v");
    serial.write(13);
  }

  void readData() {
    serial.write("!d");
    serial.write(13);
  }
  
  void readCLT() {
    serial.write("!h");
    serial.write(13);
  }
  
  void readIlluminationFactor() {
    serial.write("!a");
    serial.write(13);
  }
  
  void readChannel(int inChannel){
    // Channel can only be 0-3 anyways
    if(inChannel < 0 || inChannel > 3){
        println("@@@@@@@@@@ readChannel inChannel out of bounds! @@@@@@@@@@");
      }
      else {
        serial.write("!c,");
        serial.write(inChannel);
        serial.write(13);
      }
  }
  
  void sendChannel(int inChannel, int output, int active, int mode, int redLower, int redUpper, int greenLower, int greenUpper, int blueLower, int blueUpper){
    // check that outputs are valid
    if(inChannel < 0 || inChannel > 3 ||
       output < 0 || output > 1 ||
       active < 0 || output > 1 ||
       mode < 0 || output > 1 ||
       redLower > redUpper || redLower < 0 || redLower > 0xFFC0 ||
       redUpper < 0 || redUpper > 0xFFC0 ||
       greenLower > greenUpper || greenLower < 0 || greenLower > 0xFFC0 ||
       greenUpper < 0 || greenUpper > 0xFFC0 ||
       blueLower > blueUpper || blueLower < 0 || blueLower > 0xFFC0 ||
       blueUpper < 0 || blueUpper > 0xFFC0 ){
         println("@@@@@@@@@@ Something's out of bounds or mixed up when trying to sendChannel @@@@@@@@@");
       }
       else{
         // convert RBG lower/upper limit inputs to 4-digit hex values
         String outRedLower = String.format("%04X", redLower);
         String outRedUpper = String.format("%04X", redUpper);
         String outGreenLower = String.format("%04X", greenLower);
         String outGreenUpper = String.format("%04X", greenUpper);
         String outBlueLower = String.format("%04X", blueLower);
         String outBlueUpper = String.format("%04X", blueUpper);
         
         String outString = "!C," + inChannel + output + active + mode + outRedLower + outRedUpper + outGreenLower + outGreenUpper + outBlueLower + outBlueUpper;
         serial.write(outString);
       }
  }
  
  void sendTeachChannel(int inChannel, int output, int active, int mode, int redLower, int redUpper, int greenLower, int greenUpper, int blueLower, int blueUpper, int redTol, int greenTol, int blueTol){
    // check that outputs are valid
    if(inChannel < 0 || inChannel > 3 ||
       output < 0 || output > 1 ||
       active < 0 || output > 1 ||
       mode < 0 || output > 1 ||
       redTol < 0 || redTol > 1000000 ||
       greenTol < 0 || greenTol > 1000000 ||
       blueTol < 0 || blueTol > 1000000){
         println("@@@@@@@@@@ Something's out of bounds or mixed up when trying to sendChannel @@@@@@@@@");
       }
       else{
         // convert RBG tolerance inputs to 5-digit hex values         
         String outRedTol = String.format("%05X", redTol);
         String outGreenTol = String.format("%05X", greenTol);
         String outBlueTol = String.format("%05X", blueTol);
         
         String outString = "!T," + inChannel + output + active + mode + outRedTol + outGreenTol + outBlueTol;
         serial.write(outString);
       }
  }
  
  //void updateInfo(){
  //  readCLT();
  //  delay(commandDelay);
  //  readSettings();
  //  delay(commandDelay);
  //  readIdentity();
  //  delay(commandDelay);
  //  readVersion();
  //  delay(commandDelay);
  //  readIlluminationFactor();
  //}
  
  //void stopLongTest() {
  //  timer.cancel();
  //  timer.purge();
  //  endLog();
  //  //isBusy &= ~0x04;
  //}
  
  void writeStartTemp() {
    serial.write("!N,0");
    serial.write(13);
  }
  
  void writeTakeTempPoint() {
    serial.write("!N,1");
    serial.write(13);
  }
  
  void writeStoreTemp() {
    serial.write("!N,2");
    serial.write(13);
  }
  
  void writeDiscardTemp() {
    serial.write("!N,3");
    serial.write(13);
  }
  
  void writeTempOff() {
    serial.write("!N,4");
    serial.write(13);
  }
  
  void writeTempOn() {
    serial.write("!N,5");
    serial.write(13);
  }
  
  void readTempPoint(int pointNumber) {
    // convert pointNumber to a 2-digit, decimal based string version of itself
    // eg: 2 = '02', 7 = '07', 13 = '13'
    // pointNumber max = 29s
    if(pointNumber > 29) {
      println("@@@@@@@@@@ readTempPoint(int pointNumber) pointNumber out of range! @@@@@@@@@@");
      return;
    }
    serial.write("!N,6,");
    serial.write(String.format("%02X", pointNumber));
    serial.write(13);
  }
  
  void readStartGetTemp() {
    println("Getting Temp for ", label);
    //isBusy |= 0x02;
    currentTempPoint = 0;
    readTempPoint(currentTempPoint);
  }
  
  void continueGetTemp() {
    //isBusy |= 0x02;
    readTempPoint(++currentTempPoint);
    println("Getting temp table point ", currentTempPoint, " for ", label);
  }
  
  void stopGetTemp() {
    println("Done getting temp table for ", label);
    //isBusy &= ~0x02;
  }
  
  void checkTempUse(){
    
  }
  
  //**************************************************
  // read CCLT
  // Desc: reads contiguous color/LED/temperterature (CLT)
  // readings be sent every 0.5 second. Readings
  // from the colormax are handled by serialEvent()
  //**************************************************
  void readCCLT() {
    println("reading CCLT");
    serial.write("!H");
    serial.write(13);
  }
  
  //**************************************************
  // End CCLT
  // Desc: Ends contiguous color/LED/temperterature (CLT)
  // measurements
  //**************************************************
  void endCCLT() {
    serial.write("0123456789");
    serial.write(13);
    if(writer != null) {
      endLog();
    }
    //isBusy &= ~0x01;
  }
  
  ////**************************************************
  //// Timed CCLT
  //// Desc: Ends contiguous color/LED/temperterature (CLT)
  //// measurements for duration (milliseconds)
  ////**************************************************
  //void timedCCLT(int duration) {
  //  //println("Getting CLT Measurements for ", duration, " milliseconds");
  //  //isBusy |= 0x01;
  //  readCCLT();
  //  timer = new Timer();
  //  timer.schedule(new TimerTask() {
  //      public void run() {
  //        endCCLT();
  //      }
  //    }
  //    , (long)(duration) );
  //}
  
  ////**************************************************
  //// Long Test
  //// Desc: 
  ////**************************************************
  //void longTest(int period, long duration) {
  //  //isBusy |= 0x04;
  //  timer = new Timer();
    
  //  // Schedule fixed rate execution
  //  timer.scheduleAtFixedRate(new TimerTask() {
  //      public void run() {
  //        //DO ME BABY
  //        serial.write("!h");
  //        serial.write(13);
  //      }
  //    }
  //    , 0
  //    , (long)period);
    
  //  // Check if we want to run indef
  //  if(duration != 0) {
  //    // Schedule duration
  //    timer.schedule(new TimerTask() {
  //        public void run() {
  //          timer.cancel();
  //          timer.purge();
  //          endLog();
  //          //isBusy &= ~0x04;
  //        }
  //      }
  //      , (long)(duration) );
  //  }
  //}
  
  //**************************************************
  // Light Adjustment Calibrate Start
  // Desc: Kicks off the light calibration process by setting the flag and asking for color
  // data. Process is continued in lightAdjustmentCalibrationContinue() by serialEvent()
  //**************************************************
  void lightAdjustmentCalibrateStart() {
    //isBusy |= 0x08;
    delay(commandDelay);
    serial.write("!d");
    serial.write(13);
  }
  
  //**************************************************
  // Light Adjustment Calibration Continue
  // Desc: Continues the process of calibrating the light source to the blue channel's signal
  //**************************************************
  void lightAdjustmentCalibrateContinue(int blue) {
    // Check that our light adjustment is good
    if( currentLightAdjustment < 0x1F4
     || currentLightAdjustment > 0x3E8) {
       readIlluminationFactor();
       lightAdjustmentCalibrateStart();
     }
    
    // Convert hex string to int
    //int blue = Integer.parseInt(blueChannel, 16);
    final int coarseAdj = 30;
    final int fineAdj = 1;
    
    println("blue: ", ((float)blue / 65422 * 100));
    println("adj: ", currentLightAdjustment);
    
    // Check if blue channel is in the right range (89-90%)
    if(blue > 58879) {
      
      // Coarse adjustment
      if(blue > 62151) {
        serial.write("!A,");
        serial.write(String.format("%02X", currentLightAdjustment -= coarseAdj));
        serial.write(13);
        lightAdjustmentCalibrateStart();
      }
      
      // Fine Adjustment
      else {
        serial.write("!A,");
        serial.write(String.format("%02X", currentLightAdjustment -= fineAdj));
        serial.write(13);
        lightAdjustmentCalibrateStart();
      }
    }
    
    else if(blue < 58225) {
      
      // Coarse adjustment
      if(blue < 55609) {
        serial.write("!A,");
        serial.write(String.format("%02X", currentLightAdjustment += coarseAdj));
        serial.write(13);
        lightAdjustmentCalibrateStart();
      }
      
      // Fine adjustment
      else {
        serial.write("!A,");
        serial.write(String.format("%02X", currentLightAdjustment += fineAdj));
        serial.write(13);
        lightAdjustmentCalibrateStart();
      }
    }
    else {
      println("light C A L I B R A T E D");
      //isBusy &= ~0x08;
    }
  }
  
  //****************************************************************************************************
  // Logging Methods
  //****************************************************************************************************
  
  //**************************************************
  // New Log
  // Desc: Creates a new printwriter log using
  // the argument as the filename's prefix, and
  // creating a random number appendix.
  //**************************************************
  void newLog(String prefix) {
    //println("Making new log file for: ", prefix);
    writer = utilCreateWriter(writer, prefix);    
    utilPrintColormaxInfo(writer, this);
    utilPrintTimestamp(writer);
  }

  //**************************************************
  // End Log
  // Desc: flushes and closes the current log
  //**************************************************
  void endLog() {
    //println("Ending Log");
    utilFlushAndClose(writer);
  }

  //**************************************************
  // Write To Log
  // Desc: Writes a line to the current log
  //**************************************************
  void writeToLog(String input) {
    //println("Writing to log: ", input);
    writer.println(input);
  }
  
  //**************************************************
  // Write Temperature To Log
  // Desc: Writes a line to the current log
  //**************************************************
  void writeTemperatureToLog(String input) {
    //println("Writing temperature to log: ", input);
    writer.print("Temperature(ºC): ");
    writer.println(input);
  }

  ////**************************************************
  //// Is Available
  //// Desc: Returns isAvailable
  ////**************************************************
  //boolean isAvailable() {
  //  return isAvailable;
  //}
  
  ////**************************************************
  //// Is Busy
  //// Desc: Returns false if colormax isn't doing anything else right now
  //// Used so the application can tell if it can start something else
  ////**************************************************
  //int isBusy() {
  //  return isBusy;
  //}
  
  //void setIsBusy(int inBusy){
  //  isBusy = inBusy;
  //  return;
  //}
  
  // Start Alignment Process
  void writeStartAlign(){
  serial.write("!O,0");
  serial.write(13);
  return;
  }
  
  
  
  // Align Color
  void writeAlignColor(){
    serial.write("!O,1");
    serial.write(13);
  }
  
  //// Align Color
  //void writeAlignColor(String alignmentTableDirectory, int colorIndex){
  //  isBusy |= 0x20;
  //  String outAlignmentColors;
  //  String[] alignmentTable = loadStrings(alignmentTableDirectory);
  //  //if(alignmentTable[colorIndex].startsWith(String.valueOf(colorIndex))){
  //    //outAlignmentColors = alignmentTable[colorIndex].substring(2, 13);
  //    //outAlignmentColors = alignmentTable[colorIndex].substring(alignmentTable[colorIndex].indexOf(")") + 1, alignmentTable[colorIndex].length());
  //    outAlignmentColors = alignmentTable[colorIndex].substring(alignmentTable[colorIndex].indexOf("1") + 2, alignmentTable[colorIndex].length());
  //  //}
  //  //else{
  //  //  println("@@@@@@@@@@ calibrateColor(int colorIndex) out of bounds @@@@@@@@@@");
  //  //  return;
  //  //}
  //  String outString = "!O,1," + outAlignmentColors;
  //  //debugging
  //  println(outString);
  //  serial.write(outString);
  //  serial.write(13);
  //  return;
  //}
  
  void writeStoreAlignment(){
   serial.write("!O,2");
   serial.write(13);
   return;
  }
  
  void writeDiscardAlignment(){
   serial.write("!O,3");
   serial.write(13);
   return;
  }
  
  void writeAlignmentOff(){
   serial.write("!O,4");
   serial.write(13);
   return;
  }
  
  void writeAlignmentOn(){
   serial.write("!O,5");
   serial.write(13);
   return;
  }
  
  void readAlignmentPoint(int pointNumber){
   // convert pointNumber to a 2-digit, decimal based string version of itself
   // eg: 2 = '02', 7 = '07', 13 = '13'
   // pointNumber max = 14
   //serial.write(String.format("%02X", pointNumber));
    String outString = "!O,6," + (String.format("%02X", pointNumber));
    //println("@@@@@@@@@@ CHECK ME AND MAKE SURE I LOOK GOOD, BB @@@@@@@@@@");
    //println("readAlignmentPoint outstring:", outString);
    //println("@@@@@@@@@@ CHECK ME AND MAKE SURE I LOOK GOOD, BB @@@@@@@@@@");
    serial.write(outString);
    serial.write(13);
  }
  
  //// add conversion and string building
  //void writeAlignmentPoint(int pointIndex){
  //  serial.write("!O,6");
  //  serial.write(13);
  //  return;
  //}
  
  //void writeAlignPoint(int pointNumber) {
  //  // convert pointNumber to a 2-digit, decimal based string version of itself
  //  // eg: 2 = '02', 7 = '07', 13 = '13'
  //  // pointNumber max = 14
  //  if(pointNumber > 14) {
  //    println("@@@@@@@@@@ writeAlignPoint(int pointNumber) pointNumber out of range! @@@@@@@@@@");
  //    return;
  //  }
  //  serial.write("!O,6,");
  //  serial.write(String.format("%02X", pointNumber));
  //  serial.write(13);
  //}
  
  void writeAlignmentTable(String alignmentTableDirectory) {
    // The as of firmware V011.026 (00B 01A), the alignment table is sent all at once
    // as opposed to sending it with the !0,1 command (when taking the reading)
    
  //  String outAlignmentColors;
  //  String[] alignmentTable = loadStrings(alignmentTableDirectory);
  //  //if(alignmentTable[colorIndex].startsWith(String.valueOf(colorIndex))){
  //    //outAlignmentColors = alignmentTable[colorIndex].substring(2, 13);
  //    //outAlignmentColors = alignmentTable[colorIndex].substring(alignmentTable[colorIndex].indexOf(")") + 1, alignmentTable[colorIndex].length());
  //    outAlignmentColors = alignmentTable[colorIndex].substring(alignmentTable[colorIndex].indexOf("1") + 2, alignmentTable[colorIndex].length());
  //  //}
  //  //else{
  //  //  println("@@@@@@@@@@ calibrateColor(int colorIndex) out of bounds @@@@@@@@@@");
  //  //  return;
  //  //}
  //  String outString = "!O,1," + outAlignmentColors;
  //  //debugging
  //  println(outString);
  //  serial.write(outString);
  //  serial.write(13);
  //  return;
    
    switch(colorTargetsFormat){
      case 0: {
        //String outAlignmentColors;
        String[] alignmentTable = loadStrings(alignmentTableDirectory);
        
        //for(int i = 0 ; i 
        
        //outAlignmentColors = alignmentTable[colorIndex].substring(alignmentTable[colorIndex].indexOf("1") + 2, alignmentTable[colorIndex].length());
        //String[] strings = {prefix, "_output", String.valueOf(randomVal), ".txt"};
        //StringBuilder builder = new StringBuilder();
        //for (String fileName : strings) {
        //  builder.append(fileName);
        //}
        //String fileName = builder.toString();
        
        StringBuilder builder = new StringBuilder();
        for(int i = 0 ; i < alignmentTable.length ; i++) {
          builder.append(alignmentTable[i].substring(4,16));
        }
        
        String outString = "!O,7" + builder.toString();
        //debugging
        //println("builder output:", builder.toString());
        println(outString);
        serial.write(outString);
        serial.write(13);
        break;
      }
      
      case 1: {
        
        break;
      }
      
    }
    return;
  }
  
  void readAlignTargets(){
    utilCreateWriter(writer, "alignTargets");
    serial.write("!O,8");
    serial.write(13);
  }
  
  //void writeStartGetAlign() {
  //  println("Getting align for ", label);
  //  isBusy |= 0x40;
  //  alignIndex = 0;
  //  String logName = "S" + serialNumber.substring(12, 16) + "_alignTable";
  //  newLog(logName);
  //  //writeAlignmentOff();
  //  //delay(commandDelay);
  //  writeAlignPoint(alignIndex);
  //}
  
  //void continueGetAlign() {
  //  isBusy |= 0x40;
  //  writeAlignPoint(++alignIndex);
  //  println("Getting align point ", currentAlignPoint, " for ", label);
  //}
  
  //void stopGetAlign() {
  //  println("Done getting align table for ", label);
  //  isBusy &= ~0x40;
  //  //writeAlignmentOn();
  //}
  
  void writeRetakeRead(int pointNumber){
    // Convert pointNumber to two digit, hex version of itself
    // and append to !O,9 command
    String outString = "!O,9," + String.format("%02X", pointNumber);
    serial.write(outString);
    serial.write(13);
  }
  
  int getAlignIndex(){
    return alignIndex;
  }
  
  void writeCalculateCoefficient() {
    serial.write("!F");
    serial.write(13);
  }
  
  void readCoefficient() {
    serial.write("!f");
    serial.write(13);
  }
  
  void readUDID(){
    serial.write("!D");
    serial.write(13);
  }
  
  void readIlluminationAlgorithm(){
    serial.write("!g");
    serial.write(13);
  }
  
  void parseIlluminationAlgorithm(String inIlluminationAlgorithm){
    ledMa = inIlluminationAlgorithm.substring(3, 7);
    ledMaFloat = (float) Integer.parseInt(ledMa, 16) / 64 / 1023 * 5 / 0.08; // for some reason this is how we convert to mA
    ledDac = inIlluminationAlgorithm.substring(8, 12);
    ledStability = inIlluminationAlgorithm.substring(13,14);
  }
  
  void readPhase(){
    serial.write("!l");
    serial.write(13);
  }
  
  void writePhase(String inPhase){
    serial.write("!L,");
    serial.write(inPhase);
    serial.write(13);
  }
  
  void readEepromFailures(){
    serial.write("!q,");
    serial.write(UDIDcd);
    serial.write(13);
  }
  
  void writeClearEepromFailures(){
    serial.write("!Q,");
    serial.write(UDIDcd);
    serial.write(13);
  }
  
  void parseUDID(String inUDID){
    UDID = inUDID.substring(3,33);
  }
  
  String getUDID(){
    return UDID;
  }
  
  void setUDID(String inUDID){
    UDID = inUDID;
  }
  
  String getUDIDcd(){
    return UDIDcd;
  }
  
  void setUDIDcd(String inUDIDcd){
    UDIDcd = inUDIDcd;
  }
  
  void writeDeleteSerialNumber(String inSerialNumberCode){
    serial.write("!Z,");
    serial.write(inSerialNumberCode);
    serial.write(13);
  }
  
  void writeSerialNumber(String inSerialNumber){
    serial.write("!I,");
    serial.write(inSerialNumber);
    serial.write(13);
  }

  void readTemperature(){
    serial.write("!w\r");
  }

  void parseTemperature(String inTemperature){
    short tempTemp = (short) Integer.parseInt(inTemperature.substring(3,7), 16);  // Convert raw input into a 16-bit signed integer
    temperature = (float) tempTemp / 16;                                          // Convert to floating point ºC
  }
  
  void transferMemory(String inUDIDcd){
    serial.write("!r,");
    serial.write(inUDIDcd);
    serial.write(13);
  }
  
  void transferMemoryBack(String inUDIDcd){
    serial.write("!R,");
    serial.write(inUDIDcd);
    serial.write(13);
  } 
  
  
  
  
  
  
  
  
  
// @@@@@ End of Object @@@@@  
}
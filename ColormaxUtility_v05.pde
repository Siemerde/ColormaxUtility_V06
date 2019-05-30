// ####################################################################################################
// Read me:
// In order to use this program you must install the G4P library by Peter Lager
// To install the G4P Library:
// 1. Go to the menu bar above and click Sketch
// 2. Mouse over Import Library and then click Add Library..., a new window will appear
// 3. In the text box near the top of the new window type G4P
// 4. Select the option with the Name G4P and Author Peter Lauger
// 5. Click Install, it's near the bottom right corner of the new window
// 6. Wait for the library install, this may take several minutes
// 7. You're finished! Close the extra window and have a lovely day
// ####################################################################################################

// Imports
import g4p_controls.*;
import java.awt.Toolkit;
import java.util.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.Timer;

// Colormax serial settings
static int cmaxBaudRate = 115200;
char cmaxParity = 'E';
int cmaxDataBits = 7;
float cmaxStopBits = 1.;

// Alignment table directory
static String alignmentTableDirectory = "//Diskstation/engineering/New_Product_Development/Open_Projects/ColorMax - Biotech/Production Notes and Tests/MASTER CALIBRATION/COLOR TARGETS.txt";

// Variables for finding connected colormaxes
// We MUST define how big these arrays are, even if
// the number of connected colormaxes is variable.. so
// we're just gonna make 100 slots, then check for nulls.
final int slots = 100;
boolean colormaxFoundMap[] = new boolean[slots];
Serial ports[] = new Serial[slots];
Serial colormaxPorts[] = new Serial[slots];
String colormaxPortsDroplistStrings[] = new String[slots];
boolean populatingColormaxes = false;

// Timer
Timer oneSecondTimer;
Timer updateTimer;

Colormax colormaxes[] = new Colormax[100];
GOption[] colorOptions = new GOption[12];

//****************************************************************************************************
// Setup
//****************************************************************************************************
public void setup() {
  size(1024, 576, JAVA2D);
  createGUI();
  customGUI();

  oneSecondTimer = new Timer(1000, oneSecondTimerListener);  // Make a timer that calls oneSecondTimerListener every 1000 milliseconds
  updateTimer = new Timer(750, updateTimerListener);         // Make a timer that calls updateTimerListener every 500 milliseconds
  updateTimer.start();

  int i = 0;
  for (i = 0; i < colormaxes.length; i++) {
    colormaxes[i] = new Colormax("colormax" + i);
  }

  colorOptions[0] = optnColorOne;
  colorOptions[1] = optnColorTwo;
  colorOptions[2] = optnColorThree;
  colorOptions[3] = optnColorFour;
  colorOptions[4] = optnColorFive;
  colorOptions[5] = optnColorSix;
  colorOptions[6] = optnColorSeven;
  colorOptions[7] = optnColorEight;
  colorOptions[8] = optnColorNine;
  colorOptions[9] = optnColorTen;
  colorOptions[10] = optnColorEleven;
  colorOptions[11] = optnColorTwelve;  

  populateColormaxes();
  updateColormaxInfo(colormaxes[listColormaxSelect.getSelectedIndex()]);
}

//****************************************************************************************************
// Draw
//****************************************************************************************************

public void draw() {
  background(230);
}

//****************************************************************************************************
//  Methods
//****************************************************************************************************

// Set boolean array **************************************************
void setBooleanArray(boolean[] inputArray, boolean set) {
  for (int i = 0; i < inputArray.length; i++) {
    colormaxFoundMap[i] = set;
  }
}

// Nullify String arrays **************************************************
void nullifyStringArray(String[] inputArray) {
  for (int i = 0; i < inputArray.length; i++ ) {
    inputArray[i] = null;
  }
}

// colormaxPorts Reset **************************************************
void colormaxPortsReset() {
  int i = 0;
  for (i = 0; i < colormaxes.length; i++) {
    colormaxes[i].endSerial();
  }
}

// Update the droplist **************************************************
void updateColormaxDroplist() {
  int i = 0;

  // Clear colormax Droplist
  for (i = 0; i < slots; i++) {
    listColormaxSelect.removeItem(i);
  }

  // Check if we even have colormaxes connected
  // If we do, EZ Clap
  if (colormaxPortsDroplistStrings[0] != null) {
    listColormaxSelect.setItems(colormaxPortsDroplistStrings, 0);
  }
  // If we don't, display a message
  else {
    listColormaxSelect.setItems(new String[] {"No Colormaxes Available"}, 0);
  }
}

// Populate Colormaxes **************************************************
void populateColormaxes() {
  int i = 0;
  int j = 0;
  int responseTimeout = 250;
  populatingColormaxes = true;

  //println("resetting stuff");  //for debugging

  // Reset some stuff
  setBooleanArray(colormaxFoundMap, false);
  colormaxPortsReset();
  nullifyStringArray(colormaxPortsDroplistStrings);

  //println("starting population")  // For debugging

  // Populate ports[] with all current serial ports
  // initialize with colormax settings
  for (i = 0; i < Serial.list().length; i++) {
    try {
      ports[i] = new Serial(this, Serial.list()[i], cmaxBaudRate, cmaxParity, cmaxDataBits, cmaxStopBits);
      ports[i].bufferUntil(13);
    }
    catch(Exception e) {
      println(e);
    }
  }

  // Send a value over every connected serial port 
  // and wait for a colormax response (handled in serialEvent())
  // If we don't get a response within the timeout period
  // then we assume there's no colormax and move on
  for (i = 0; i < Serial.list().length; i++) {
    if (ports[i] != null) {
      ports[i].write(13);
      int startMillis = millis();
      while (!colormaxFoundMap[i]) {
        delay(1); // we need to slow the program down for some reason.. leave this here
        if (millis() - startMillis > responseTimeout) {
          println("@@@@@@@@@@", ports[i].port.getPortName(), "response timeout @@@@@@@@@@");
          break;
        }
      }
    }
  }

  // Initialize colormaxPorts[], then populate it
  // with ports that we know have colormaxes attached
  for (i = 0; i < ports.length; i++) {
    if (colormaxFoundMap[i] == true
      && ports[i] != null) {
      colormaxPortsDroplistStrings[j] = ports[i].port.getPortName();
      colormaxes[j].setSerial(ports[i]);
      colormaxPorts[j] = ports[i];
      j++;
    }  
    // If there's no colormax on that port, close it
    // and return that slot to null
    else if (ports[i] != null) {
      ports[i].clear();
      ports[i].stop();
      ports[i] = null;
    }
  }

  // Last thing to do is update the droplist
  updateColormaxDroplist();
  //println("colormaxes populated");  // for debugging
  populatingColormaxes = false;
  return;
}

// Update Colormax Info **************************************************
void updateColormaxInfo(Colormax inColormax) {
  if (inColormax.getSerial() != null) {
    inColormax.updateInfo();
    //delay(100);

    // Legacy code for updating color percentages with precision to hundreths
    //lblRedPercentData.setText(String.format("%.2f", inColormax.getRedPercent() - 0.005) + "%");
    //lblGreenPercentData.setText(String.format("%.2f", inColormax.getGreenPercent() - 0.005) + "%");
    //lblBluePercentData.setText(String.format("%.2f", inColormax.getBluePercent() - 0.005) + "%");

    lblRedPercentData.setText(String.format("%.1f", inColormax.getRedPercent() - 0.05) + "%");
    lblGreenPercentData.setText(String.format("%.1f", inColormax.getGreenPercent() - 0.05) + "%");
    lblBluePercentData.setText(String.format("%.1f", inColormax.getBluePercent() - 0.05) + "%");
    lblRedHexData.setText(String.valueOf(inColormax.getRed()) + "H");
    lblGreenHexData.setText(String.valueOf(inColormax.getGreen()) + "H");
    lblBlueHexData.setText(String.valueOf(inColormax.getBlue()) + "H");
    lblTemperatureData.setText(String.format("%.2f", inColormax.getTemperature() - 0.005));
    ////lblLEDCurrentData.setText(inColormax.getLedMa());
    lblLEDCurrentData.setText(String.format("%.2f", inColormax.getLedMaFloat() - 0.005));
    lblDACSettingData.setText(inColormax.getLedDac());
    lblLedStabilityData.setText(inColormax.getLedStability());
    lblAveragingData.setText(inColormax.getAveraging());
    lblTriggeringData.setText(inColormax.getTriggering());
    lblOutputDelayData.setText(inColormax.getOutputDelay());
    lblIlluminationData.setText(String.valueOf(inColormax.getIllumination()));
    lblModelData.setText(inColormax.getModel());
    lblFirmwareVersionData.setText(inColormax.getVersion());
    lblSerialNumberData.setText(inColormax.getSerialNumber());
  } else {
    println("no colormax, UwU");
  }
}

// Align Colors **************************************************
void alignColor(final Colormax inColormax) {
  //final int wait = 5000;  // Timer delay in milliseconds
  //Timer alignTimer = new Timer();

  // Check if the colormax is already busy or not
  if (inColormax.getStatus() != inColormax.idle) {
    println("@@@@@@@@@@ CANNOT CALIBRATE COLOR, COLORMAX IS BUSY @@@@@@@@@@");
    println(inColormax.getStatus());
    return;
  }

  oneSecondTimer.start();                                      // Start the timer!
  btnCalibrateColor.setLocalColorScheme(GCScheme.YELLOW_SCHEME); // Change the button to yellow
  inColormax.setStatus(inColormax.calibrating);                  // Change colormax's status

  //// Create a TimerTask; this will run after the timer expires
  // TimerTask alignColorTT = new TimerTask(){
  //  public void run() {
  //    inColormax.writeTempOn();       // Verify Colormax is using TempTable
  //    delay(100);                     // 100ms delay to make sure colormax gets the command
  //    inColormax.writeStartAlign();   // Verify Colormax is in AlmProcs
  //    delay(100);                     // 100ms delay to make sure colormax gets the command
  //    inColormax.writeAlignColor();   // Tell colormax to take readings
  //    inColormax.setStatus(inColormax.idle);  // Reset Colormax status
  //    btnCalibrateColor.setLocalColorScheme(GCScheme.CYAN_SCHEME); // Set button back to the default color scheme

  //    // Check if user wants to hear a beep
  //    if(chkBeepOnRead.isSelected()){
  //          Toolkit.getDefaultToolkit().beep();
  //    }

  //    // Move the radio selection for the user
  //    for (int i = 0; i < colorOptions.length; i++) {
  //      if (colorOptions[i].isSelected()) {
  //        try {
  //          colorOptions[++i].setSelected(true);
  //        }
  //        catch(ArrayIndexOutOfBoundsException e) {
  //          colorOptions[0].setSelected(true);
  //        }
  //        break;
  //      }
  //    }
  //  }
  //};

  //timer.schedule(alignColorTT, (long)(wait));  // Set the timer

  // Legacy code, from before we had discrete timertasks
  //// This will run after the timer expires
  //alignTimer.schedule(new TimerTask() {
  //  public void run() {
  //    // Verify Colormax is in AlmProcs
  //    // 100ms delay to make sure colormax get sthe command
  //    // Tell colormax to take readings
  //    inColormax.writeStartAlign();
  //    delay(100);
  //    inColormax.writeAlignColor();
  //    inColormax.setStatus(inColormax.idle);

  //    // Move the radio selection for the user
  //    for (int i = 0; i < colorOptions.length; i++) {
  //      if (colorOptions[i].isSelected()) {
  //        try {
  //          colorOptions[++i].setSelected(true);
  //        }
  //        catch(ArrayIndexOutOfBoundsException e) {
  //          colorOptions[0].setSelected(true);
  //        }
  //        btnCalibrateColor.setLocalColorScheme(GCScheme.CYAN_SCHEME);

  //        if(chkBeepOnRead.isSelected()){
  //          Toolkit.getDefaultToolkit().beep();
  //        }

  //        break;
  //      }
  //    }
  //  }
  //}
  //// Set when the timer will go off
  //, (long)(wait) );
  return;
}

// Retake Color Reading **************************************************
void retakeRead(final Colormax inColormax, final int colorIndex) {
  //final int wait = 5000;  // Timer delay in milliseconds
  //Timer retakeTimer = new Timer();

  // Check if the colormax is already busy or not
  if (inColormax.getStatus() != "idle") {
    println("@@@@@@@@@@ CANNOT RETAKE POINT COLOR, COLORMAX IS BUSY @@@@@@@@@@");
    return;
  }

  oneSecondTimer.start();                                      // Start the timer!
  btnRetakePoint.setLocalColorScheme(GCScheme.YELLOW_SCHEME);  // Change the button to yellow
  inColormax.setStatus(inColormax.retakingPoint);              // Change colormax's status

  //// Create a TimerTask; this will run after the timer expires
  //TimerTask retakeReadTT = new TimerTask() {
  //  public void run() {
  //    inColormax.writeTempOn();                // Verify temp table is on, cuz we need that
  //    delay(100);                              // 100ms delay to make sure colormax gets the command
  //    inColormax.writeRetakeRead(colorIndex);  // Tell the colormax to retake the reading
  //    inColormax.setStatus(inColormax.idle);   // Reset Colormax status
  //    btnRetakePoint.setLocalColorScheme(GCScheme.CYAN_SCHEME); // Set button back to the default color scheme

  //    // Check if the user wants to hear a beep
  //    if(chkBeepOnRead.isSelected()){
  //      Toolkit.getDefaultToolkit().beep();
  //    }
  //  }
  //};

  //timer.schedule(retakeReadTT, (long)(wait) );
  return;
}

void sendSettings(Colormax inColormax) {
  //int commandDelay = 50;  // delay in milliseconds between commands

  String averaging = Integer.toString(listAveraging.getSelectedIndex());
  String triggering = Integer.toString(listTriggering.getSelectedIndex());
  String outputDelay = listOutputDuration.getSelectedText();
  int illumination = sldrIllumination.getValueI();
  inColormax.sendSettings(averaging, triggering, outputDelay, illumination);
}

// Timer Listeners **************************************************
volatile int counter = 0;
ActionListener oneSecondTimerListener = new ActionListener() {
  public void actionPerformed(ActionEvent e) {
    final int max = 60;
    int colorIndex = 0;
    counter++;
    println("counter: ", counter);  //for debugging

    // quick fix to make this code work from where it used to be
    Colormax inColormax = colormaxes[listColormaxSelect.getSelectedIndex()];

    // Get which color is selected
    for (colorIndex = 0; colorIndex < colorOptions.length; colorIndex++) {
      if (colorOptions[colorIndex].isSelected()) {
        break;
      }
    }

    // Check for negative values real fast
    if (counter < 0) {
      println("@@@@@ timer counter error; non-positive value @@@@@");
    } else if (counter >= max) {
      counter = 0;            // Reset counter
      oneSecondTimer.stop();  // End timer
      println("it is time");  //for debugging

      // Calibrating color
      if (inColormax.getStatus() == inColormax.calibrating) {
        inColormax.writeTempOn();       // Verify Colormax is using TempTable
        delay(100);                     // 100ms delay to make sure colormax gets the command
        inColormax.writeStartAlign();   // Verify Colormax is in AlmProcs
        delay(100);                     // 100ms delay to make sure colormax gets the command
        inColormax.writeAlignColor();   // Tell colormax to take readings
        inColormax.setStatus(inColormax.idle);  // Reset Colormax status
        btnCalibrateColor.setLocalColorScheme(GCScheme.CYAN_SCHEME); // Set button back to the default color scheme

        // Check if user wants to hear a beep
        if (chkBeepOnRead.isSelected()) {
          Toolkit.getDefaultToolkit().beep();
        }

        // Move the radio selection for the user
        for (int i = 0; i < colorOptions.length; i++) {
          if (colorOptions[i].isSelected()) {
            try {
              colorOptions[++i].setSelected(true);
            }
            catch(ArrayIndexOutOfBoundsException ex) {
              colorOptions[0].setSelected(true);
            }
            break;
          }
        }
      }

      // Retaking point
      else if (inColormax.getStatus() == inColormax.retakingPoint) {
        inColormax.writeTempOn();                // Verify temp table is on, cuz we need that
        delay(100);                              // 100ms delay to make sure colormax gets the command
        inColormax.writeRetakeRead(colorIndex);  // Tell the colormax to retake the reading
        inColormax.setStatus(inColormax.idle);   // Reset Colormax status
        btnRetakePoint.setLocalColorScheme(GCScheme.CYAN_SCHEME); // Set button back to the default color scheme

        // Check if the user wants to hear a beep
        if (chkBeepOnRead.isSelected()) {
          Toolkit.getDefaultToolkit().beep();
        }
      }
    }
  }
};

volatile boolean checkingLine = false;    // Variable to indicate to serialEvent that we're checking if we have a colormax on the line
volatile boolean colormaxOnLine = false;  // Variable telling us we have one on the line
ActionListener updateTimerListener = new ActionListener() {
  public void actionPerformed(ActionEvent e) {
    if (chkContinuousUpdate.isSelected()) {
      checkingLine = true;
      colormaxOnLine = false;
      colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13);
      int timeout = 50;
      int startMillis = millis();
      while (!colormaxOnLine) {
        delay(1);
        if (millis() - startMillis > timeout) {
          checkingLine = false;
          return;
        }
      }
      if (colormaxOnLine) {
        updateColormaxInfo(colormaxes[listColormaxSelect.getSelectedIndex()]);
      }
    }
  }
};

// Cancel Align/Retake timers **************************************************
void cancelAlignRetake(Colormax inColormax) {
  // Set UI elements back to normal
  btnRetakePoint.setLocalColorScheme(GCScheme.CYAN_SCHEME);     // Set button back to the default color scheme
  btnCalibrateColor.setLocalColorScheme(GCScheme.CYAN_SCHEME);  // Set button back to the default color scheme

  inColormax.setStatus(inColormax.idle);  // Reset Colormax status

  oneSecondTimer.stop();    // Stop the timer
  counter = 0;              // Reset counter
  //retakeReadTT.cancel();  // 
  //alignColorTT.cancel();  //
}

//boolean continuePopup(String message) {


//  return false;
//}

// cheat button for teaching 96 brightness paper to four channels
void cheatButton1337() {
  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13); // clear buffer and whatnot

  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write("!C,0,0,1,0,FE5C,FFC0,FE6D,FFC0,FE66,FFC0");
  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13);
  delay(250);

  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write("!C,1,0,1,0,FE5C,FFC0,FE6D,FFC0,FE66,FFC0");
  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13);
  delay(250);

  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write("!C,2,0,1,0,FE5C,FFC0,FE6D,FFC0,FE66,FFC0");
  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13);
  delay(250);

  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write("!C,3,0,1,0,FE5C,FFC0,FE6D,FFC0,FE66,FFC0");
  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13);
  delay(250);

  colormaxes[listColormaxSelect.getSelectedIndex()].sendSettings("8", "0", "0", 100);
  delay(250);

  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write("!A,3E0");
  colormaxes[listColormaxSelect.getSelectedIndex()].serial.write(13);
}

// Get Align Table **************************************************
volatile int point;
volatile Colormax currentColormax;
void getAlignTable(Colormax inColormax) {
  inColormax.setStatus("gettingAlignTable");
  String logName = inColormax.getSerialNumber().substring(12, 16) + " alignTable";
  inColormax.newLog(logName);
  inColormax.readAlignmentPoint(0);
}

// Get Align Table **************************************************
void getTempTable(Colormax inColormax) {
  inColormax.setStatus("gettingTempTable");
  String logName = inColormax.getSerialNumber().substring(12, 16) + " tempTable";
  inColormax.newLog(logName);
  inColormax.readTempPoint(0);
}

// Key Pressed Event Listener **************************************************
void keyPressed() {
  // Spacebar Shortcut Handler
  if (key == ' '
    && chkSpacebarShortcut.isSelected()) {
    btnCalibrateColor_click1(btnCalibrateColor, GEvent.CLICKED);
  }
}

// Serial Event Listener **************************************************
void serialEvent(Serial inPort) {
  String inString = inPort.readString();
  // TO DO: MAKE FUNCTION TO FIGURE OUT WHICH COLORMAX MESSAGE CAME FROM

  println("Recieved:", inString);  //for debugging

  // Check if it's a colormax response
  // If it is, and we're looking for colormaxes,
  // update the map
  if (inString.startsWith("?") ) {
    if (populatingColormaxes) {
      for (int i = 0; i < ports.length; i++) {
        if (inPort == ports[i]) {
          println("Colormax on", ports[i].port.getPortName());
          colormaxFoundMap[i] = true;
          break;
        }
      }
    } else if (checkingLine) {
      colormaxOnLine = true;
    }

    return;
  }  

  if (inString.startsWith("!d")) {
    //println(inString);
    if (colormaxes[listColormaxSelect.getSelectedIndex()].getStatus() == colormaxes[listColormaxSelect.getSelectedIndex()].settingIlluminationFactor) {
      //int blue = Integer.parseInt(blueChannel, 16);
      colormaxes[listColormaxSelect.getSelectedIndex()].lightAdjustmentCalibrateContinue(Integer.parseInt(inString.substring(13, 17), 16));
    }
    return;
  }

  if (inString.startsWith("!h")) {
    //println("got clt");
    //println(inString);
    colormaxes[listColormaxSelect.getSelectedIndex()].parseClt(inString);
    return;
  }

  if (inString.startsWith("!s")) {
    colormaxes[listColormaxSelect.getSelectedIndex()].parseSettings(inString);
    return;
  }

  if (inString.startsWith("!i")) {
    colormaxes[listColormaxSelect.getSelectedIndex()].parseIdentity(inString);
    return;
  }

  if (inString.startsWith("!v")) {
    colormaxes[listColormaxSelect.getSelectedIndex()].parseVersion(inString);
    return;
  }

  if (inString.startsWith("!a")) {
    colormaxes[listColormaxSelect.getSelectedIndex()].parseIlluminationSetting(inString);
    return;
  }
  
  if (inString.startsWith("!N")) {
    if (inString.startsWith("!N,6")) {
      if (colormaxes[listColormaxSelect.getSelectedIndex()].getStatus() == ("gettingTempTable")) {
        if (inString.contains("!N,6,1")){
          colormaxes[listColormaxSelect.getSelectedIndex()].setStatus("idle");
          colormaxes[listColormaxSelect.getSelectedIndex()].endLog();
        } else {
          colormaxes[listColormaxSelect.getSelectedIndex()].writeToLog(inString);
          int point = Integer.parseInt(inString.substring(7, 9), 16) + 1;    //Integer.parseInt(inClt.substring(3, 7), 16);
          colormaxes[listColormaxSelect.getSelectedIndex()].readTempPoint(point);
        }
      }
    }
  }

  if (inString.startsWith("!O")) {
    if (inString.startsWith("!O,6")) {
      if (colormaxes[listColormaxSelect.getSelectedIndex()].getStatus() == ("gettingAlignTable")) {
        if (inString.startsWith("!O,6,1")){
          colormaxes[listColormaxSelect.getSelectedIndex()].setStatus("idle");
          colormaxes[listColormaxSelect.getSelectedIndex()].endLog();
        } else {
          //println("status check successful");
          colormaxes[listColormaxSelect.getSelectedIndex()].writeToLog(inString);
          int point = Integer.parseInt(inString.substring(7, 9), 16) + 1;    //Integer.parseInt(inClt.substring(3, 7), 16);
          //println("point: ", point);
          colormaxes[listColormaxSelect.getSelectedIndex()].readAlignmentPoint(point);
        }
      }
    }
    if (inString.startsWith("!O,8,0")) {
    }
  }

  //if (inString.startsWith("!O,6")) {
  //  if (inString.equals("!O,6,1\r")) {
  //    if (testBit(colormaxes[listColormaxSelect.getSelectedIndex()].isBusy(), 6)) {
  //      colormaxes[listColormaxSelect.getSelectedIndex()].stopGetAlign();
  //      colormaxes[listColormaxSelect.getSelectedIndex()].writeAlignmentOn();
  //      String numberOfPoints = "Number of points: " + String.valueOf(colormaxes[listColormaxSelect.getSelectedIndex()].getAlignIndex());
  //      colormaxes[listColormaxSelect.getSelectedIndex()].writeToLog(numberOfPoints);
  //      colormaxes[listColormaxSelect.getSelectedIndex()].endLog();
  //      return;
  //    }
  //  } else if (testBit(colormaxes[listColormaxSelect.getSelectedIndex()].isBusy(), 6)) {
  //    colormaxes[listColormaxSelect.getSelectedIndex()].writeToLog(inString);
  //    colormaxes[listColormaxSelect.getSelectedIndex()].continueGetAlign();
  //    return;
  //  }
  //}

  // @@@@@@@@@@ End of serialEvent() @@@@@@@@@@
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}
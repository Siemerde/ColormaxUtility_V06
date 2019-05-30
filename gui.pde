/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void listColormaxSelect_click1(GDropList source, GEvent event) { //_CODE_:listColormaxSelect:844591:
  println("listColormaxSelect - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:listColormaxSelect:844591:

public void GREEN_SCHEME(GButton source, GEvent event) { //_CODE_:btnRefresh:428133:
  populateColormaxes();
  println("btnRefresh - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btnRefresh:428133:

public void btnUpdateData_click1(GButton source, GEvent event) { //_CODE_:btnUpdateData:521190:
  updateColormaxInfo(colormaxes[listColormaxSelect.getSelectedIndex()]);
  println("btnUpdate - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btnUpdateData:521190:

public void listAveraging_click1(GDropList source, GEvent event) { //_CODE_:listAveraging:447613:
  println("listAveraging - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:listAveraging:447613:

public void listTriggering_click1(GDropList source, GEvent event) { //_CODE_:listTriggering:867079:
  println("dropList1 - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:listTriggering:867079:

public void listOutputDuration_click1(GDropList source, GEvent event) { //_CODE_:listOutputDuration:833188:
  println("dropList1 - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:listOutputDuration:833188:

public void sldrIllumination_change1(GSlider source, GEvent event) { //_CODE_:sldrIllumination:539067:
  println("slider1 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:sldrIllumination:539067:

public void optnColorOne_clicked1(GOption source, GEvent event) { //_CODE_:optnColorOne:665794:
  println("option1 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorOne:665794:

public void optnColorTwo_clicked1(GOption source, GEvent event) { //_CODE_:optnColorTwo:692573:
  println("option2 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorTwo:692573:

public void optnColorThree_clicked1(GOption source, GEvent event) { //_CODE_:optnColorThree:465693:
  println("option3 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorThree:465693:

public void option4_clicked1(GOption source, GEvent event) { //_CODE_:optnColorFour:307884:
  println("option4 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorFour:307884:

public void optnColorFive_clicked1(GOption source, GEvent event) { //_CODE_:optnColorFive:286741:
  println("option5 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorFive:286741:

public void optnColorSix_clicked1(GOption source, GEvent event) { //_CODE_:optnColorSix:248261:
  println("option6 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorSix:248261:

public void optnColorSeven_clicked1(GOption source, GEvent event) { //_CODE_:optnColorSeven:229513:
  println("option7 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorSeven:229513:

public void optnColorEight_clicked1(GOption source, GEvent event) { //_CODE_:optnColorEight:976941:
  println("option8 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorEight:976941:

public void option9_clicked1(GOption source, GEvent event) { //_CODE_:optnColorNine:330584:
  println("option9 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorNine:330584:

public void optnColorTen_clicked1(GOption source, GEvent event) { //_CODE_:optnColorTen:979998:
  println("option10 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorTen:979998:

public void optnColorEleven_clicked1(GOption source, GEvent event) { //_CODE_:optnColorEleven:575106:
  println("option11 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorEleven:575106:

public void optnColorTwelve_clicked1(GOption source, GEvent event) { //_CODE_:optnColorTwelve:746597:
  println("option12 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:optnColorTwelve:746597:

public void btnCalibrateColor_click1(GButton source, GEvent event) { //_CODE_:btnCalibrateColor:609459:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  int i = 0;
  for(i = 0 ; i < colorOptions.length ; i++ ){
   if(colorOptions[i].isSelected()){
     break;
   }
  }
  alignColor(colormaxes[listColormaxSelect.getSelectedIndex()]);
} //_CODE_:btnCalibrateColor:609459:

public void btnCalibrateLight_click1(GButton source, GEvent event) { //_CODE_:btnCalibrateLight:477821:
  println("button2 - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].lightAdjustmentCalibrateStart();
} //_CODE_:btnCalibrateLight:477821:

public void txtSerialNumberInput_change1(GTextField source, GEvent event) { //_CODE_:txtSerialNumberInput:346953:
  println("txtSerialNumberInput - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:txtSerialNumberInput:346953:

public void btnChangeSerialNumber_click1(GButton source, GEvent event) { //_CODE_:btnChangeSerialNumber:630693:
  println("btnChangeSerialNumber - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btnChangeSerialNumber:630693:

public void btnClearSerialNumber_click1(GButton source, GEvent event) { //_CODE_:btnClearSerialNumber:920555:
  println("btnClearSerialNumber - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btnClearSerialNumber:920555:

public void btnSendSettings_click1(GButton source, GEvent event) { //_CODE_:btnSendSettings:286678:
  println("btnSendSettings - GButton >> GEvent." + event + " @ " + millis());
  sendSettings(colormaxes[listColormaxSelect.getSelectedIndex()]);
} //_CODE_:btnSendSettings:286678:

public void btnStoreAlign_click1(GButton source, GEvent event) { //_CODE_:btnStoreAlign:239238:
  println("btnStoreAlign - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeStoreAlignment();
} //_CODE_:btnStoreAlign:239238:

public void btnDiscardAlign_click1(GButton source, GEvent event) { //_CODE_:btnDiscardAlign:856422:
  println("btnDiscardAlign - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeDiscardAlignment();
} //_CODE_:btnDiscardAlign:856422:

public void btnAlignOn_click1(GButton source, GEvent event) { //_CODE_:btnAlignOn:917837:
  println("btnAlignOn - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeAlignmentOn();
} //_CODE_:btnAlignOn:917837:

public void btnAlignOff_click1(GButton source, GEvent event) { //_CODE_:btnAlignOff:914443:
  println("btnAlignOff - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeAlignmentOff();
} //_CODE_:btnAlignOff:914443:

public void btnTempOn_click1(GButton source, GEvent event) { //_CODE_:btnTempOn:636267:
  println("btnTempOn - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeTempOn();
} //_CODE_:btnTempOn:636267:

public void btnTempOff_click1(GButton source, GEvent event) { //_CODE_:btnTempOff:933616:
  println("btnTempOff - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeTempOff();
} //_CODE_:btnTempOff:933616:

public void btnSetLight50_click1(GButton source, GEvent event) { //_CODE_:btnSetLight50:807847:
  println("btnSetLight50 - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].sendSettings("8", "0", "0", 50);
} //_CODE_:btnSetLight50:807847:

public void btnSetLight100_click1(GButton source, GEvent event) { //_CODE_:btnSetLight100:719174:
  println("btnSetLight100 - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].sendSettings("8", "0", "0", 100);
} //_CODE_:btnSetLight100:719174:

public void btnCheatButton1337_click1(GButton source, GEvent event) { //_CODE_:btnCheatButton1337:430844:
  println("btnCheatButton1337 - GButton >> GEvent." + event + " @ " + millis());
  cheatButton1337();
} //_CODE_:btnCheatButton1337:430844:

public void chkContinuousRefresh_clicked1(GCheckbox source, GEvent event) { //_CODE_:chkContinuousRefresh:573275:
  println("chkContinuousRefresh - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:chkContinuousRefresh:573275:

public void chkContinuousUpdate_clicked1(GCheckbox source, GEvent event) { //_CODE_:chkContinuousUpdate:727058:
  println("chkContinuousUpdate - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:chkContinuousUpdate:727058:

public void chkSpacebarShortcut_clicked1(GCheckbox source, GEvent event) { //_CODE_:chkSpacebarShortcut:342014:
  println("btnSpacebarShortcut - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:chkSpacebarShortcut:342014:

public void btnCalcCoefficient_click1(GButton source, GEvent event) { //_CODE_:btnCalcCoefficient:864659:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeCalculateCoefficient();
} //_CODE_:btnCalcCoefficient:864659:

public void btnSendTargets_click1(GButton source, GEvent event) { //_CODE_:btnSendTargets:622220:
  println("button2 - GButton >> GEvent." + event + " @ " + millis());
  colormaxes[listColormaxSelect.getSelectedIndex()].writeAlignmentTable(alignmentTableDirectory);
} //_CODE_:btnSendTargets:622220:

public void chkBeepOnRead_clicked1(GCheckbox source, GEvent event) { //_CODE_:chkBeepOnRead:365230:
  println("checkbox1 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:chkBeepOnRead:365230:

public void btnRetakePoint_click1(GButton source, GEvent event) { //_CODE_:btnRetakePoint:685361:
  println("btnRetakePoint - GButton >> GEvent." + event + " @ " + millis());
  int i = 0;
  for(i = 0 ; i < colorOptions.length ; i++ ){
   if(colorOptions[i].isSelected()){
     break;
   }
  }
  retakeRead(colormaxes[listColormaxSelect.getSelectedIndex()], i);
} //_CODE_:btnRetakePoint:685361:

public void btnCancel_click1(GButton source, GEvent event) { //_CODE_:btnCancel:511767:
  println("btnCancel - GButton >> GEvent." + event + " @ " + millis());
  cancelAlignRetake(colormaxes[listColormaxSelect.getSelectedIndex()]);
} //_CODE_:btnCancel:511767:

public void btnGetAlignTable_click1(GButton source, GEvent event) { //_CODE_:btnGetAlignTable:237531:
  println("btnGetColorTable - GButton >> GEvent." + event + " @ " + millis());
  getAlignTable(colormaxes[listColormaxSelect.getSelectedIndex()]);
} //_CODE_:btnGetAlignTable:237531:

public void btnGetTempTable_click1(GButton source, GEvent event) { //_CODE_:btnGetTempTable:816415:
  println("btnGetTempTable - GButton >> GEvent." + event + " @ " + millis());
  getTempTable(colormaxes[listColormaxSelect.getSelectedIndex()]);
} //_CODE_:btnGetTempTable:816415:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.CYAN_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  listColormaxSelect = new GDropList(this, 10, 30, 240, 220, 10);
  listColormaxSelect.setItems(loadStrings("list_844591"), 0);
  listColormaxSelect.addEventHandler(this, "listColormaxSelect_click1");
  btnRefresh = new GButton(this, 10, 60, 150, 20);
  btnRefresh.setText("Refresh Connections");
  btnRefresh.setTextBold();
  btnRefresh.addEventHandler(this, "GREEN_SCHEME");
  lblRed = new GLabel(this, 10, 120, 80, 20);
  lblRed.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblRed.setText("Red");
  lblRed.setTextBold();
  lblRed.setOpaque(false);
  lblGreen = new GLabel(this, 90, 120, 80, 20);
  lblGreen.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblGreen.setText("Green");
  lblGreen.setTextBold();
  lblGreen.setOpaque(false);
  lblBlue = new GLabel(this, 170, 120, 80, 20);
  lblBlue.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblBlue.setText("Blue");
  lblBlue.setTextBold();
  lblBlue.setOpaque(false);
  lblRedPercentData = new GLabel(this, 10, 140, 80, 20);
  lblRedPercentData.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblRedPercentData.setText("N/A");
  lblRedPercentData.setOpaque(false);
  lblGreenPercentData = new GLabel(this, 90, 140, 80, 20);
  lblGreenPercentData.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblGreenPercentData.setText("N/A");
  lblGreenPercentData.setOpaque(false);
  lblBluePercentData = new GLabel(this, 170, 140, 80, 20);
  lblBluePercentData.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblBluePercentData.setText("N/A");
  lblBluePercentData.setOpaque(false);
  lblRedHexData = new GLabel(this, 10, 160, 80, 20);
  lblRedHexData.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblRedHexData.setText("N/A");
  lblRedHexData.setOpaque(false);
  lblGreenHexData = new GLabel(this, 90, 160, 80, 20);
  lblGreenHexData.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblGreenHexData.setText("N/A");
  lblGreenHexData.setOpaque(false);
  lblBlueHexData = new GLabel(this, 170, 160, 80, 20);
  lblBlueHexData.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblBlueHexData.setText("N/A");
  lblBlueHexData.setOpaque(false);
  lblTemperature = new GLabel(this, 10, 210, 110, 20);
  lblTemperature.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblTemperature.setText("Temperature (ºC):");
  lblTemperature.setTextBold();
  lblTemperature.setOpaque(false);
  lblTemperatureData = new GLabel(this, 120, 210, 80, 20);
  lblTemperatureData.setText("N/A");
  lblTemperatureData.setOpaque(false);
  lblLEDCurrent = new GLabel(this, 10, 230, 110, 20);
  lblLEDCurrent.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblLEDCurrent.setText("LED Current (mA):");
  lblLEDCurrent.setTextBold();
  lblLEDCurrent.setOpaque(false);
  lblLEDCurrentData = new GLabel(this, 120, 230, 80, 20);
  lblLEDCurrentData.setText("N/A");
  lblLEDCurrentData.setOpaque(false);
  lblDACSetting = new GLabel(this, 10, 250, 110, 20);
  lblDACSetting.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblDACSetting.setText("LED DAC Setting:");
  lblDACSetting.setTextBold();
  lblDACSetting.setOpaque(false);
  lblDACSettingData = new GLabel(this, 120, 250, 80, 20);
  lblDACSettingData.setText("N/A");
  lblDACSettingData.setOpaque(false);
  lblSerialNumber = new GLabel(this, 10, 390, 110, 20);
  lblSerialNumber.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblSerialNumber.setText("Serial Number:");
  lblSerialNumber.setTextBold();
  lblSerialNumber.setOpaque(false);
  lblSerialNumberData = new GLabel(this, 120, 390, 130, 20);
  lblSerialNumberData.setText("N/A");
  lblSerialNumberData.setOpaque(false);
  lblAveraging = new GLabel(this, 10, 300, 110, 20);
  lblAveraging.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblAveraging.setText("Averaging:");
  lblAveraging.setTextBold();
  lblAveraging.setOpaque(false);
  lblAveragingData = new GLabel(this, 120, 300, 80, 20);
  lblAveragingData.setText("N/A");
  lblAveragingData.setOpaque(false);
  lblTriggering = new GLabel(this, 10, 320, 110, 20);
  lblTriggering.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblTriggering.setText("Triggering:");
  lblTriggering.setTextBold();
  lblTriggering.setOpaque(false);
  lblTriggeringData = new GLabel(this, 120, 320, 80, 20);
  lblTriggeringData.setText("N/A");
  lblTriggeringData.setOpaque(false);
  lblOutputDelay = new GLabel(this, 10, 340, 110, 20);
  lblOutputDelay.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblOutputDelay.setText("Output Delay:");
  lblOutputDelay.setTextBold();
  lblOutputDelay.setOpaque(false);
  lblOutputDelayData = new GLabel(this, 120, 340, 80, 20);
  lblOutputDelayData.setText("N/A");
  lblOutputDelayData.setOpaque(false);
  lblIllumination = new GLabel(this, 10, 360, 110, 20);
  lblIllumination.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblIllumination.setText("Illumination %:");
  lblIllumination.setTextBold();
  lblIllumination.setOpaque(false);
  lblIlluminationData = new GLabel(this, 120, 360, 80, 20);
  lblIlluminationData.setText("N/A");
  lblIlluminationData.setOpaque(false);
  lblModel = new GLabel(this, 10, 410, 110, 20);
  lblModel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblModel.setText("Model:");
  lblModel.setTextBold();
  lblModel.setOpaque(false);
  lblModelData = new GLabel(this, 120, 410, 80, 20);
  lblModelData.setText("N/A");
  lblModelData.setOpaque(false);
  lblFirmwareVersion = new GLabel(this, 10, 430, 110, 20);
  lblFirmwareVersion.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblFirmwareVersion.setText("Firmware Version:");
  lblFirmwareVersion.setTextBold();
  lblFirmwareVersion.setOpaque(false);
  lblFirmwareVersionData = new GLabel(this, 120, 430, 80, 20);
  lblFirmwareVersionData.setText("N/A");
  lblFirmwareVersionData.setOpaque(false);
  btnUpdateData = new GButton(this, 10, 90, 150, 20);
  btnUpdateData.setText("Update Values");
  btnUpdateData.setTextBold();
  btnUpdateData.addEventHandler(this, "btnUpdateData_click1");
  lblSensorSettings = new GLabel(this, 260, 30, 190, 20);
  lblSensorSettings.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblSensorSettings.setText("Sensor Settings");
  lblSensorSettings.setTextBold();
  lblSensorSettings.setOpaque(false);
  listAveraging = new GDropList(this, 360, 60, 90, 200, 9);
  listAveraging.setItems(loadStrings("list_447613"), 8);
  listAveraging.addEventHandler(this, "listAveraging_click1");
  lblAveragingList = new GLabel(this, 260, 60, 100, 20);
  lblAveragingList.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblAveragingList.setText("Averaging:");
  lblAveragingList.setTextBold();
  lblAveragingList.setOpaque(false);
  listTriggering = new GDropList(this, 360, 120, 90, 80, 3);
  listTriggering.setItems(loadStrings("list_867079"), 0);
  listTriggering.addEventHandler(this, "listTriggering_click1");
  label1 = new GLabel(this, 260, 120, 100, 20);
  label1.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label1.setText("Triggering:");
  label1.setTextBold();
  label1.setOpaque(false);
  listOutputDuration = new GDropList(this, 360, 90, 90, 220, 10);
  listOutputDuration.setItems(loadStrings("list_833188"), 0);
  listOutputDuration.addEventHandler(this, "listOutputDuration_click1");
  lblOutputDurationList = new GLabel(this, 260, 90, 100, 20);
  lblOutputDurationList.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblOutputDurationList.setText("Output Duration:");
  lblOutputDurationList.setTextBold();
  lblOutputDurationList.setOpaque(false);
  lblIlluminationSetting = new GLabel(this, 260, 150, 190, 20);
  lblIlluminationSetting.setText("Illumination:");
  lblIlluminationSetting.setTextBold();
  lblIlluminationSetting.setOpaque(false);
  sldrIllumination = new GSlider(this, 260, 170, 190, 40, 10.0);
  sldrIllumination.setShowValue(true);
  sldrIllumination.setLimits(100, 0, 100);
  sldrIllumination.setNbrTicks(101);
  sldrIllumination.setNumberFormat(G4P.INTEGER, 0);
  sldrIllumination.setOpaque(false);
  sldrIllumination.addEventHandler(this, "sldrIllumination_change1");
  optnGroupColors = new GToggleGroup();
  optnColorOne = new GOption(this, 460, 70, 100, 20);
  optnColorOne.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorOne.setText("One");
  optnColorOne.setOpaque(false);
  optnColorOne.addEventHandler(this, "optnColorOne_clicked1");
  optnColorTwo = new GOption(this, 460, 90, 100, 20);
  optnColorTwo.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorTwo.setText("Two");
  optnColorTwo.setOpaque(false);
  optnColorTwo.addEventHandler(this, "optnColorTwo_clicked1");
  optnColorThree = new GOption(this, 460, 110, 100, 20);
  optnColorThree.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorThree.setText("Three");
  optnColorThree.setOpaque(false);
  optnColorThree.addEventHandler(this, "optnColorThree_clicked1");
  optnColorFour = new GOption(this, 460, 130, 100, 20);
  optnColorFour.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorFour.setText("Four");
  optnColorFour.setOpaque(false);
  optnColorFour.addEventHandler(this, "option4_clicked1");
  optnColorFive = new GOption(this, 460, 150, 100, 20);
  optnColorFive.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorFive.setText("Five");
  optnColorFive.setOpaque(false);
  optnColorFive.addEventHandler(this, "optnColorFive_clicked1");
  optnColorSix = new GOption(this, 460, 170, 100, 20);
  optnColorSix.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorSix.setText("Six");
  optnColorSix.setOpaque(false);
  optnColorSix.addEventHandler(this, "optnColorSix_clicked1");
  optnColorSeven = new GOption(this, 570, 70, 100, 20);
  optnColorSeven.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorSeven.setText("Seven");
  optnColorSeven.setOpaque(false);
  optnColorSeven.addEventHandler(this, "optnColorSeven_clicked1");
  optnColorEight = new GOption(this, 570, 90, 100, 20);
  optnColorEight.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorEight.setText("Eight");
  optnColorEight.setOpaque(false);
  optnColorEight.addEventHandler(this, "optnColorEight_clicked1");
  optnColorNine = new GOption(this, 570, 110, 100, 20);
  optnColorNine.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorNine.setText("Nine");
  optnColorNine.setOpaque(false);
  optnColorNine.addEventHandler(this, "option9_clicked1");
  optnColorTen = new GOption(this, 570, 130, 100, 20);
  optnColorTen.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorTen.setText("Ten");
  optnColorTen.setOpaque(false);
  optnColorTen.addEventHandler(this, "optnColorTen_clicked1");
  optnColorEleven = new GOption(this, 570, 150, 100, 20);
  optnColorEleven.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorEleven.setText("Eleven");
  optnColorEleven.setOpaque(false);
  optnColorEleven.addEventHandler(this, "optnColorEleven_clicked1");
  optnColorTwelve = new GOption(this, 570, 170, 100, 20);
  optnColorTwelve.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optnColorTwelve.setText("Twelve");
  optnColorTwelve.setOpaque(false);
  optnColorTwelve.addEventHandler(this, "optnColorTwelve_clicked1");
  optnGroupColors.addControl(optnColorOne);
  optnColorOne.setSelected(true);
  optnGroupColors.addControl(optnColorTwo);
  optnGroupColors.addControl(optnColorThree);
  optnGroupColors.addControl(optnColorFour);
  optnGroupColors.addControl(optnColorFive);
  optnGroupColors.addControl(optnColorSix);
  optnGroupColors.addControl(optnColorSeven);
  optnGroupColors.addControl(optnColorEight);
  optnGroupColors.addControl(optnColorNine);
  optnGroupColors.addControl(optnColorTen);
  optnGroupColors.addControl(optnColorEleven);
  optnGroupColors.addControl(optnColorTwelve);
  lblSelectColor = new GLabel(this, 460, 50, 80, 20);
  lblSelectColor.setText("Select Color:");
  lblSelectColor.setTextBold();
  lblSelectColor.setOpaque(false);
  lblColorCalibration = new GLabel(this, 460, 30, 110, 20);
  lblColorCalibration.setText("Color Calibration");
  lblColorCalibration.setTextBold();
  lblColorCalibration.setOpaque(false);
  togGroup2 = new GToggleGroup();
  btnCalibrateColor = new GButton(this, 460, 200, 100, 20);
  btnCalibrateColor.setText("Read Color");
  btnCalibrateColor.setTextBold();
  btnCalibrateColor.addEventHandler(this, "btnCalibrateColor_click1");
  btnCalibrateLight = new GButton(this, 460, 370, 100, 20);
  btnCalibrateLight.setText("Adjust Light");
  btnCalibrateLight.setTextBold();
  btnCalibrateLight.setLocalColorScheme(GCScheme.RED_SCHEME);
  btnCalibrateLight.addEventHandler(this, "btnCalibrateLight_click1");
  txtSerialNumberInput = new GTextField(this, 260, 390, 190, 20, G4P.SCROLLBARS_NONE);
  txtSerialNumberInput.setPromptText("New Serial Number");
  txtSerialNumberInput.setOpaque(true);
  txtSerialNumberInput.addEventHandler(this, "txtSerialNumberInput_change1");
  btnChangeSerialNumber = new GButton(this, 260, 420, 190, 20);
  btnChangeSerialNumber.setText("Change Serial Number");
  btnChangeSerialNumber.setTextBold();
  btnChangeSerialNumber.addEventHandler(this, "btnChangeSerialNumber_click1");
  btnClearSerialNumber = new GButton(this, 260, 450, 190, 20);
  btnClearSerialNumber.setText("Clear Serial Number");
  btnClearSerialNumber.setTextBold();
  btnClearSerialNumber.setLocalColorScheme(GCScheme.RED_SCHEME);
  btnClearSerialNumber.addEventHandler(this, "btnClearSerialNumber_click1");
  btnSendSettings = new GButton(this, 260, 210, 190, 20);
  btnSendSettings.setText("Send Settings");
  btnSendSettings.setTextBold();
  btnSendSettings.addEventHandler(this, "btnSendSettings_click1");
  btnStoreAlign = new GButton(this, 460, 260, 100, 20);
  btnStoreAlign.setText("Store Align");
  btnStoreAlign.setTextBold();
  btnStoreAlign.addEventHandler(this, "btnStoreAlign_click1");
  btnDiscardAlign = new GButton(this, 570, 370, 100, 20);
  btnDiscardAlign.setText("Discard Align");
  btnDiscardAlign.setTextBold();
  btnDiscardAlign.setLocalColorScheme(GCScheme.RED_SCHEME);
  btnDiscardAlign.addEventHandler(this, "btnDiscardAlign_click1");
  btnAlignOn = new GButton(this, 460, 290, 100, 20);
  btnAlignOn.setText("Align On");
  btnAlignOn.setTextBold();
  btnAlignOn.addEventHandler(this, "btnAlignOn_click1");
  btnAlignOff = new GButton(this, 570, 290, 100, 20);
  btnAlignOff.setText("Align Off");
  btnAlignOff.setTextBold();
  btnAlignOff.addEventHandler(this, "btnAlignOff_click1");
  btnTempOn = new GButton(this, 460, 420, 100, 20);
  btnTempOn.setText("Temp On");
  btnTempOn.setTextBold();
  btnTempOn.addEventHandler(this, "btnTempOn_click1");
  btnTempOff = new GButton(this, 570, 420, 100, 20);
  btnTempOff.setText("Temp Off");
  btnTempOff.setTextBold();
  btnTempOff.addEventHandler(this, "btnTempOff_click1");
  lblLedStability = new GLabel(this, 10, 270, 110, 20);
  lblLedStability.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblLedStability.setText("LED Stability:");
  lblLedStability.setTextBold();
  lblLedStability.setOpaque(false);
  lblLedStabilityData = new GLabel(this, 120, 270, 80, 20);
  lblLedStabilityData.setText("N/A");
  lblLedStabilityData.setOpaque(false);
  btnSetLight50 = new GButton(this, 460, 520, 100, 20);
  btnSetLight50.setText("Set Light 50%");
  btnSetLight50.addEventHandler(this, "btnSetLight50_click1");
  btnSetLight100 = new GButton(this, 570, 520, 100, 20);
  btnSetLight100.setText("Set Light 100%");
  btnSetLight100.addEventHandler(this, "btnSetLight100_click1");
  btnCheatButton1337 = new GButton(this, 460, 550, 210, 20);
  btnCheatButton1337.setText("Step 6 Cheat Button");
  btnCheatButton1337.setTextBold();
  btnCheatButton1337.setTextItalic();
  btnCheatButton1337.addEventHandler(this, "btnCheatButton1337_click1");
  chkContinuousRefresh = new GCheckbox(this, 170, 60, 80, 20);
  chkContinuousRefresh.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkContinuousRefresh.setText("Continuous");
  chkContinuousRefresh.setOpaque(false);
  chkContinuousRefresh.addEventHandler(this, "chkContinuousRefresh_clicked1");
  chkContinuousUpdate = new GCheckbox(this, 170, 90, 80, 20);
  chkContinuousUpdate.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkContinuousUpdate.setText("Continuous");
  chkContinuousUpdate.setOpaque(false);
  chkContinuousUpdate.addEventHandler(this, "chkContinuousUpdate_clicked1");
  chkSpacebarShortcut = new GCheckbox(this, 680, 200, 100, 20);
  chkSpacebarShortcut.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSpacebarShortcut.setText("Use spacebar");
  chkSpacebarShortcut.setTextBold();
  chkSpacebarShortcut.setOpaque(false);
  chkSpacebarShortcut.addEventHandler(this, "chkSpacebarShortcut_clicked1");
  btnCalcCoefficient = new GButton(this, 570, 320, 100, 20);
  btnCalcCoefficient.setText("Calculate Coeff");
  btnCalcCoefficient.setTextBold();
  btnCalcCoefficient.addEventHandler(this, "btnCalcCoefficient_click1");
  btnSendTargets = new GButton(this, 570, 260, 100, 20);
  btnSendTargets.setText("Send Targets");
  btnSendTargets.setTextBold();
  btnSendTargets.addEventHandler(this, "btnSendTargets_click1");
  chkBeepOnRead = new GCheckbox(this, 680, 230, 100, 20);
  chkBeepOnRead.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkBeepOnRead.setText("Beep on read");
  chkBeepOnRead.setTextBold();
  chkBeepOnRead.setOpaque(false);
  chkBeepOnRead.addEventHandler(this, "chkBeepOnRead_clicked1");
  btnRetakePoint = new GButton(this, 570, 200, 100, 20);
  btnRetakePoint.setText("Retake Point");
  btnRetakePoint.setTextBold();
  btnRetakePoint.addEventHandler(this, "btnRetakePoint_click1");
  btnCancel = new GButton(this, 460, 230, 210, 20);
  btnCancel.setText("Cancel");
  btnCancel.setTextBold();
  btnCancel.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  btnCancel.addEventHandler(this, "btnCancel_click1");
  btnGetAlignTable = new GButton(this, 460, 320, 100, 20);
  btnGetAlignTable.setText("Get Align Table");
  btnGetAlignTable.setTextBold();
  btnGetAlignTable.addEventHandler(this, "btnGetAlignTable_click1");
  btnGetTempTable = new GButton(this, 460, 450, 100, 20);
  btnGetTempTable.setText("Get Temp Table");
  btnGetTempTable.setTextBold();
  btnGetTempTable.addEventHandler(this, "btnGetTempTable_click1");
}

// Variable declarations 
// autogenerated do not edit
GDropList listColormaxSelect; 
GButton btnRefresh; 
GLabel lblRed; 
GLabel lblGreen; 
GLabel lblBlue; 
GLabel lblRedPercentData; 
GLabel lblGreenPercentData; 
GLabel lblBluePercentData; 
GLabel lblRedHexData; 
GLabel lblGreenHexData; 
GLabel lblBlueHexData; 
GLabel lblTemperature; 
GLabel lblTemperatureData; 
GLabel lblLEDCurrent; 
GLabel lblLEDCurrentData; 
GLabel lblDACSetting; 
GLabel lblDACSettingData; 
GLabel lblSerialNumber; 
GLabel lblSerialNumberData; 
GLabel lblAveraging; 
GLabel lblAveragingData; 
GLabel lblTriggering; 
GLabel lblTriggeringData; 
GLabel lblOutputDelay; 
GLabel lblOutputDelayData; 
GLabel lblIllumination; 
GLabel lblIlluminationData; 
GLabel lblModel; 
GLabel lblModelData; 
GLabel lblFirmwareVersion; 
GLabel lblFirmwareVersionData; 
GButton btnUpdateData; 
GLabel lblSensorSettings; 
GDropList listAveraging; 
GLabel lblAveragingList; 
GDropList listTriggering; 
GLabel label1; 
GDropList listOutputDuration; 
GLabel lblOutputDurationList; 
GLabel lblIlluminationSetting; 
GSlider sldrIllumination; 
GToggleGroup optnGroupColors; 
GOption optnColorOne; 
GOption optnColorTwo; 
GOption optnColorThree; 
GOption optnColorFour; 
GOption optnColorFive; 
GOption optnColorSix; 
GOption optnColorSeven; 
GOption optnColorEight; 
GOption optnColorNine; 
GOption optnColorTen; 
GOption optnColorEleven; 
GOption optnColorTwelve; 
GLabel lblSelectColor; 
GLabel lblColorCalibration; 
GToggleGroup togGroup2; 
GButton btnCalibrateColor; 
GButton btnCalibrateLight; 
GTextField txtSerialNumberInput; 
GButton btnChangeSerialNumber; 
GButton btnClearSerialNumber; 
GButton btnSendSettings; 
GButton btnStoreAlign; 
GButton btnDiscardAlign; 
GButton btnAlignOn; 
GButton btnAlignOff; 
GButton btnTempOn; 
GButton btnTempOff; 
GLabel lblLedStability; 
GLabel lblLedStabilityData; 
GButton btnSetLight50; 
GButton btnSetLight100; 
GButton btnCheatButton1337; 
GCheckbox chkContinuousRefresh; 
GCheckbox chkContinuousUpdate; 
GCheckbox chkSpacebarShortcut; 
GButton btnCalcCoefficient; 
GButton btnSendTargets; 
GCheckbox chkBeepOnRead; 
GButton btnRetakePoint; 
GButton btnCancel; 
GButton btnGetAlignTable; 
GButton btnGetTempTable; 
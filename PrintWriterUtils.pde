//*********************************************
// Create Writer
// Desc: Creates new .txt file with filename
// consisting of input prefix and random numbers
// following
//*********************************************
PrintWriter utilCreateWriter(PrintWriter inWriter, String prefix) {
  // Create .txt file with input prefix and random appendix
  int randomVal = (char)random(9999);  // Random extentsion for the file name
  //String[] strings = {prefix, "_output", String.valueOf(randomVal), ".txt"};
  //StringBuilder builder = new StringBuilder();
  //for (String fileName : strings) {
  //  builder.append(fileName);
  //}
  //String fileName = builder.toString();
  
  String fileName = prefix + String.valueOf(randomVal) + ".txt";
  
  // Create a new file in the sketch directory
  inWriter = createWriter(fileName);
  //println(fileName);
  return inWriter;
}

//*********************************************
// Print Timestamp
// Desc: Outputs a timestamp consisting of the
// hour, minutes, and date
//*********************************************
void utilPrintTimestamp(PrintWriter inWriter) {
  // Print a timestamp
  inWriter.print(hour());
  inWriter.print(':');
  inWriter.print(String.format("%02d", minute()));
  inWriter.print(' ');
  inWriter.print(month());
  inWriter.print('/');
  inWriter.print(day());
  inWriter.print('/');
  inWriter.print(year());
  inWriter.println();
}

//*********************************************
// Print Colormax Info
// Desc: Outputs useful information about inColormax
// to the inWriter. Requires the inColormax has
// gathered and saved the relevant variables
//*********************************************
void utilPrintColormaxInfo(PrintWriter inWriter, Colormax inColormax) {
  //println("com port:", inColormax.port);
  inWriter.print("COM port: ");
  inWriter.println(inColormax.getPort());
  
  //println("colormax settins:", inColormax.settings);
  inWriter.print("colormax settings: ");
  inWriter.println(inColormax.getSettings());
  
  //println("colormax vurzn:", inColormax.version);
  inWriter.print("colormax version: ");
  inWriter.println(inColormax.getVersion());
  
  inWriter.print("colormax serial#: ");
  inWriter.println(inColormax.getSerialNumber());
}

////*********************************************
//// Print CSC Info
//// Desc: Outputs useful information about CSC
////*********************************************
//void utilPrintCSCInfo(PrintWriter inWriter, Colormax inColormax) {
//  inWriter.print("Color:");
//  inWriter.println(inColormax.cscColor);
//  inWriter.print("Delay:");
//  inWriter.println(inColormax.cscDelay);
//}

//*********************************************
// Flush and Close
// Desc: Properly finishes and closes the
// inWriter text document
//*********************************************
void utilFlushAndClose(PrintWriter inWriter) {
  inWriter.flush();
  inWriter.close();
}

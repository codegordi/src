import arcgisscripting, string  
gp = arcgisscripting.create(9.3)  
  
# Check out the Data Interoperability Extension  
gp.SetProduct("ArcInfo")   
gp.AddToolbox("C:\Program Files\ArcGIS\ArcToolBox\Toolboxes\Data Interoperability Tools.tbx")  
gp.Toolbox = "interop"  
  
# Put in error trapping in case an error occurs when running tool  
try:  
    # Check for the data interoperability licence  
    if gp.CheckExtension("DataInteroperability") == "Available":  
        print gp.CheckExtension("DataInteroperability")  
        gp.CheckOutExtension("DataInteroperability")  
        print "Data Interoperability licence available and checked out"  
    else:  
        raise "LicenseError"  
  
    # Variables  
    FC_workspace = "***"  
    FC_name = "***"  
    FC_path = FC_workspace + FC_name  
    FL_name = "***"  
    Output_FC = "***"  
    Export_output = "mitab,C:\\temp\\Scripts\\" + Output_FC  
    FC_query = "***"  
  
    # Make a feature layer from the feature class  
    gp.MakeFeatureLayer(FC_path, FL_name)  
    print "Feature layer created"  
  
    # If a query exists, run it against the feature layer  
    if len(FC_query)!=0:  
        gp.SelectLayerByAttribute(FL_name, "NEW_SELECTION", FC_query)  
        print "Selection completed"  
    else:  
        print "No query run"  
  
    # Write the selected features to a new TAB file  
    gp.QuickExport_interop(FL_name, Export_output)  
    print "TAB export completed"  
  
    gp.CheckInExtension("DataInteroperability")  
    print "Data Interoperability extension checked in"  
      
except "LicenseError":  
    print "Data Interoperability license is unavailable"    
  
except:  
    # If an error occurred, print the message to the screen  
    print "==ERROR=="  
    print gp.GetMessages()  

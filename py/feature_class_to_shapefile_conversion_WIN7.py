# feature_class_to_shapefile_conversion.py
# 
# Use FeatureClassToShapefile_conversion from ArcGIS python library (arcpy)
#    to convert pre-v.10.x ESRI File Geodatabases (.gdb) to ESRI shape files (.shp, etc.)
#    ; for use in e.g. Alteryx
#    ; see also: http://resources.arcgis.com/en/help/main/10.1/index.html#//00120000003m000000
#
# @cgutierrez

## import system & geoprocessecing modules
import os
import arcgisscripting as ags
import arcpy
from arcpy import env

my_env = ags.create(9.3)

def list_fcs_in_fgdb(gdb):
    ''' list all Feature Classes in a geodatabase, including inside Feature Datasets '''
    ''' parm : gdb : your arcpy.env.workspace '''
    print 'Working in environment : ', my_env.describe
    my_env.workspace = gdb
    print 'Processing workspace : ', my_env.workspace
    fcs = [] 
    for fds in my_env.ListDatasets('','feature') + ['']:
        print fds
        for fc in my_env.ListFeatureClasses('','',fds):
            print fc
            #yield os.path.join(env.workspace, fds, fc)
            fcs.append(os.path.join(my_env.workspace, fds, fc))
    return fcs


def list_tables_in_fgdb(cur_gdb, file_type):
    ''' list file contents of user-input type in geodatabase '''
    ''' parm : cur_gdb : current arcpy.env.workspace '''
    ''' parm : file_type : file type of interest e.g. .gdbtbl '''
    f = []
    i = 0
    print 'Processing ', my_env.describe
    for (gdir, gdbs, gtbls) in os.walk(top):
        for gtbl in gtbls:
            my_env.workspace = cur_gdb
            #print my_env.workspace  # DEBUG
            fext = os.path.splitext(gtbl)
            #print fext  # DEBUG
            if (fext[1] == file_type):  # ! feature class does not correspond to file type in .gdb dir !
                f.append(os.path.join(gdir, gtbl))
        i = i+1
        print i, f[i]
    #print f

# >> move to script .py
#cur_gdb = input('Dir path of File Geodatabase (.gdb) to convert: ')
#out_file = input('Dir path of converted output: ')
#
#cur_fcs = listFcsInGDB(cur_gdb)
#i=0
#while i < 1:
#    for cur_fc in cur_fcs:
#        print cur_fc, i
#        arcpy.FeatureClassToShapefile_conversion(cur_fc, out_file)
#        i=i+1

#!/usr/bin/python

# convert_all_fgdbs.py
# cgutierrez

## import system & geoprocessecing modules
import os
import arcgisscripting as ags
import arcpy
from arcpy import env

def list_fcs_in_fgdb(fgdb):
    ''' list all Feature Classes in a geodatabase, including inside Feature Datasets '''
    ''' parm : gdb : your arcpy.env.workspace '''
    print 'Working in environment : ', cur_env.describe
    #cur_env.workspace = fgdb  # move this into main loop
    print 'Processing workspace : ', cur_env.workspace
    fcs = [] 
    for fds in cur_env.ListDatasets('','feature') + ['']:
        print 'Datasets : ', fds
        for fc in cur_env.ListFeatureClasses('','',fds):
            print 'Feature class : ', fc
            #yield os.path.join(env.workspace, fds, fc)
            fcs.append(os.path.join(cur_env.workspace, fds, fc))
    return fcs

## set up working directory and source directory parameters
src_dir = os.getcwd()  # if run from ~/src/py
#execfile(os.path.join(src_dir,'feature_class_to_shapefile_conversion_WIN7.py'))
top = input('Input top working directory (full path of directory holding all File Geodatabases): ')
outfile = os.path.join('H:\projects\geoproc\out')

cur_env = ags.create(9.3)

## run through current directory structure, identify File Geodatabases and convert
i = 0
for (cur_dir, cur_dbs, cur_files) in os.walk(top):
    for (gdir, gdbs, gfiles) in os.walk(cur_dir):
        print 'Current directory : ', cur_dir
        for gdb in gdbs:
            if gdb.endswith('.gdb'):
                i = i + 1
                cur_gdb = os.path.join(top, gdir, gdb)
                print 'Processing FGDB : ', gdb, i
                #print 'Full path : ', cur_gdb  # DEBUG
                ii = 0
                #print 'Current working dir : ', os.getcwd()  # DEBUG
                cur_env.workspace = cur_gdb
                cur_fcs = list_fcs_in_fgdb(cur_gdb)
                #print cur_fcs  # DEBUG
                for cur_fc in cur_fcs:
                    ii = ii + 1
                    print cur_fc, ii
                    arcpy.FeatureClassToShapefile_conversion(cur_fc, outfile)



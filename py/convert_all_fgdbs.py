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
    print 'Processing workspace : ', cur_env.workspace
    fcs = [] 
    for fds in cur_env.ListDatasets('','feature') + ['']:
        print 'Datasets : ', fds
        for fc in cur_env.ListFeatureClasses('','',fds):
            print 'Feature class : ', fc
            #yield os.path.join(env.workspace, fds, fc)
            fcs.append(os.path.join(cur_env.workspace, fds, fc))
    return fcs

## set up working directory (user input) and source directory parameters
src_dir = os.getcwd()  # if run from ~/src/py
top = input('Input top working directory (full path of directory holding all File Geodatabases): ')

cur_env = ags.create(9.3)  # converting ArcGIS v. 9.3 DBs

## run through current directory structure, identify File Geodatabases and convert
i = 0
for (cur_dir, cur_dirs, cur_files) in os.walk(top):
    for (gdir, gdbs, gfiles) in os.walk(cur_dir):
        print 'Checking directory : ', gdir
        if gdir.find('converted_') > 0:
            print '    >>> already converted, skipping ....'
            break
        for gdb in gdbs:
            if gdb.endswith('.gdb'):
                i = i + 1
                cur_gdb = os.path.join(top, gdir, gdb)
                cur_out = os.path.join(top, 'converted_' + os.path.basename(gdir))
                if os.path.exists(cur_out):
                    'Output directory', cur_out, ' already exists.'
                    break
                else:
                    os.mkdir(cur_out)
                    print 'Creating output directory : ', cur_out
                print 'Processing FGDB : ', gdb, i
                ii = 0
                cur_env.workspace = cur_gdb
                cur_fcs = list_fcs_in_fgdb(cur_gdb)
                for cur_fc in cur_fcs:
                    ii = ii + 1
                    print cur_fc, ii
                    arcpy.FeatureClassToShapefile_conversion(cur_fc, cur_out)



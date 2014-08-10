#!/usr/bin/python

# convert_all_feature_classes.py
# > stand-alone interactive script for processing one FGDB 
# cgutierrez

import os

src_dir = 'H:\src\py'  # hard-coding for VM path spec compatibility
cur_gdb = input('Dir path of File Geodatabase (.gdb) to convert: ')
out_file = input('Dir path of converted output: ')

execfile(os.path.join(src_dir, 'feature_class_to_shapefile_conversion_WIN7.py'))

cur_fcs = list_fcs_in_fgdb(cur_gdb)
i=0
for cur_fc in cur_fcs:
    print cur_fc, i
    arcpy.FeatureClassToShapefile_conversion(cur_fc, out_file)
    i=i+1

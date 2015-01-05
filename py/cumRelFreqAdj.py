

#cumRelFreqAdj.py
#/usr/bin/python
#####/usr/bin/jython

###########################################################################
###   cumRelFreqAdj
###   [cumRelFreqAdj20, cumRelFreqAdj30]
###   function to calculate viewability
###     score adjustment based on
###     cumulative relative frequency ...
###
### .. c.gutierrez
###
### input:  array of [numbers]
###
### output: bag of float-tuples
###
### last edit:  07oct13 added @line60 conditional for positive adjustments
###             06oct13 fixed input datatype conversion ==> tuple to list
############################################################################


import org.apache.pig.data.DataType as DataType
import org.apache.pig.impl.logicalLayer.schema.SchemaUtil as SchemaUtil
#from org.apache.pig.scripting import *
#from array import * # can't use other libs unless create new jython jar with python libs in it

@outputSchema("adj:float")
def cumRelFreqAdj(deltas):
    
    # create bins of increment 0.01
    a = [i*-0.01 for i in range(100)]
    a = a[1:len(a)]
    b = [i*0.01 for i in range(101)]
    a.extend(b)
    a.sort()
    #bins = array('f', a)
    bins = a
    
    # build cumulative relative frequency distribution
    #cumfreq = array('f', [0]*200)
    cumfreq = [0]*200
    for delta in deltas:
        delta = list(delta)
        delta = delta[0]
        for bin in range(len(bins)):
            if delta <= bins[bin]:
                cumfreq[bin] = cumfreq[bin]+1
    
    cumrelfreq = [float(cumfreq[i]) / max(cumfreq) for i in range(len(cumfreq))]
    
    #bin = [round(b, 2) for b in bin]
    crf = zip(bins, cumrelfreq)
    
    for relfreq in crf[:]:
        #print relfreq[1] # debug
        if relfreq[1] > 0.11:    # 10%ile
            adj = relfreq[0] + 0.05
            #print "adj = ", adj # debug
            break
    if adj > 0:     # adjust downward only
        adj = 0

    return adj

@outputSchema("adj20:float")
def cumRelFreqAdj20(deltas):
    
    # create bins of increment 0.01
    a = [i*-0.01 for i in range(100)]
    a = a[1:len(a)]
    b = [i*0.01 for i in range(101)]
    a.extend(b)
    a.sort()
    #bins = array('f', a)
    bins = a
    
    # build cumulative relative frequency distribution
    #cumfreq = array('f', [0]*200)
    cumfreq = [0]*200
    for delta in deltas:
        delta = list(delta)
        delta = delta[0]
        for bin in range(len(bins)):
            if delta <= bins[bin]:
                cumfreq[bin] = cumfreq[bin]+1
    
    cumrelfreq = [float(cumfreq[i]) / max(cumfreq) for i in range(len(cumfreq))]
    
    #bin = [round(b, 2) for b in bin]
    crf = zip(bins, cumrelfreq)
    
    for relfreq in crf[:]:
        #print relfreq[1] # debug
        if relfreq[1] > 0.21:    # 20%ile
            adj = relfreq[0] + 0.05
            if adj > 0:     # adjust downward only
                adj = 0
            #print "adj = ", adj # debug
            break

    return adj20

@outputSchema("adj30:float")
def cumRelFreqAdj30(deltas):
    
    # create bins of increment 0.01
    a = [i*-0.01 for i in range(100)]
    a = a[1:len(a)]
    b = [i*0.01 for i in range(101)]
    a.extend(b)
    a.sort()
    #bins = array('f', a)
    bins = a
    
    # build cumulative relative frequency distribution
    #cumfreq = array('f', [0]*200)
    cumfreq = [0]*200
    for delta in deltas:
        dd = list(delta)
        dd = delta[0]
        for b in range(len(bins)):
            if dd <= bins[b]:
                cumfreq[b] += 1
    
    cumrelfreq = [float(cumfreq[i]) / max(cumfreq) for i in range(len(cumfreq))]
    
    #bin = [round(b, 2) for b in bin]
    crf = zip(bins, cumrelfreq)
    
    for relfreq in crf[:]:
        #print relfreq[1] # debug
        if relfreq[1] > 0.31:    # 20%ile
            adj = relfreq[0] + 0.05
            if adj > 0:     # adjust downward only
                adj = 0
            #print "adj = ", adj # debug
            break
    
    return adj30

@outputSchema("adj_score:int")
def getAdjScore(score, adj):
    
    try: 
        if adj > 0:
            adj = 0

        if (score+adj) > 100:
            adj_score = 100
        elif (score+adj) < 0:
            adj_score = 0
        else:
            adj_score = score + adj # adjustment is always negative, so add to orig score
    except:
        adj_score = 9999
                
    return adj_score


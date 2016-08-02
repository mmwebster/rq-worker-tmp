#####################################################################################
# GENERAL NOTES
#####################################################################################
# 1. Current can reconfigure completedCourses dict. and max units for each quarter



#####################################################################################
# Imports and External Refs
#####################################################################################
import old_worker as rq # import reqourse worker



#####################################################################################
# Main
#####################################################################################
# temporary function to do a simple task
def appendAndDict(someList, someDict, i, node):
    someList.append(node)
    someDict[node.course.getCid()] = i
    i += 1
    return i
def main():
    # dictionary of all testing courses
    course = {
            'MATH19A': rq.Course("MATH", "19A", None, 5, {"fall":True, "winter":True, "spring":True}),        # i=0
            'MATH19B': rq.Course("MATH", "19B", None, 5, {"fall":True, "winter":True, "spring":True}),
            'MATH23A': rq.Course("MATH", "23A", None, 5, {"fall":True, "winter":True, "spring":True}),
            'CMPE8': rq.Course("CMPE", "8", None, 5, {"fall":True, "winter":False, "spring":False}),
            'CMPE16': rq.Course("CMPE", "16", None, 5, {"fall":True, "winter":True, "spring":True}),
            'CMPE107': rq.Course("CMPE", "107", None, 5, {"fall":False, "winter":True, "spring":True}),
            'CMPE12': rq.Course("CMPE", "12", None, 5, {"fall":True, "winter":True, "spring":True}),
            'CMPE12L': rq.Course("CMPE", "12L", None, 2, {"fall":True, "winter":True, "spring":True}),
            'CMPE13': rq.Course("CMPE", "13", None, 5, {"fall":False, "winter":True, "spring":True}),
            'CMPE13L': rq.Course("CMPE", "13L", None, 2, {"fall":False, "winter":True, "spring":True}),
            'CMPE9': rq.Course("CMPE", "9", None, 5, {"fall":False, "winter":True, "spring":False}),         # i=10
            'CMPE115': rq.Course("CMPE", "115", None, 5, {"fall":False, "winter":False, "spring":True}),
            'CMPE100': rq.Course("CMPE", "100", None, 5, {"fall":False, "winter":True, "spring":True}),
            'CMPE100L': rq.Course("CMPE", "100L", None, 2, {"fall":False, "winter":True, "spring":True}),
            'CMPE121': rq.Course("CMPE", "121", None, 5, {"fall":True, "winter":False, "spring":True}),
            'CMPE121L': rq.Course("CMPE", "121L", None, 2, {"fall":True, "winter":False, "spring":True}),
            'CMPE118': rq.Course("CMPE", "118", None, 5, {"fall":True, "winter":False, "spring":False}),
            'CMPE118L': rq.Course("CMPE", "118L", None, 2, {"fall":True, "winter":False, "spring":False}),
            'CMPE141': rq.Course("CMPE", "141", None, 5, {"fall":True, "winter":False, "spring":False}),
            'CMPE167': rq.Course("CMPE", "167", None, 5, {"fall":False, "winter":True, "spring":False}),
            'CMPE167L': rq.Course("CMPE", "167L", None, 2, {"fall":False, "winter":True, "spring":False}),     # i=20
            'CMPE216': rq.Course("CMPE", "216", None, 5, {"fall":False, "winter":False, "spring":True}),
            'CMPE80E': rq.Course("CMPE", "80E", None, 5, {"fall":False, "winter":False, "spring":True}),
            'CMPE185': rq.Course("CMPE", "185", None, 5, {"fall":True, "winter":True, "spring":True}),
            'CMPE129A': rq.Course("CMPE", "129A", None, 5, {"fall":True, "winter":False, "spring":False}),
            'CMPE129B': rq.Course("CMPE", "129B", None, 5, {"fall":False, "winter":True, "spring":False}),
            'CMPE129C': rq.Course("CMPE", "129C", None, 5, {"fall":False, "winter":False, "spring":True}),
            'EE103': rq.Course("EE", "103", None, 5, {"fall":True, "winter":False, "spring":True}),
            'EE103L': rq.Course("EE", "103L", None, 2, {"fall":True, "winter":False, "spring":True}),
            'EE101': rq.Course("EE", "101", None, 5, {"fall":True, "winter":True, "spring":False}),
            'EE101L': rq.Course("EE", "101L", None, 2, {"fall":True, "winter":True, "spring":False}),        # i=30
            'AMS10': rq.Course("AMS", "10", None, 5, {"fall":True, "winter":False, "spring":True}),
            'AMS20': rq.Course("AMS", "20", None, 5, {"fall":False, "winter":True, "spring":True}),
            'CMPS12B': rq.Course("CMPS", "12B", None, 5, {"fall":True, "winter":True, "spring":False}),
            'CMPS12M': rq.Course("CMPS", "12M", None, 2, {"fall":True, "winter":True, "spring":False}),
            'CMPS101': rq.Course("CMPS", "101", None, 5, {"fall":True, "winter":True, "spring":True}),
            'PHYS5A': rq.Course("PHYS", "5A", None, 5, {"fall":True, "winter":False, "spring":False}),
            'PHYS5L': rq.Course("PHYS", "5L", None, 1, {"fall":True, "winter":False, "spring":False}),
            'PHYS5C': rq.Course("PHYS", "5C", None, 5, {"fall":False, "winter":False, "spring":True}),
            'PHYS5N': rq.Course("PHYS", "5N", None, 1, {"fall":False, "winter":False, "spring":True})        # i=39
            }

    # some vars
    uniqueCourseNodes = [] # list that will contain all unique course nodes below
    courseNodeLookupDict = {} # dict used to lookup course node in `uniqueCourse` by its cid
    i = 0 # index to inc. as val in dict: [cid]->[index]
    head = rq.Node([],None,8,None,None,True) # head of the final tree passed mapTimeline
    # all unique course nodes and their immediate children (no uncertainty)
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([], course["CMPE8"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE8"])], course["CMPE12"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE12"])], course["CMPE13"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([], course["MATH19A"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["MATH19A"])], course["MATH19B"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE13"])], course["CMPS12B"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["MATH19A"])], course["CMPE16"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([], course["AMS10"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["MATH19A"],0,"co")], course["PHYS5A"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["MATH19B"])], course["MATH23A"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["MATH19B"]),rq.Node([],course["AMS10"])], course["AMS20"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["PHYS5A"]),rq.Node([],course["MATH19B"])], course["PHYS5C"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPS12B"]),rq.Node([],course["AMS10"]),rq.Node([],course["MATH19B"]),rq.Node([],course["CMPE16"])], course["CMPS101"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE12"])], course["CMPE100"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["PHYS5C"]),rq.Node([],course["AMS20"],0,"co")], course["EE101"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["EE101"],0,"co"),rq.Node([],course["CMPE100"])], course["CMPE118"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE16"]),rq.Node([],course["MATH23A"])], course["CMPE107"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["MATH19A"]),rq.Node([],course["AMS10"]),rq.Node([],course["PHYS5A"])], course["CMPE9"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE9"]),rq.Node([],course["AMS10"]),rq.Node([],course["MATH19B"])], course["CMPE115"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE12"]),rq.Node([],course["EE101"]),rq.Node([],course["CMPE100"]),rq.Node([],course["CMPE13"])], course["CMPE121"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE9"])], course["CMPE216"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["EE101"]),rq.Node([],course["AMS20"])], course["EE103"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE185"],0,"co"),rq.Node([],course["CMPE121"],0,"co")], course["CMPE129A"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["EE103"])], course["CMPE141"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE12"])], course["CMPE185"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE129A"])], course["CMPE129B"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE13"]), rq.Node([],course["EE103"])], course["CMPE167"]))
    i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, rq.Node([rq.Node([],course["CMPE129B"])], course["CMPE129C"]))

    # connect all subtrees so that can sort uniqueCourseNodes by num descendents
    uniqueNodesHead = rq.Node(uniqueCourseNodes)
    rq.printTree(uniqueNodesHead)
    rq.dfsConnectNodeSubtrees(uniqueNodesHead, uniqueCourseNodes, courseNodeLookupDict)

    # sort by num descendents
    rq.dfsSort(uniqueNodesHead, False)
    # print immediate children of head in list of unique nodes ordered by #descendents in ascending order
    print "New ordering"
    print "[ ",
    for i in range(len(uniqueNodesHead.children)):
        print uniqueNodesHead.children[i].course.getCid(),
        if i < len(uniqueNodesHead.children)-1:
            print ",",
    print " ]"
    print

    # Now get the consolidated one path tree from these one path subtrees
    descendents = {} # and roots children at `head.children`
    for node in uniqueNodesHead.children:
        if not node.course.getCid() in descendents:
            # add its children to the unique descendents
            for child in node.children:
                descendents[child.course.getCid()] = True
            # add the node to head's children
            head.children.append(node)
            # clean head's children of any nodes now present in unique descendents
            i = 0; length = len(head.children) # must do this method b/c removing items from the list while iterating
            while (i < length):
                if head.children[i].course.getCid() in descendents:
                    del head.children[i]
                    i -= 1; length -= 1 # decrement counter and length after removing item
                i += 1

    print "Immediate children of head of consolidated one-path tree"
    print "[ ",
    for i in range(len(head.children)):
        print head.children[i].course.getCid(),
        if i < len(head.children)-1:
            print ",",
    print " ]"
    print

    # completedCourses = {"AMS10":True, "AMS20":True, "CHEM1A":True, "CMPE100":True, "CMPE12":True, "CMPE13":True, "CMPE16":True, "CMPE8":True, "CMPS12B":True, "MATH19A":True, "MATH19B":True, "MATH23A":True, "PHYS5A":True, "PHYS5C":True}
    completedCourses = {}
    quarters = [ \
            rq.Quarter([], "fall", 19), \
            rq.Quarter([], "winter", 19), \
            rq.Quarter([], "spring", 19), \
            rq.Quarter([], "fall", 19), \
            rq.Quarter([], "winter", 19), \
            rq.Quarter([], "spring", 19), \
            rq.Quarter([], "fall", 19), \
            rq.Quarter([], "winter", 19), \
            rq.Quarter([], "spring", 19), \
            rq.Quarter([], "fall", 19), \
            rq.Quarter([], "winter", 19), \
            rq.Quarter([], "spring", 19), \
            rq.Quarter([], "fall", 19), \
            rq.Quarter([], "winter", 19), \
            rq.Quarter([], "spring", 19), \
            rq.Quarter([], "fall", 19), \
            rq.Quarter([], "winter", 19), \
            rq.Quarter([], "spring", 19)
            ]
    timeline = rq.Timeline(completedCourses, quarters)

    # print timeline
    print "Timeline knot:"
    rq.printTimeline(timeline);

    # print co-pt
    print "Current co-pt:"
    rq.printTree(head)

    # createTimeline takes as input a consolidated one-path tree
    rq.mapTimeline(timeline, head)

    # print timeline again
    print
    print "Finished timeline!!!:"
    rq.printTimeline(timeline)

main()

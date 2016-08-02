#####################################################################################
# GENERAL NOTES
#####################################################################################
# 1. Current can reconfigure completedCourses dict. and max units for each quarter

#####################################################################################
# Imports and External Refs
#####################################################################################
require_relative 'worker' # import reqourse worker
require 'pry'

#####################################################################################
# Main
#####################################################################################
# temporary function to do a simple task
def appendAndDict(some_list, some_dict, i, node)
  some_list.push(node)
  some_dict[node.course.cid] = i
  i += 1
  return i
end

binding.pry

# dictionary of all testing courses
course = {
        'MATH19A'=> Course.new('MATH', '19A', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'MATH19B'=> Course.new('MATH', '19B', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'MATH23A'=> Course.new('MATH', '23A', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'CMPE8'=> Course.new('CMPE', '8', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'CMPE16'=> Course.new('CMPE', '16', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'CMPE107'=> Course.new('CMPE', '107', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>true}),
        'CMPE12'=> Course.new('CMPE', '12', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'CMPE12L'=> Course.new('CMPE', '12L', nil, 2, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'CMPE13'=> Course.new('CMPE', '13', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>true}),
        'CMPE13L'=> Course.new('CMPE', '13L', nil, 2, {'fall'=>false, 'winter'=>true, 'spring'=>true}),
        'CMPE9'=> Course.new('CMPE', '9', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>false}),         # i=10
        'CMPE115'=> Course.new('CMPE', '115', nil, 5, {'fall'=>false, 'winter'=>false, 'spring'=>true}),
        'CMPE100'=> Course.new('CMPE', '100', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>true}),
        'CMPE100L'=> Course.new('CMPE', '100L', nil, 2, {'fall'=>false, 'winter'=>true, 'spring'=>true}),
        'CMPE121'=> Course.new('CMPE', '121', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>true}),
        'CMPE121L'=> Course.new('CMPE', '121L', nil, 2, {'fall'=>true, 'winter'=>false, 'spring'=>true}),
        'CMPE118'=> Course.new('CMPE', '118', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'CMPE118L'=> Course.new('CMPE', '118L', nil, 2, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'CMPE141'=> Course.new('CMPE', '141', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'CMPE167'=> Course.new('CMPE', '167', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>false}),
        'CMPE167L'=> Course.new('CMPE', '167L', nil, 2, {'fall'=>false, 'winter'=>true, 'spring'=>false}),     # i=20
        'CMPE216'=> Course.new('CMPE', '216', nil, 5, {'fall'=>false, 'winter'=>false, 'spring'=>true}),
        'CMPE80E'=> Course.new('CMPE', '80E', nil, 5, {'fall'=>false, 'winter'=>false, 'spring'=>true}),
        'CMPE185'=> Course.new('CMPE', '185', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'CMPE129A'=> Course.new('CMPE', '129A', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'CMPE129B'=> Course.new('CMPE', '129B', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>false}),
        'CMPE129C'=> Course.new('CMPE', '129C', nil, 5, {'fall'=>false, 'winter'=>false, 'spring'=>true}),
        'EE103'=> Course.new('EE', '103', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>true}),
        'EE103L'=> Course.new('EE', '103L', nil, 2, {'fall'=>true, 'winter'=>false, 'spring'=>true}),
        'EE101'=> Course.new('EE', '101', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>false}),
        'EE101L'=> Course.new('EE', '101L', nil, 2, {'fall'=>true, 'winter'=>true, 'spring'=>false}),        # i=30
        'AMS10'=> Course.new('AMS', '10', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>true}),
        'AMS20'=> Course.new('AMS', '20', nil, 5, {'fall'=>false, 'winter'=>true, 'spring'=>true}),
        'CMPS12B'=> Course.new('CMPS', '12B', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>false}),
        'CMPS12M'=> Course.new('CMPS', '12M', nil, 2, {'fall'=>true, 'winter'=>true, 'spring'=>false}),
        'CMPS101'=> Course.new('CMPS', '101', nil, 5, {'fall'=>true, 'winter'=>true, 'spring'=>true}),
        'PHYS5A'=> Course.new('PHYS', '5A', nil, 5, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'PHYS5L'=> Course.new('PHYS', '5L', nil, 1, {'fall'=>true, 'winter'=>false, 'spring'=>false}),
        'PHYS5C'=> Course.new('PHYS', '5C', nil, 5, {'fall'=>false, 'winter'=>false, 'spring'=>true}),
        'PHYS5N'=> Course.new('PHYS', '5N', nil, 1, {'fall'=>false, 'winter'=>false, 'spring'=>true})        # i=39
        }

binding.pry

# some vars
uniqueCourseNodes = [] # list that will contain all unique course nodes below
courseNodeLookupDict = {} # dict used to lookup course node in `uniqueCourse` by its cid
i = 0 # index to inc. as val in dict: [cid]->[index]
head = Node.new([],nil,8,nil,nil,true) # head of the final tree passed mapTimeline

binding.pry

# all unique course nodes and their immediate children (no uncertainty)
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([], course['CMPE8']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE8'])], course['CMPE12']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE12'])], course['CMPE13']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([], course['MATH19A']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['MATH19A'])], course['MATH19B']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE13'])], course['CMPS12B']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['MATH19A'])], course['CMPE16']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([], course['AMS10']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['MATH19A'],0,'co')], course['PHYS5A']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['MATH19B'])], course['MATH23A']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['MATH19B']),Node.new([],course['AMS10'])], course['AMS20']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['PHYS5A']),Node.new([],course['MATH19B'])], course['PHYS5C']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPS12B']),Node.new([],course['AMS10']),Node.new([],course['MATH19B']),Node.new([],course['CMPE16'])], course['CMPS101']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE12'])], course['CMPE100']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['PHYS5C']),Node.new([],course['AMS20'],0,'co')], course['EE101']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['EE101'],0,'co'),Node.new([],course['CMPE100'])], course['CMPE118']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE16']),Node.new([],course['MATH23A'])], course['CMPE107']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['MATH19A']),Node.new([],course['AMS10']),Node.new([],course['PHYS5A'])], course['CMPE9']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE9']),Node.new([],course['AMS10']),Node.new([],course['MATH19B'])], course['CMPE115']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE12']),Node.new([],course['EE101']),Node.new([],course['CMPE100']),Node.new([],course['CMPE13'])], course['CMPE121']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE9'])], course['CMPE216']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['EE101']),Node.new([],course['AMS20'])], course['EE103']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE185'],0,'co'),Node.new([],course['CMPE121'],0,'co')], course['CMPE129A']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['EE103'])], course['CMPE141']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE12'])], course['CMPE185']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE129A'])], course['CMPE129B']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE13']), Node.new([],course['EE103'])], course['CMPE167']))
i = appendAndDict(uniqueCourseNodes, courseNodeLookupDict, i, Node.new([Node.new([],course['CMPE129B'])], course['CMPE129C']))

binding.pry

# connect all subtrees so that can sort uniqueCourseNodes by num descendents
uniqueNodesHead = Node.new(uniqueCourseNodes)
putsTree(uniqueNodesHead)
dfsConnectNodeSubtrees(uniqueNodesHead, uniqueCourseNodes, courseNodeLookupDict)

binding.pry

# sort by num descendents
dfsSort(uniqueNodesHead, false)
# puts immediate children of head in list of unique nodes ordered by #descendents in ascending order
puts 'New ordering'
puts '[ '
for i in range(len(uniqueNodesHead.children))
  puts uniqueNodesHead.children[i].course.cid
  if (i < len(uniqueNodesHead.children) - 1)
      puts ','
  end
end
puts ' ]'
puts

binding.pry

# Now get the consolidated one path tree from these one path subtrees
descendents = {} # and roots children at `head.children`
for node in uniqueNodesHead.children
  if !descendents.key?(node.course.cid)
    # add its children to the unique descendents
    for child in node.children
      descendents[child.course.cid] = true
    end
    # add the node to head's children
    head.children.push(node)
    # clean head's children of any nodes now present in unique descendents
    i = 0
    length = len(head.children) # must do this method b/c removing items from the list while iterating
    while (i < length)
      if descendents.key?(head.children[i].course.cid)
        # TODO del method replacement
        del head.children[i]
        i -= 1
        length -= 1 # decrement counter and length after removing item
      end
      i += 1
    end
  end
end

binding.pry

puts 'Immediate children of head of consolidated one-path tree'
puts '[ '
for i in 0...head.children.length
  puts head.children[i].course.cid
  if i < head.children.length - 1
    puts ','
  end
end
puts ' ]'
puts

binding.pry

# completedCourses = {'AMS10':true, 'AMS20':true, 'CHEM1A':true, 'CMPE100':true, 'CMPE12':true, 'CMPE13':true, 'CMPE16':true, 'CMPE8':true, 'CMPS12B':true, 'MATH19A':true, 'MATH19B':true, 'MATH23A':true, 'PHYS5A':true, 'PHYS5C':true}
completedCourses = {}
quarters = [ \
        Quarter.new([], 'fall', 19), \
        Quarter.new([], 'winter', 19), \
        Quarter.new([], 'spring', 19), \
        Quarter.new([], 'fall', 19), \
        Quarter.new([], 'winter', 19), \
        Quarter.new([], 'spring', 19), \
        Quarter.new([], 'fall', 19), \
        Quarter.new([], 'winter', 19), \
        Quarter.new([], 'spring', 19), \
        Quarter.new([], 'fall', 19), \
        Quarter.new([], 'winter', 19), \
        Quarter.new([], 'spring', 19), \
        Quarter.new([], 'fall', 19), \
        Quarter.new([], 'winter', 19), \
        Quarter.new([], 'spring', 19), \
        Quarter.new([], 'fall', 19), \
        Quarter.new([], 'winter', 19), \
        Quarter.new([], 'spring', 19)
        ]

binding.pry

timeline = Timeline.new(completedCourses, quarters)

binding.pry

# puts timeline
puts 'Timeline knot:'
putsTimeline.new(timeline)

binding.pry

# puts co-pt
puts 'Current co-pt:'
putsTree(head)

binding.pry

# createTimeline takes as input a consolidated one-path tree
mapTimeline.new(timeline, head)

binding.pry

# puts timeline again
puts
puts 'Finished timeline!!!:'

binding.pry

putsTimeline.new(timeline)

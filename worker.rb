################################################################################
# TODO
################################################################################
# 1. translate old copy python stuff to ruby obj cloning
# 2. append 'end' to all classes and functionions
# 3. change instance variables to use @
# 4. fix indentation
# 5. keep all lines 80 characters or fewer
# 6. remove all 'return' statements
# 7. replace all python assertions with their ruby equivalent

################################################################################
# Imports and External Refs
################################################################################
require 'pry'

################################################################################
# Enum definitions
################################################################################

# ******************************************************************************
# @desc currently not being used, was previously not syntactically correct. Can
#       probably reference by just Seasons.fall, etc.
# ******************************************************************************
class Seasons
  attr_accessor :fall, :winter, :spring
  @fall = false
  @winter = false
  @spring = false
end

# ******************************************************************************
# @desc The type of relationship between a node and its parent (only one parent)
# ******************************************************************************
class ParentRel
  attr_accessor :pre, :co, :concurrent
  @pre = false
  @co = false
  @concurrent = false # not taking into account in most situations
end

################################################################################
# Class definitions
################################################################################

# ******************************************************************************
# @desc A basic queue implementation
# ******************************************************************************
class Queue
  def initialize
    @items = []
  end

  def empty?
    @items.length.zero?
  end

  def enqueue(item)
    @items.insert(0, item) # pushes new element to 'end' of queue
  end

  def dequeue
    @items.pop
  end

  def size
    @items.length
  end
end

# ******************************************************************************
# @desc A basic stack implementation (really just for clarity..it's just an
#       array)
# ******************************************************************************
class Stack
  def initialize
    @items = []
  end

  def empty?
    @items.length.zero?
  end

  def push(item)
    @items.push(item)
  end

  def pop
    @items.pop
  end

  def size
    @items.length
  end
end

# ******************************************************************************
# @desc A node in one of the course-dependent trees; acts like a container for
#       courses that may or may not be filled.
# @param children List of all child nodes
# @param num_required The number of the children that must be satisfied in the
#        tree to take this course
# @param course A single course definition (optional) for this node
# @param parent_rel The type of relationship between the course in this node and
#        that in its parent. Must be of type String..'pre' or 'co'. (optionally
#        set to nil..not used if does not contain course)
# ******************************************************************************
class Node
  attr_accessor :children, :course, :num_required, :parent_rel,
                :num_descendents, :is_root

  def initialize(children = [], course = nil, num_required = 0,
                 parent_rel = 'pre', num_descendents = nil, is_root = false)
    @children = children
    @course = course
    @num_required = num_required
    @parent_rel = parent_rel
    @num_descendents = num_descendents
    @is_root = is_root
  end
end

# ******************************************************************************
# @desc A single course and its attributes
# @param subject The subject code (string) used to catagorize the course by
# @param number The number used to uniquely identify a course within a subject
# @param title The name of the course as it is displayed and used
# @param seasons_offered A dictionary with [season name]->[boolean] pairs...when
#        the course is offered
# ******************************************************************************
class Course
  attr_accessor :subject, :number, :title, :units, :seasons_offered,
                :concurrent_course

  def initialize(subject, number, title, units, seasons_offered = {},
                 concurrent_course = nil)
    @subject = subject
    @number = number
    @title = title
    @units = units
    @seasons_offered = seasons_offered
    @concurrent_course = concurrent_course
  end

  def cid
    @subject + @number.to_s
  end

  def total_units
    total_units = 0
    unless @concurrent_course.nil?
      total_units += @concurrent_course.units
      total_units += @units
    end
    total_units
  end
end

# ******************************************************************************
# @desc A single quarter in the Timeline
# @param courses An array of courses inserted into the specific quarter. Must be
#        of type Course
# @param season A string containing the season this quarter is in..used with
#        course season dict.
# @param max_units the max number of units desired for this quarter
# ******************************************************************************
class Quarter
  attr_accessor :courses, :season, :max_units

  def initialize(courses = [], season = nil, max_units = 19)
    # assert all(isinstance(course, Course) for course in courses)
    @courses = courses
    @season = season
    @max_units = max_units
  end

  # @desc Returns the total number of units currently stored in this quarter
  def total_units
    total_units = 0
    @courses.each do |course|
      total_units += course.total_units
    end
    total_units
  end
end

# *****************************************************************************
# @desc The planned out courses in their quarter with respect their seasons
# @param quarters Contains of the currently planned out quarters
# @param completed_courses Contains a bucket (dictionary) of all completed
#        courses in the format [cid]->[boolean]
# @param quarters List of all quarter in the Timeline (length may be greater
#        than current_quarter)
# @param current_quarter Index of the quarter that's currently being worked on
# @param starting_season The default season of the first quarter in the timeline
# *****************************************************************************
class Timeline
  attr_accessor :completed_courses, :quarters, :current_quarter,
                :starting_season

  def initialize(completed_courses = {}, quarters = [], current_quarter = 0,
                 starting_season = 'fall')
    # TODO: put in ruby equivalent
    # assert all(isinstance(quarter, Quarter) for quarter in quarters)
    @completed_courses = completed_courses
    @quarters = quarters
    @current_quarter = current_quarter
    @starting_season = starting_season
  end

  # @desc Return the # of populated quarters
  def num_quarters
    @quarters.length
  end

  # @desc Returns a boolean of whether or not the passed course has been
  #       completed
  # @param course The course to test for having been completed
  def completed?(course)
    if @completed_courses.key?(course.cid)
      true
    else
      false
    end
  end

  # @desc Return a boolean of whether or not the passed course is in a
  #       quarter `offset` from the current
  # @param course The course to search for
  # @param parent_rel The requirement type between the course that must be
  #        satisfied (`course`) and the one that needs it to be satisfied.
  #        Must be of type String.
  def satisfied?(course, parent_rel)
    # check if is in completed courses
    if completed?(course)
      true
    end

    # determine offset from current_quarter
    if parent_rel == 'pre'
      offset = -1
    elsif parent_rel == 'co'
      offset = 0
    else
      (0..9).each do
        puts
      end
    end
    end_index = @current_quarter + offset

    # determine the quarters list to check
    if end_index == -1
      iterating_quarters = []
    elsif end_index.zero?
      iterating_quarters = [@quarters[0]]
    else
      # TODO: find ruby equivalent for end_index
      iterating_quarters = @quarters[0..end_index]
    end

    # check the quarters
    iterating_quarters.each do |quarter|
      quarter.courses.each do |c|
        if course.cid == c.cid
          true
        end
      end
    end
    return false
  end

  # @desc Returns a string for the season of the current quarter (end of
  #       quarters list)
  def current_season
    if @quarters
      @quarters[@current_quarter].season
    else
      @starting_season
    end
  end
end


################################################################################
# Function definitions
################################################################################

# ******************************************************************************
# @desc Prints out every quarter in the timeline and every course within every
#       quarter
# @param timeline The timeline to puts out
# ******************************************************************************
def putsTimeline(timeline)
  # TODO:
  # assert isinstance(timeline, Timeline)
  puts('Timeline:')
  year = 1

  (0...timeline.quarters.length).each do |i|
    if (i % 3).zero?.zero?
      puts '- - - - - - Year ' + year.to_s + ' - - - - - -'
      year += 1
    end
    puts(' Qtr ' + (i + 1).to_s + ', ' +
         timeline.quarters[i].total_units.to_s + ' units(s), (' +
         timeline.quarters[i].season + ')')
    timeline.quarters[i].courses.each do |course|
      puts(' -' + course.subject + course.number.to_s)
    end
  end
end

# ******************************************************************************
# @desc Prints out a tree given the head node. Uses a BFS type implementation w/
#       mods.
# @param head The head of the tree, of type Node
# ******************************************************************************
def putsTree(head)
  puts '- - - - - - - Printing Tree - - - - - - - - -'
  current_level = [head]
  while current_level.length > 0
    next_level = []
    current_level.each do |node|
      if node.course != nil
        print '(' + node.object_id.to_s + '->numReq: ' + node.num_required.to_s + ', cid: ' + node.course.cid + ')'
      else
        print '(' + node.object_id.to_s + '->numReq: ' + node.num_required.to_s + ', cid: ..)'
      end

      node.children.each do |child|
        next_level.push(child)
      end
    end
    puts # add new line
    puts
    current_level = next_level # proceed to next level
  end
end

# ******************************************************************************
# @desc Prints out a stack of nodes according to their corresponding cids
# @param stack The stack to puts, must be of type Stack
# ******************************************************************************
def putsPriorityStack(stack)
  # TODO: ruby equivalent for assertion
  # assert isinstance(stack, Stack)
  puts '- - -  - Printing Priority Stack - - - - -'
  print '| is_root | '
  stack.items.each do |node|
    if node.course != nil
      print node.course.cid + ' | '
    else
      print 'is_root | '
    end
  end
  puts # add the newline
end

# ******************************************************************************
# @desc Prints out a dictionary
# @param dictionary The dictionary
# ******************************************************************************
def putsDictionary(dictionary)
  # TODO: assertion
  # assert isinstance(dictionary, dict)
  keys = dictionary.keys
  puts '- - - - - Printing Dictionary - - - - -'
  print '{ '
  keys.each do |key|
      print "'" + key + "': " + dictionary[key].to_s + " , "
  end
  puts '}'
end

# ******************************************************************************
# @desc Basic BFS implementation, where some function can be called with the
#       current node (and its own args) everytime one is visited
# @param node The head of the tree to operate on
# @param function The function to be called for every node visit (dequeue)
# @param *args Any arguments that the function needs outside of the node
# ******************************************************************************
# TODO: *args multi argument thing
def bfs(node, function, *args)
  # TODO: assertion
  # assert isinstance(node, Node)
  queue = Queue.new
  queue.enqueue(node)

  # proceed with BFS, putsing element along the way
  while !queue.empty?
    n = queue.dequeue
    # perform passed function
    function(n, *args)
    # queue every child of n
    n.children.each do |child|
      queue.enqueue(child)
    end
  end
end

# ******************************************************************************
# @desc DFS-postorder implementation for sorting nodes in a tree from least to
#       most descendents
# @param node The head of the current sub-tree. Must be of type Node
# @param order Boolean where false:Ascending and true:Descending order
# ******************************************************************************
def dfsSort(node, isDescending)
  # default node's num_descendents to zero
  node.num_descendents = 0
  # for every child of node
  node.children.each do |child|
    # visit the child
    dfsSort(child, isAscending)
    # inc. num of descendents on node by this child's descendents and the child
    # itself
    node.num_descendents += child.num_descendents + 1
  end
  # sort this node's children
  if isDescending
    node.children.sort! { |a, b| b.num_descendents <=> a.num_descendents }
  else
    node.children.sort! { |a, b| a.num_descendents <=> b.num_descendents }
  end
  # # TODO: lambda thing
  # node.children.sort(key=lambda x: x.num_descendents, reverse=order)
end

# ******************************************************************************
# @desc DFS-postorder implementation for removing all nodes from tree that match
#       dict. entries. The implementation isn't especially clean due to the
#       nature of deleting members of a list while you are iterating through it
#       (must redefine current index and such).
# @param node The head of the current sub-tree. Must be of type Node
# @param removables Dict. of items to remove in form [cid]->[course]
# ******************************************************************************
def dfsClean(node, removables)
  i = 0
  end_index = node.children.length
  while i < end_index
    # if child matches, remove it
    if removables.key?(node.children[i].course.cid)
      node.children.delete_at(i)
      # fix i so that it doesn't skip over the next item
      i -= 1
      end_index -= 1
    else
      # otherwise, visit it
      dfsClean(node.children[i], removables)
    end
    i += 1
  end
end

# ******************************************************************************
# @desc DFS-postorder implementation that builds out all of the subtrees of node
#       by, when encountering a child node, looking up its child nodes in
#       courseNodeDict and then recurring on node with newly defined subtrees.
#       This allows for input of just course nodes and their immediate children
#       to get a fully fledged gen-path or one-path tree. To also work with
#       pivot nodes, need make change detailed in workflow 2.0.
# @param node The head of the current sub-tree. Must be of type Node
# @param courseNodes A 1 dimensional array of nodes w/ defined subtrees
# @param courseNodeDict Dict. of [cid]->[index in courseNodes] used as a lookup
#        table
# ******************************************************************************
def dfsConnectNodeSubtrees(node, courseNodes, courseNodeLookupDict)
  # for every child in node
  node.children.each do |child|
    # lookup child in dict. and use to define children of child
    child.children = 
      courseNodes[courseNodeLookupDict[child.course.cid]].children
    # dive into children
    dfsConnectNodeSubtrees(child, courseNodes, courseNodeLookupDict)
  end
end

# ******************************************************************************
# @desc Creates and returns a priority stack of all the nodes in the passed
#       tree. This is done by performing a basic BFS, where
#       pushToPriorityStack(node) is called for every visit (dequeue) of a node.
#       Root node is not added to stack.
# @param node The head of the current sub-tree. Must be of type Node
# ******************************************************************************
def createPriorityStack(node)
  # @desc Pushes a node into the priority stack
  # @param node The node to be pushed
  def pushToPriorityStack(node)
    unless node.is_root
      priorityStack.push(node)
    end
  end

  # init final priority stack
  priorityStack = Stack.new
  # populate priority stack
  bfs(node, pushToPriorityStack)
  # return it
  priorityStack
end

# ******************************************************************************
# @desc Evaluates a node (and associated course) against a current quarter in
#       timeline
# @param node The node to perform eval on
# @param timeline A reference to the currently mapped out timeline
# ******************************************************************************
def courseDoesEval(node, timeline)
  # confirm correct types
  # TODO: assertion
  # assert isinstance(node, Node)
  # assert isinstance(timeline, Timeline)
  # 1. course in completed courses?
  if timeline.completed?(node.course)
    false
  end
  # 2. is it offered this quarter?
  if not node.course.seasons_offered[timeline.current_season]
    false
  end
  # 3/4. All reqs satisfied? (children with 'pre' and 'co' as parent_rel)
  node.children.each do |child|
    unless timeline.satisfied?(child.course, child.parent_rel)
      return false
    end
  # 5/6. Make sure that quarter unit limit has not been exceeded (including
  # potential concurrent courses)
  end

  totalPotentialUnits =
    timeline.quarters[timeline.current_quarter].total_units +
    node.course.total_units

  if totalPotentialUnits > timeline.quarters[timeline.current_quarter].max_units
      return false # collectively exceed unit limit
  end
  # All tests passed
  true
end

# ******************************************************************************
# @desc Maps a path across quarters in the timeline
# @param timeline The timeline to operate on
# @param headOrigin The head of the consolidated one-path tree. This object is
#        copied so that the source tree is not mutated.
# ******************************************************************************
def mapTimeline(timeline, headOrigin)
  # TODO: assertion
  # assert isinstance(timeline, Timeline)
  # assert isinstance(headOrigin, Node)
  # TODO: ruby deep copy
  head = copy.deepcopy(headOrigin)
  # dict. of courses used to quickly check if course has already been placed
  addedCourses = {}
  # always start mapping (or remapping) at the first quarter
  timeline.current_quarter = 0 
  # 5. return once all descendents of head have been placed
  while head.children.length > 0
    # 6. Add any pre-existing courses in current quarter to the addedCourses
    # dict.
    timeline.quarters[timeline.current_quarter].courses.each do |course|
      addedCourses[course.cid] = true
    end
    # 7. recursively sort tree (DFS) by number of children, from least->most b/c
    #    a BFS is left->right, top->down and a stack is LIFO..making the bottom
    #    right node appear first
    dfsSort(head, false)
    putsTree(head)
    # 8. populate 'priority stack' about the head of tree
    priorityStack = createPriorityStack(head)
    putsPriorityStack(priorityStack)
    # 9. operate on each node in stack unless exit condition evals
    range(priorityStack.items.length).each do |i|
      node = priorityStack.pop
      # 10. Node's course exists in addedCourses dict.?
      if addedCourses.key?(node.course.cid)
        continue # move to next node in stack
      end
      # 11. Node's course passes eval for current quarter?
      unless courseDoesEval(node, timeline)
        continue # move to next node in stack
      end
      # 12. Add course and any concurrents to addedCourses dict. & current
      #     quarter in timeline. Undecided about the concurrent, so not adding
      #     that for now
      addedCourses[node.course.cid] = node.course
      timeline.quarters[timeline.current_quarter].courses.push(node.course)
      # 13. Current quarter's total units equal quarter's max_units?
      unless timeline.quarters[timeline.current_quarter].total_units == \
              timeline.quarters[timeline.current_quarter].max_units
        continue # move to next node in stack
      else
        break # move to next quarter, recomputing priority stack
      end
    end
    # 14. Increment current quarter
    timeline.current_quarter += 1 # move to next quarter
    # 14.2. Make sure that quarter exists
    if timeline.quarters.length == timeline.current_quarter
        seasonsMap = { 'fall' => 0, 'winter' => 1, 'spring' => 2 }
        seasons = ['fall', 'winter', 'spring']
        old_season = timeline.quarters[timeline.current_quarter-1].season
        new_season = seasons[(seasonsMap[old_season] + 1) % 3]
        timeline.quarters.push(Quarter([], new_season))
    end
    # 15. Mutate and cleanup the tree copy, `head`, from any nodes matching
    # courses in dict. temp for testing
    putsDictionary(addedCourses)
    dfsClean(head, addedCourses)
    putsTree(head)
    # 16. Return to step 5
  end
end

class User
  attr_accessor :id, :arr, :str, :num
  def initialize(arr = nil, str = nil, num = nil)
    @id = Random.new.rand(0..10)
    @arr = arr
    @str = str
    @num = num
  end
  def getId
    @id
  end
  def setId(id)
    @id = id
  end
  def sayHi
    puts("hi")
  end
end
#
# users = []
# for i in 0..5
#   users[i] = User.new
#   puts("New user with id=" + users[i].id.to_s)
# end
#
# puts("\nNow ordered as:")
#
# users.sort! { |a, b| b.id <=> a.id }
#
# for user in users
#   puts("  => " + user.id.to_s + ", " + user.object_id.to_s)
# end
#
# puts("Total length of " + users.length.to_s)
#
# users.each_with_index do |user, i|
#   puts("user id=" + user.getId.to_s + ", with i=" + i.to_s)
# end

users = [
  User.new([], 'fall', 19),
  User.new([], 'winter', 19),
  User.new([], 'spring', 19),
  User.new([], 'fall', 19),
  User.new([], 'winter', 19),
  User.new([], 'spring', 19),
  User.new([], 'fall', 19),
  User.new([], 'winter', 19),
  User.new([], 'spring', 19),
  User.new([], 'fall', 19),
  User.new([], 'winter', 19),
  User.new([], 'spring', 19),
  User.new([], 'fall', 19),
  User.new([], 'winter', 19),
  User.new([], 'spring', 19),
  User.new([], 'fall', 19),
  User.new([], 'winter', 19),
  User.new([], 'spring', 19)
]

users.each do |user|
  puts("User:")
  print("   arr=" + user.arr.to_s)
  print ', str=' + user.str
  puts(", num=" + user.num.to_s)

end

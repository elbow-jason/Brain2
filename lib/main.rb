require_relative 'address'
require_relative 'neuron'



#print "Enter X dimension : "
#x = gets.chomp.to_i

#print "Enter Y dimension : "
#y = gets.chomp.to_i

#print "Enter Z dimension : "
#z = gets.chomp.to_i

brain = Addr_maker.new

brain.generate(2,2,2) #generate addresses array

brain.make_symbols()
brain.make_addr_hash()
brain.make_dend_hash()

this_hash = brain.dend_hash()

this_hash.each { |k, v|  print k, " => ",v,"\n"}

this_array = []
this_array = this_hash[:neuron_0_0_0]

print this_array[0]
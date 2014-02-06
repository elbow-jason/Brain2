class Addr_maker

	def initialize
		@dimensions = []
		@coordinates = []
		@addr_sym_array = []
		@addr_hash = {}
		@dend_hash = Hash.new {|h,k| h[k]=[]}
	end



	# generate array of arrays in an [x,y,z] formate
	def generate(x_dem, y_dem, z_dem) 
		addresses = []
		@dimensions = [x_dem, y_dem, z_dem]
		for x in 0..x_dem
			for y in 0..y_dem
				for z in 0..z_dem
					addresses << [x, y, z]
				end
			end
		end
		@coordinates = addresses
		return addresses
	end


	# turn the array of addresses to array symbols in a ':neuron_0_0_0' format
	def make_symbols(addr = @coordinates)
		symbol_addr = []
		addr.length.times do |ele|
			symbol_addr << ("neuron_"+ addr[ele][0].to_s + "_" + addr[ele][1].to_s + "_" + addr[ele][2].to_s).to_sym
		end
		@addr_sym_array = symbol_addr
		return symbol_addr
	end


	# make hashes with symbols as keys and addesses as values
	def make_addr_hash(symb_array = @addr_sym_array, addr_array = @coordinates)
	  placeholder = {}
		addr_array.each_with_index { |v, i| placeholder.store(symb_array[i], v)  }
		@addr_hash = placeholder
		return placeholder
	end


	def make_dend_hash(symb_array = @addr_sym_array, num_dendrites_to_gen = 7)
		symb_array.each do |symb|
			dendhash = {}
			num_dendrites_to_gen.times do
				dend_array = []
				dend_array = grow_dendrite(symb, @addr_hash[symb] )
				@dend_hash[symb] << [ dend_array[1], dend_array[2], dend_array[3], dend_array[4]]
			end
		end	
	end 



	def grow_dendrite(symb, addr) # generate an address of a random coordinate within 10 units on each axis 
						  				# and return array of [x, y, z, distance]

		dendrite = []
		dendrite << symb

		[true,false].sample ? dendrite << addr[0]+rand(10) : dendrite << addr[0]+rand(10)
		[true,false].sample ? dendrite << addr[1]+rand(10) : dendrite << addr[1]+rand(10)
		[true,false].sample ? dendrite << addr[2]+rand(10) : dendrite << addr[2]+rand(10)
		
		hypotenuse = Math.sqrt(   (dendrite[1] - addr[0])**2  +  (dendrite[2] - addr[1])**2    ) 
		hypotenuse = Math.sqrt( hypotenuse**2 + (dendrite[2] - addr[1])**2  )
		hypotenuse = hypotenuse.to_i

		dendrite << hypotenuse
			
		return dendrite
	end
	

	def dend_hash
		return @dend_hash
	end


	def coordinates
		return @coordinates
	end



end
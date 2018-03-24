julia = {}

-- complex number is a table with two keys real "r", imaginary "i"
local function create_genf(c)
   return function(z)
      return {r=z.r*z.r-z.i*z.i+c.r,
	      i=2*z.r*z.i+c.i}
   end
end

function julia.generate(filename, height)
   local width = 2*height
   local step = 2/height
   print(string.format(
	    "Generating a julia set image %dx%d.", width, height))

   local fh = io.open(filename, "w+")
   fh:write(string.format(
	       "P6\n%d %d\n255\n", width, height))
   for j=-1,1-step,step do
      for i = -2,2-step,step do
	 -- complete the logic
	 local val = math.floor(256*math.abs(j))
	 fh:write(string.format(
		     "%c%c%c", val, val, val))
      end
   end
   fh:close()
end

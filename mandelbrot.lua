--[[
   Generate Mandelbrot set fractal images
--]]

mb = {}

function mb.generate_random(filename)
   print("Generating a random image.")
   local width = 256
   local height = 256
   local fh = io.open(filename, "w+")
   fh:write(string.format(
	       "P6\n%d %d\n255\n", width, height))
   for i=1,width do
      for j=1,height do
	 fh:write(string.format(
		     "%c%c%c", i % 256, j % 256,
		     math.floor(math.sin(i+j)*256)))
      end
   end
   fh:close()
end


local function create_mbf(c)
   return function(z)
      return {r = z.r*z.r-z.i*z.i+c.r, i = 2*z.r*z.i+c.i}
   end
end

local function divergence_level(f)
   --[[
      Calculate how rapidly the fixed point sequence of f diverges.
      If it doesn't diverge the return value must be zero.
      Very fast(i.e., fastest) must near to 256.

      This function might be the funnel point for this whole program.
      I'll have to check this calculation in C.
   --]]
   local max_val = 4
   local max_iteration = 1000
   local s = {r=0, i=0}
   local iter = 0
   repeat
      s = f(s)
      iter = iter + 1
   until s.r*s.r+s.i*s.i > max_val or iter > max_iteration
--   print("%f", iter/max_iteration)
   return iter/max_iteration
end


function mb.generate(filename, height)
   local fh = io.open(filename, "w+")

   local width = math.floor(3*height/2)
   local step = 2/height
   print(string.format(
	    "Generating a mandelbrot image %dx%d.",
	    width, height))
   fh:write(string.format(
	       "P6\n%d %d\n255\n", width, height))


   for j=-1,1-step,step do
      for i=-2,1-step,step do
	 local point = {r=i,
			i=j}
	 local func = create_mbf(point)
	 local val = 256*divergence_level(func)
	 val = math.floor(val)
	 fh:write(string.format(
		     "%c%c%c", val, val,val))
      end
   end
   fh:close()
end

local mb_lib = require 'mb'

-- check if a given point is within mandelbrot set or not.

local in_sample =
   {{0,0},
      {-1,1},
   }

local out_sample =
   {
      {1,1}
   }


local function check_samples()
   for sample in in_sample do
      assert (mb_lib.divergence_level(mb_lib.create_mbf(sample)) == 1)
   end
   for sample in out_sample do
      assert (mb_lib.divergence_level(mb_lib.create_mbf(sample)) == 0)
   end
end

function mandelbrot_test()
   check_samples()
end


"
 

 author: Atsushi Sakai
"

using Test
const __MAIN__ = length(PROGRAM_FILE)!=0 && occursin(PROGRAM_FILE, @__FILE__)

function main()
    println(PROGRAM_FILE," start!!")

    println(PROGRAM_FILE," Done!!")
end

if __MAIN__
    @time main()
end




"
 

 author: Atsushi Sakai
"

function main()
    println(PROGRAM_FILE," start!!")

    println(PROGRAM_FILE," Done!!")
end

if abspath(PROGRAM_FILE) == @__FILE__
    @time main()
end




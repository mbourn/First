#!/usr/bin/ruby
###############################################################################
#  Written  by: mbourn
#  Written  on: 9/5/14
#  Description: This is a script that searches the current directory, and all
#               subdirectories, for either filenames or text files containing
#               a specified string.  It then prints the results to the screen.
#               This is the long, readable version with verbose comments. 
###############################################################################

#  This line executes a bash command that lists all current and 
## subdirectories.  The result is saved in a variable
directory_string=`find .`

#  This line splits the string from above into an array using the
## \n between each line as the split between elements
array_of_paths=directory_string.split("\n").sort!

#  Print the first line
puts "Files with names that matches <#{ARGV[0]}>"
array_of_paths.each do |path|
	if ( path=~/.*#{ARGV[0]}\.((rb)|(erb)|(js)|(css)|(html)|(yml)|(txt))$/ )
		puts "  #{path}"
	end
end
puts "*" * 50
puts "Files with content that matches <#{ARGV[0]}>"


#  Loop through the array, test each element to see if it contains 
## a full path to a file, test that file to see if it has the proper
## file extension, grep it if it does, print results if any found.
not_first_pass=0
array_of_paths.each do |path|
	if ( path=~/.*\.((rb)|(erb)|(js)|(css)|(html)|(yml)|(txt))$/ )
		grep_result=`grep -ni \'#{ARGV[0]}\' #{path}`
		if ( grep_result.size > 0)
			not_first_pass==1 ? puts('-' * 50) : not_first_pass = 1 
			puts path
			grep_result_array=grep_result.split("\n")
			grep_result_array.each do |found_word| 
				puts "  #{found_word}"
			end
		end
	end
end
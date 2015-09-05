#!/usr/bin/env ruby

require 'readline'

inp = ""
ret = ""
out = ""
while cmd = Readline.readline('[e,s,c,r,i]> ', true)
	if cmd =~ /^e/ then
		print "# editing\n"
		while line = $stdin.gets
			inp += line
		end
		print "#passed:\n#{inp}"
	end
	if cmd =~ /^s/ then
		print "# show:\n#{inp}"
	end
	if cmd =~ /^c/ then
		print "# cleared\n"
		inp = ""
		ret = ""
		out = ""
	end
	if cmd =~ /^r/ then
		print "# running:\n"
		f = File.open("_.h", "w")
		f.write(inp)
		f.close()

		ret = `ghci < _.h`
		print ret
	end
	if cmd =~ /^i/ then
		out += "-\n"
		out += "  nam: <unset>\n"
		out += "  src: >\n"
		inp.split("\n").each do |l|
			out += "    #{l}\n"
		end
		out += "  exp:\n"
		ret.split("\n").select{ |l| l =~ /^P/ and not l =~ /Leaving/ }.each do |l|
			out += "    #{l}\n"
		end
		print out
	end
end

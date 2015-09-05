#!/usr/bin/env ruby

require 'readline'

home = ENV['HOME']
Dir.mkdir(home + "/.hs") if not File.exists?(home + "/.hs")
inp = ""
ret = ""
out = ""
fn = ""
while cmd = Readline.readline('[e,s,c,r,i,m,q]> ', true)
	case cmd
	when /^e/ then
		print "# editing\n"
		while line = $stdin.gets
			inp += line
		end
		print "#passed:\n#{inp}"
		fn = Time.new.strftime(home + "/.hs/%Y%m%d_%H%M%S")
		f = File.open(fn, "w")
		written = f.write(inp)
		f.close()
		print "# #{fn} written #{written} bytes\n"
	when /^s/
		print "# show:\n#{inp}"
	when /^c/
		print "# cleared\n"
		inp = ""
		ret = ""
		out = ""
		fn = ""
	when /^r/
		print "# running:\n"
		ret = `ghci < _.h`
		print ret
	when /^m/
		last_fi = 0
		files = []
		Dir.open(home + "/.hs")
				.select{ |f| not f =~ /^\./ }
				.map{ |f| home + "/.hs/" + f }
				.each_with_index do |f, fi|
			print "%03d %s\n" % [fi, f]
			files << f
			last_fi = fi
		end
		which = gets.scan(/\d+/)[0].to_i
		if which > last_fi then
			print "Number #{which} to big. #{last_fi} is the last one"
		else
			fn = files[which]
			system("vim #{fn}")
			inp = `cat #{fn}`
		end
	when /^i/
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
	when /^q/
		exit 0
	end
end

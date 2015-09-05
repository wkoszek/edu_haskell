#!/usr/bin/env ruby

require 'readline'

home = ENV['HOME']
Dir.mkdir(home + "/.hs") if not File.exists?(home + "/.hs")
cmdi = 0
inp = ""
ret = ""
out = ""
fn = ""
name = ""
while cmd = Readline.readline(("[e,s,c,r,i,m,n,w,q] %3d >" % cmdi), true)
	cmdi += 1
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
		ret = `ghci < #{fn} 2>&1`
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
	when /^n/
		print "# Enter program's name:\n"
		name = gets.strip()
		print "# Got name #{name}\n"
	when /^i/
		out = "-\n"
		out += "  nam: #{name}\n"
		out += "  src: |\n"
		inp.split("\n").each do |l|
			out += "    #{l}\n"
		end
		out += "  exp: |\n"
		ret.split("\n").each do |l|
				#.select{ |l| l =~ /^P/ and not l =~ /Leaving/ }
			out += "    #{l}\n"
		end
		print out
	when /^w/
		tmp = "#{fn}.yml"
		f = File.open(tmp, "w")
		f.write(out)
		f.close()
		print "# #{tmp} written #{out.length} bytes\n"
	when /^q/
		exit 0
	else
		print "unknown command\n"
	end
end

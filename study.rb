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
cmdbuf = [ 'h' ]
while not cmdbuf.empty?
	cmd = cmdbuf.pop()
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
		name = ""
	when /^r/
		print "# running:\n"
		ret = `ghci < #{fn} 2>&1`
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
		ret.split("\n")
				.select{ |l| not l =~ /(version|Loading|Leaving)/ }
				.each do |line|
			out += "    #{line}\n"
		end
		print out
	when /^w/
		tmp = "#{fn}.yml"
		f = File.open(tmp, "w")
		f.write(out)
		f.close()
		print "# #{tmp} written #{out.length} bytes\n"
	when /^a/
		print "# Appending\n"
		f = File.open("haskell.yml", "a")
		f.write(out)
		f.close()
	when /^h/
		print "# help\n"
		print "# popular: enriac\n"
		print "e: edit    s: show   n: name   r: run   i: inspect\n"
		print "m: modify  w: write  q: quit   h: help\n"
	when /^q/
		exit 0
	else
		print "unknown command\n"
	end

	while cmdbuf.empty?
		cmd = Readline.readline(("[e,s,c,r,i,m,n,w,q] %3d >" % cmdi), true)
		cmdbuf = cmd.split("").reverse
	end
	cmdi += 1
end

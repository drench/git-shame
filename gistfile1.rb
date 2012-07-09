#!/usr/bin/env ruby

branches = {}

IO.popen('git branch -a', 'r').each.grep(%r{^\s+remotes/origin/\d+}) do |branch|
    branch.sub!(%r{\s+remotes/}, '')
    branch.chomp!
    author = `git log -1 --format=%ae #{branch}`
    author.chomp!
    branches[author] ||= []
    branches[author] << branch
end

branches.each_pair do |k,v|
    print "#{k}:\n"
    v.each do |branch|
        print "\t#{branch}\n"
    end
    print "\n"
end
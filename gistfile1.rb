#!/usr/bin/env ruby

branches = {}

IO.popen('git branch -a', 'r').grep(%r{^\s+remotes/origin/\S+$}).map { |b| b.sub(%{\s+remotes/}, '').chomp }.each do |branch|
    committer, rel_commit_date, timestamp = `git log -1 --format='%ce%n%cr%n%ct' #{branch}`.chomp.split(/\n/)
    branches[committer] ||= []
    branches[committer] << [ branch, rel_commit_date, timestamp ]
end

branches.each_pair do |k,v|
    print "#{k}:\n"
    v.sort { |a,b| a[2] <=> b[2] }.map { |b| b[0] + ' (last commit ' + b[1] + ')' }.each do |branch|
        print "\t#{branch}\n"
    end
    print "\n"
end

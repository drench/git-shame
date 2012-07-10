#!/usr/bin/env ruby

branches = {}

IO.popen('git branch -a', 'r').each.grep(%r{^\s+remotes/origin/\d+}) do |branch|
    branch.sub!(%r{\s+remotes/}, '')
    branch.chomp!
    author, commit_date = `git log -1 --format='%ae%n%ar' #{branch}`.split(/\n/)
    commit_date.chomp!
    branches[author] ||= []
    branches[author] << "#{branch} (last commit #{commit_date})"
end

branches.each_pair do |k,v|
    print "#{k}:\n"
    v.each do |branch|
        print "\t#{branch}\n"
    end
    print "\n"
end

#!/usr/bin/env ruby

use_color = STDOUT.tty?
begin
    require 'colored' if use_color
rescue LoadError
    use_color = false
end

unless use_color
    class String
        %w(blue green magenta red yellow).each do |color|
            define_method(color.to_sym) { self }
        end
    end
end

branches = {}
$merged_branches = {}

IO.popen('git branch -r --no-color --merged', 'r').grep(%r{^\s+origin/\S+$}).map { |b| b.sub(%r{\s+}, '').chomp }.each do |branch|
    $merged_branches[branch] = true
end

def is_merged? (branch)
    $merged_branches.has_key?(branch) && $merged_branches[branch];
end

IO.popen('git branch -r --no-color', 'r').grep(%r{^\s+origin/\S+$}).map { |b| b.chomp.sub(/^\s+/, '') }.each do |branch|
    committer, rel_commit_date, timestamp = `git log -1 --format='%ce%n%cr%n%ct' #{branch}`.chomp.split(/\n/)
    branches[committer] ||= []
    branches[committer] << [ branch, rel_commit_date, timestamp ]
end

branches.keys.sort { |a,b| branches[b].length <=> branches[a].length }.map { |k| [k, branches[k]] }.each do |b|
    k = b[0]
    v = b[1]
    print "#{k}:\n".yellow
    v.sort { |a,b| a[2] <=> b[2] }.map { |b|
        b[0].green + ' (last commit ' + b[1] + ', ' + (is_merged?(b[0]) ? 'merged'.magenta : 'NOT MERGED'.red) + ')'
    }.each do |branch|
        print "\t#{branch}\n"
    end
    print "\n"
end

require "rubycritic/rake_task"

RubyCritic::RakeTask.new do |task|
  # Name of RubyCritic task. Defaults to :rubycritic.
  task.name = 'scan_project'

  desc 'Automatic code-review report'

  # Glob pattern to match source files. Defaults to FileList['.'].
  task.paths = FileList['vendor/**/*.rb']

  # You can pass all the options here in that are shown by "rubycritic -h" except for
  # "-p / --path" since that is set separately. Defaults to ''.
  task.options = '--path test_output/codereview app lib/timesheet'

  # Defaults to false
  task.verbose = true
end
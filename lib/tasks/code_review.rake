namespace :macain do
	begin
		require 'rubycritic/cli/application'
		desc 'Automatic code-review report'
		task :codereview do
			arguments = [ '--path', 'test_output/codereview', 'app', 'lib/timesheet' ]
			app = Rubycritic::Cli::Application.new arguments
			app.execute
		end
	rescue LoadError
		desc '[Unavailable] Automatic code-review report'
		task :codereview do
			puts 'Needs "rubycritic" gem installed'
		end
	end
end

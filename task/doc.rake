namespace :doc do
  desc 'Generates YARD documentation'
  task :build do
    sh 'yard'
  end
end

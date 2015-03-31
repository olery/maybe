namespace :doc do
  desc 'Generates YARD documentation'
  task :build => :generate do
    sh 'yard'
  end
end
